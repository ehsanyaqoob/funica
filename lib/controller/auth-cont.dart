
// import 'package:get/get.dart';
// import 'package:funica/constants/export.dart';

// class AuthController extends GetxController {
//   var isLoading = false.obs;
//   var obscurePassword = true.obs;
//   var rememberMe = false.obs;
//   var agreeToTerms = false.obs;
  
//   // Add text controllers
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   @override
//   void onClose() {
//     nameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     super.onClose();
//   }

//   /// ================= LOGIN =================
//   Future<void> login(String email, String password) async {
//     try {
//       isLoading(true);

//       await Future.delayed(const Duration(seconds: 2));

//       if (email.isEmpty || !email.contains('@')) {
//         AppToast.error('Please enter a valid email'.tr);
//         return;
//       }
//       if (password.isEmpty || password.length < 6) {
//         AppToast.error('Password must be at least 6 characters'.tr);
//         return;
//       }

//       // Success
//       AppToast.success('Login successful'.tr);

//       // ✅ Navigate to BottomNavbar and clear history
//       Get.offAll(() => MainNavigation());

//     } catch (e) {
//       AppToast.error('Login failed: ${e.toString()}'.tr);
//     } finally {
//       isLoading(false);
//     }
//   }

//   /// ================= SIGNUP =================
//   Future<void> signup(String name, String email, String password) async {
//     try {
//       isLoading(true);

//       await Future.delayed(const Duration(seconds: 2));

//       if (name.isEmpty) {
//         AppToast.error('Please enter your name'.tr);
//         return;
//       }
//       if (email.isEmpty || !email.contains('@')) {
//         AppToast.error('Please enter a valid email'.tr);
//         return;
//       }
//       if (password.isEmpty || password.length < 6) {
//         AppToast.error('Password must be at least 6 characters'.tr);
//         return;
//       }
//       if (!agreeToTerms.value) {
//         AppToast.error('Please agree to terms and conditions'.tr);
//         return;
//       }

//       // Success
//       AppToast.success('Signup successful! Welcome to Formify'.tr);

//       // ✅ Navigate to BottomNavbar and clear history
//       Get.offAll(() => MainNavigation());

//     } catch (e) {
//       AppToast.error('Signup failed: ${e.toString()}'.tr);
//     } finally {
//       isLoading(false);
//     }
//   }

//   /// ================= TOGGLES =================
//   void togglePasswordVisibility() => obscurePassword(!obscurePassword.value);
//   void toggleRememberMe(bool? value) => rememberMe(value ?? false);
//   void toggleAgreeToTerms(bool? value) => agreeToTerms(value ?? false);
// }