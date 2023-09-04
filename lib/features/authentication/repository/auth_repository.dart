import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
}
