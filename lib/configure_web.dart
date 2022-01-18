import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:firebase_core/firebase_core.dart';

void configureApp() {
  setUrlStrategy(PathUrlStrategy());
}

Future<FirebaseApp> initializeApp() {
  return Firebase.initializeApp(
      options: const FirebaseOptions(
      apiKey: "AIzaSyAkosczGLQBjng85sHD6kQoeX6T-1oLh1E",
      appId: "1:180543049748:web:58fa4e085f07100794d701",
      messagingSenderId: "180543049748",
      projectId: "minitb-rs",
      authDomain: "minitb-rs.firebaseapp.com",
      databaseURL: "https://minitb-rs.firebaseio.com",
      storageBucket: "minitb-rs.appspot.com",
  ));
}
