import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class UserController extends GetxController {
  final RxString _name = "".obs;
  changeName(name) => _name.value = name;
  getName() => _name.value;

  final RxString _email = "".obs;
  changeEmail(email) => _email.value = email;
  getEmail() => _email.value;

  final RxString _password = "".obs;
  changePassword(password) => _name.value = password;
  getPassword() => _password.value;

  final RxString _photoUrl = "https://i.imgur.com/VAnsyjv.jpeg".obs;
  changePhotoUrl(photoUrl) => _photoUrl.value = photoUrl;
  getPhotoUrl() => _photoUrl.value;

  final RxString _errorMessage = "".obs;
  changeErrorMessage(errorMessage) => _errorMessage.value = errorMessage;
  getErrorMessage() => _errorMessage.value;

  final RxBool _isVerified = false.obs;
  changeVerified(verified) => _isVerified.value = verified;
  getVerified() => _isVerified.value;

  User? _user;
  changeUser(User? user) => _user = user;
  getUser() => _user;

  User? _currentUser;
  changeCurrentUser(User user) => _currentUser = user;
  getCurrentUser() => _currentUser;

  bool _isProcessing = false;
  changeProcess(process) => _isProcessing = process;
  getProcess() => _isProcessing;

  bool _isSendingVerification = false;
  changeSending(sending) => _isSendingVerification = sending;
  getSending() => _isSendingVerification;

  bool _isSigningOut = false;
  changeSignInOut(signintout) => _isSigningOut = signintout;
  getSignInOut() => _isSigningOut;

  Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      changeUser(user);
      changeCurrentUser(user);
      changeName(user.displayName);
      changeEmail(user.email);
      changePhotoUrl(user.photoURL);
      changeVerified(user.emailVerified);
      Get.toNamed("/profile");
    }
    return firebaseApp;
  }

  Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.updatePhotoURL('https://i.imgur.com/KyVwI6r.jpeg');
      await user.reload();
      user = auth.currentUser;
      if (user != null) {
        changeName(user.displayName);
        changeEmail(user.email);
        changePhotoUrl(user.photoURL);
        changeVerified(user.emailVerified);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        changeErrorMessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        changeErrorMessage('The account already exists for that email.');
      }
    } catch (e) {
      changeErrorMessage(e);
    }
    return user;
  }

  Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      user = auth.currentUser;
      if (user != null) {
        changeName(user.displayName);
        changeEmail(user.email);
        changePhotoUrl(user.photoURL);
        changeVerified(user.emailVerified);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        changeErrorMessage('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        changeErrorMessage('Wrong password provided.');
      }
    }

    return user;
  }

  Future<User?> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await user.reload();
    User? refreshedUser = auth.currentUser;
    if (refreshedUser != null) {
      changeName(refreshedUser.displayName);
      changeEmail(refreshedUser.email);
      changePhotoUrl(refreshedUser.photoURL);
      changeVerified(refreshedUser.emailVerified);
    }

    return refreshedUser;
  }
}
