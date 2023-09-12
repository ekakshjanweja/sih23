import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sih_chatbot/common/utils/utils.dart';
import 'package:sih_chatbot/features/authentication/repository/auth_repository.dart';
import 'package:sih_chatbot/features/home/views/home_page.dart';
import 'package:sih_chatbot/models/user_model.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final newUserOnboardingProvider = StateProvider<UserModel?>((ref) => null);

final verificationProvider = StateProvider<String?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  ),
);

final authStateChangesProvider = StreamProvider(
  (ref) {
    final authController = ref.watch(authControllerProvider.notifier);
    return authController.authStateChanges;
  },
);

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;

  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        super(false);

  //User's Stream

  Stream<User?> get authStateChanges => _authRepository.authStateChanges;

  //Get Current User Data

  Future<UserModel?> getUserData({
    required String uid,
  }) async {
    UserModel? user = await _authRepository.getCurrentUserData(
      uid: uid,
    );
    return user;
  }

  //Sign In With Phone Number

  void signInWithPhone({
    required BuildContext context,
    required WidgetRef ref,
    required String phoneNumber,
  }) async {
    state = true;

    final otpSuccess = await _authRepository.signInWithPhone(
      phoneNumber: phoneNumber,
      ref: ref,
    );

    state = false;

    otpSuccess.fold(
      (l) => showSnackBar(context: context, content: l.message),
      (r) => ref.read(verificationProvider.notifier).update((state) => r),
    );
  }

  //Verify OTP

  void verifyOTP({
    required BuildContext context,
    required WidgetRef ref,
    required String userOTP,
  }) async {
    final otpVerification = await _authRepository.verifyOTP(
      ref: ref,
      verificationId: ref.read(verificationProvider.notifier).state!,
      userOTP: userOTP,
    );

    otpVerification.fold(
      (l) => showSnackBar(context: context, content: l.message),
      (r) {
        Routemaster.of(context).popUntil((routeData) => false);
        Routemaster.of(context).push(HomePage.routeName);
      },
    );
  }

  //Logout

  void logout() {
    _authRepository.logOut();
  }
}
