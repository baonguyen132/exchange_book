// import 'dart:async';
// import 'package:flutter/services.dart';
// import 'package:local_auth/local_auth.dart';
//
// class Authentication {
//   static final LocalAuthentication _auth = LocalAuthentication();
//
//   // Kiểm tra thiết bị có hỗ trợ xác thực sinh trắc không
//   static Future<bool> canAuthenticate() async {
//     try {
//       return await _auth.canCheckBiometrics || await _auth.isDeviceSupported();
//     } catch (e) {
//       print("Error checking biometric support: $e");
//       return false;
//     }
//   }
//
//   static Future<bool> authenticateUser() async {
//     if (!await canAuthenticate()) {
//       print("Biometric authentication not available.");
//       return false;
//     }
//
//     try {
//       final bool didAuthenticate = await _auth.authenticate(
//         localizedReason: 'Please authenticate to show account balance',
//         options: const AuthenticationOptions(
//           useErrorDialogs: true,
//           stickyAuth: true,
//           biometricOnly: true,
//         ),
//       );
//
//       // ✅ Nếu xác thực thành công, trả về true
//       if (didAuthenticate) {
//         print("✅ Authenticated successfully");
//         return true;
//       } else {
//         // ❌ Nếu không xác thực hoặc bị hủy, trả về false
//         print("❌ Authentication failed or cancelled");
//         return false;
//       }
//
//     } on PlatformException catch (e) {
//       // Các lỗi liên quan đến biometrics
//       switch (e.code) {
//         case 'NotAvailable':
//           print("⚠️ Biometric hardware not available.");
//           break;
//         case 'NotEnrolled':
//           print("⚠️ No biometrics enrolled on this device.");
//           break;
//         case 'LockedOut':
//           print("🔒 Too many attempts. Device is locked.");
//           break;
//         default:
//           print("Authentication error: ${e.message}");
//       }
//       return false; // Nếu có lỗi thì trả về false
//     } catch (e) {
//       print("Unexpected error: $e");
//       return false; // Trả về false nếu có lỗi không mong muốn
//     }
//   }
// }
