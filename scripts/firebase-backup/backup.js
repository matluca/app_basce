/* eslint-disable no-console */
const fs = require("fs");
const path = require("path");
const admin = require("firebase-admin");

const SCRIPT_DIR = __dirname;
const CREDENTIALS_PATH =
  process.env.GOOGLE_APPLICATION_CREDENTIALS ||
  path.join(SCRIPT_DIR, "serviceAccountKey.json");

// Safety limit to avoid accidental huge dumps in one run.
const MAX_DOCS = Number(process.env.MAX_DOCS || "200000");

function pad(n) {
  return String(n).padStart(2, "0");
}

function backupFileName() {
  const now = new Date();
  const dd = pad(now.getDate());
  const mm = pad(now.getMonth() + 1);
  const yy = String(now.getFullYear()).slice(-2);
  return `backup-${dd}-${mm}-${yy}.json`;
}

function initFirebase() {
  if (!fs.existsSync(CREDENTIALS_PATH)) {
    throw new Error(
      `Credentials file not found at: ${CREDENTIALS_PATH}\n` +
        "Set GOOGLE_APPLICATION_CREDENTIALS or place serviceAccountKey.json in this folder."
    );
  }

  const serviceAccount = require(CREDENTIALS_PATH);
  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
  });

  return admin.firestore();
}

async function exportCollectionRecursive(collectionRef, counters) {
  const snapshot = await collectionRef.get();
  const docs = [];

  for (const docSnap of snapshot.docs) {
    counters.totalDocs += 1;
    if (counters.totalDocs > MAX_DOCS) {
      throw new Error(
        `Aborted: reached MAX_DOCS=${MAX_DOCS}. Increase MAX_DOCS if expected.`
      );
    }

    const data = docSnap.data();
    const docOut = {
      id: docSnap.id,
      data,
      subcollections: {},
    };

    const subcollections = await docSnap.ref.listCollections();
    for (const subcol of subcollections) {
      docOut.subcollections[subcol.id] = await exportCollectionRecursive(
        subcol,
        counters
      );
    }

    docs.push(docOut);
  }

  return docs;
}

async function exportAll(db) {
  const rootCollections = await db.listCollections();
  const result = {};
  const counters = { totalDocs: 0 };

  for (const col of rootCollections) {
    console.log(`Exporting collection: ${col.id}`);
    result[col.id] = await exportCollectionRecursive(col, counters);
  }

  return { exportedAt: new Date().toISOString(), totalDocs: counters.totalDocs, data: result };
}

async function main() {
  try {
    const db = initFirebase();
    const exported = await exportAll(db);

    const outPath = path.join(SCRIPT_DIR, backupFileName());
    fs.writeFileSync(outPath, JSON.stringify(exported, null, 2), "utf8");

    console.log(`Backup completed: ${outPath}`);
    console.log(`Total docs exported: ${exported.totalDocs}`);
    process.exit(0);
  } catch (err) {
    console.error("Backup failed:");
    console.error(err && err.stack ? err.stack : err);
    process.exit(1);
  }
}

main();