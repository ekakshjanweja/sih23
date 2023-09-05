import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sih_chatbot/common/utils/utils.dart';
import 'package:sih_chatbot/features/authentication/repository/auth_repository.dart';
import 'package:sih_chatbot/models/user_model.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

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

  Future<UserModel?> getUserData() async {
    UserModel? user = await _authRepository.getCurrentUserData();
    return user;
  }

  //Sign In With Phone Number

  void signInWithPhone({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    state = true;

    final otpSuccess =
        await _authRepository.signInWithPhone(phoneNumber: phoneNumber);

    state = false;

    otpSuccess.fold(
      (l) => showSnackBar(context: context, content: l.message),
      (r) => null,
    );
  }
}
