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
      await user.reload();
      changeName(user.displayName);
      changeEmail(user.email);
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
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
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
      if (user != null) {
        changeName(user.displayName);
        changeEmail(user.email);
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
    }

    return refreshedUser;
  }
}
