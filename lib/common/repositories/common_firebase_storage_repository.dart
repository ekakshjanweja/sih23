import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sih_chatbot/common/providers/firebase_providers.dart';

final commonFirebaseStorageRepositoryProvider =
    Provider<CommonFirebaseStorageRepository>(
  (ref) => CommonFirebaseStorageRepository(
    firebaseStorage: ref.read(
      firebaseStorageProvider,
    ),
  ),
);

class CommonFirebaseStorageRepository {
  final FirebaseStorage _firebaseStorage;

  CommonFirebaseStorageRepository({
    required FirebaseStorage firebaseStorage,
  }) : _firebaseStorage = firebaseStorage;

  //Save File To Firebase Storage

  Future<String> saveFileToFirebaseStorage({
    required String ref,
    required File file,
  }) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot takeSnapshot = await uploadTask;
    String downloadUrl = await takeSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
