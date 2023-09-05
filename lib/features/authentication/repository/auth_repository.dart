import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sih_chatbot/common/providers/firebase_providers.dart';
import 'package:sih_chatbot/core/failure.dart';
import 'package:sih_chatbot/core/type_defs.dart';
import 'package:sih_chatbot/models/user_model.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(
    firebaseAuth: ref.read(firebaseAuthProvider),
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
  ),
);

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  AuthRepository({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
  })  : _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore;

  //User's Collection Ref

  CollectionReference get _users => _firebaseFirestore.collection('users');

  //User's Stream

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  //Get Current User Data

  Future<UserModel?> getCurrentUserData() async {
    final userData = await _users.doc(_firebaseAuth.currentUser!.uid).get();

    UserModel? user;

    if (userData.data() != null) {
      user = UserModel.fromMap(
        userData.data()! as Map<String, dynamic>,
      );
    }

    return user;
  }

  //Sign In With Phone Number

  FutureEither<OTPSent> signInWithPhone({
    required String phoneNumber,
  }) async {
    OTPSent? otpSentSuccess;
    try {
      await _firebaseAuth.verifyPhoneNumber(
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          throw error.message!;
        },
        codeSent: (String verificationId, int? forceResendingToken) async {
          otpSentSuccess = OTPSent(
            successMessage: 'OTP Sent Successfully',
            verificationId: verificationId,
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) async {},
        phoneNumber: phoneNumber,
      );

      if (otpSentSuccess == null) {
        throw 'Something went wrong';
      }

      return right(otpSentSuccess!);
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}

class OTPSent {
  final String successMessage;
  final String verificationId;

  OTPSent({
    required this.successMessage,
    required this.verificationId,
  });
}
