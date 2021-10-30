# mightymeteoapp

Build the App :

You must install Flutter at least 2.5.0.
Follow this link to install properly flutter :
https://flutter.dev/docs/get-started/install

When it's done, open a terminal at the root of the app.
Do the following command "flutter pub get", this command will install the differents packages need by the app.
Now you are ready to build the app.

Build Android :

At the root of the project : flutter build apk

Build Ios :
This build will fail if it isn't done on a mac.
You need to install Cocoapods.
Move to the directory ios.
Do the following command "pod install".
Move back to the root of the project then : flutter build ios
