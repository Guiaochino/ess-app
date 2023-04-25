
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class StorageServices {

  final String uid;

  StorageServices({ required this.uid });

  // Initialize the storage
  static FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadFile(File file) async {
    String filename = basename(file.path);
    Reference userFolder = storage.ref().child('users/$uid');
    UploadTask upload = userFolder.putFile(file);
    TaskSnapshot task = await upload.whenComplete(() => null);
    String URL = await task.ref.getDownloadURL();
    return URL;
  }

  Stream<List<String>> images() => storage.ref().child('users/$uid').listAll().then((value) async {
    List<String> URLs = [];
    for (Reference ref in value.items) {
      String URL = await ref.getDownloadURL();
      URLs.add(URL);
    }
    return URLs;
  }).asStream();

  Future<void> deleteFile(String path) async {
    Reference storageRef = storage.ref().child(path);
    await storageRef.delete();
  }

}