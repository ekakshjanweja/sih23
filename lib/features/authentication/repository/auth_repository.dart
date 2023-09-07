import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sih_chatbot/common/providers/firebase_providers.dart';
import 'package:sih_chatbot/core/failure.dart';
import 'package:sih_chatbot/core/type_defs.dart';
import 'package:sih_chatbot/features/authentication/controller/auth_controller.dart';
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

  Future<UserModel?> getCurrentUserData({
    required String uid,
  }) async {
    final userData = await _users.doc(uid).get();

    UserModel? user;

    if (userData.data() != null) {
      user = UserModel.fromMap(
        userData.data()! as Map<String, dynamic>,
      );
    }

    return user;
  }

  //Sign In With Phone Number

  FutureEither<String> signInWithPhone({
    required WidgetRef ref,
    required String phoneNumber,
  }) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          throw error.message!;
        },
        codeSent: (String verificationId, int? forceResendingToken) async {
          ref
              .read(verificationProvider.notifier)
              .update((state) => verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) async {
          throw 'Auto Retrieval Timeout';
        },
        phoneNumber: phoneNumber,
      );

      return right(ref.read(verificationProvider.notifier).state!);
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  //Verify OTP

  FutureEither<UserModel> verifyOTP({
    required WidgetRef ref,
    required String verificationId,
    required String userOTP,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      UserModel userModel;

      if (userCredential.additionalUserInfo!.isNewUser) {
        userModel = ref.read(newUserOnboardingProvider.notifier).state!;

        await _users.doc(_firebaseAuth.currentUser!.uid).set({
          'name': userModel.name,
          'phone': userModel.phone,
          'uid': _firebaseAuth.currentUser!.uid,
        });

        await _users
            .doc(_firebaseAuth.currentUser!.uid)
            .collection('chats')
            .doc('chatRooms')
            .set({'chatRooms': {}});
      } else {
        userModel = ref.read(userProvider.notifier).state!;
      }

      return right(userModel);
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  //Log Out

  void logOut() async {
    await _firebaseAuth.signOut();
  }
}
