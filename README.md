# App Bascé

The App Bascé is the unofficial app for the Chattina Bascé.
The App is developed as a Flutter application, and could be released for Android, iOS and as web
application.

### Build app for Android

For building the app and creating APK releases for Android, go to the project root and run
```
flutter build apk --split-per-abi
```
This procuced three APK files and stores them in `./build/app/outputs/apk/release`. In order to
create a fat APK, remove the `--split-per-abi` flag. The right APK for a 64bit device is
`app-arm64-v8a-release.apk`.

See [Build and release an Android app](https://flutter.dev/docs/deployment/android) for further
details.

### Build web app

For building the app for a web version release, go to the project root and run
```
flutter build web
```
This generates all the necessary files in `./build/web`. To test locally, launch a web server.
For example, navigate to `./build/web` and run `python -m http.server 8080`, which makes the web
version available under `localhost:8080`.

See [Build and release a web app](https://flutter.dev/docs/deployment/web) for further
details.

The web version is also available at [matluca.github.io](https://matluca.github.io) at the moment.
