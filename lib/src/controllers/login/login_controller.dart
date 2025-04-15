import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/controllers/local_storage/local_storage_controller.dart';
import 'package:poster_sale_user/src/data/models/user/add_user_model.dart';
import '../../constants/local_storage.dart';
import '../../data/repository/repository.dart';
import '../../routes/app_routes.dart';
import '../bottom_navbar/bottom_navbar_controller.dart';

class LoginController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final Repository repository;
  LoginController({required this.repository});

  @override
  onInit() {
    super.onInit();
    tabController = TabController(length: tabLength, vsync: this);

    tabController!.addListener(() {
      selectedIndex.value = tabController!.index;
    });
  }

  // Controllers
  var tabLength = 3;
  TabController? tabController;

  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var repeatPasswordController = TextEditingController();

  var signInEmailController = TextEditingController();
  var signInPasswordController = TextEditingController();

  var forgetPasswordEmailController = TextEditingController();
  // ***********************************************

  // Variables
  var selectedIndex = 0.obs;
  var isPasswordOn = false.obs;
  var isSignPasswordOn = false.obs;
  var isLoading = false.obs;

  // ***********************************************

  // Authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign Up (Register)
  Future<bool> signUp() async {
    try {
      if (!isPasswordValid(passwordController.text)) {
        repository.errorHandler(
          title: "Invalid password format!",
          message:
              "Ensure your password has at least 8 characters, including 1 uppercase, 1 lowercase, 1 number, and 1 special character.",
        );

        return false;
      }

      if (!isPasswordValid(repeatPasswordController.text)) {
        repository.errorHandler(
          title: "Invalid password format!",
          message:
              "Ensure your password has at least 8 characters, including 1 uppercase, 1 lowercase, 1 number, and 1 special character.",
        );

        return false;
      }

      if (passwordController.text != repeatPasswordController.text) {
        repository.errorHandler(
          title: "Password Mismatch",
          message: "Passwords do not match. Please try again.",
        );
        return false;
      }

      isLoading.value = true;

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      bool isFinishedCorrectly = await handleUserInfo(userCredential);

      if (isFinishedCorrectly) {
        await repository.postData(
          collection: "users",
          data: AddUserModel(
            email: emailController.text,
            name: nameController.text,
            timestamp: DateTime.now(),
            id: userCredential.user!.uid,
          ).toJson(),
        );

        return true;
      }

      repository.errorHandler(
        title: "Could not sign up!",
        message: "Could not finish sign up process.",
      );

      return false;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      repository.errorHandler(
        title: "Could not sign up!",
        message: e.message ?? "Could not finish authentication.",
      );
      return false;
    }
  }

  // Sign In (Login)
  Future<bool> signIn() async {
    try {
      if (!isPasswordValid(signInPasswordController.text)) {
        repository.errorHandler(
          title: "Invalid password format!",
          message:
              "Ensure your password has at least 8 characters, including 1 uppercase, 1 lowercase, 1 number, and 1 special character.",
        );

        return false;
      }

      isLoading.value = true;

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: signInEmailController.text,
        password: signInPasswordController.text,
      );
      return handleUserInfo(userCredential);
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      repository.errorHandler(
        title: "Could not sign in!",
        message: e.message ?? "Authentication failed. Please try again.",
      );
      return false;
    }
  }

  // Reset password
  Future<void> sendPasswordResetEmail() async {
    try {
      isLoading.value = true;

      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: forgetPasswordEmailController.text);
      repository.showMessage(
        title: "Password reset request",
        message: "Check your inbox for instructions to reset your password.",
      );

      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      repository.errorHandler(
        title: "Password reset.",
        message: e.message ?? "Password reset failed. Please try again.",
      );
    }
  }

  // Save Token
  Future<bool> handleUserInfo(UserCredential userCredential) async {
    var user = userCredential.user;

    if (user == null) {
      isLoading.value = false;
      repository.errorHandler(
        title: "Authentication Failed",
        message: "User not found. Please try again.",
      );

      return false;
    }

    var token = await user.getIdToken();
    if (token == null) {
      isLoading.value = false;
      repository.errorHandler(
        title: "Authentication Failed",
        message: "Invalid token. Please try again.",
      );

      return false;
    }

    print("The token " + token);

    var localStorageController = Get.find<LocalStorageController>();
    localStorageController.saveStringToLocal(LocalStorageConst.jwtToken, token);
    localStorageController.saveBooleanToLocal(LocalStorageConst.login, false);
    localStorageController.saveStringToLocal(
      LocalStorageConst.startPage,
      Routes.BOTTOM,
    );

    isLoading.value = false;

    Get.offAllNamed(Routes.BOTTOM)!.then(
      (value) => Get.put<BottomNavBarController>(
        BottomNavBarController(
          repository: Repository(firestore: FirebaseFirestore.instance),
        ),
      ),
    );
    return true;
  }

  // Password checker
  bool isPasswordValid(String password) {
    // Regex for: Minimum 8 characters, 1 uppercase, 1 lowercase, 1 number, 1 special character
    final regex = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return regex.hasMatch(password);
  }

  // ********************************************
}
