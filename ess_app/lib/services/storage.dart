
import 'dart:async';
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

  Future<String> uploadImage(String path, File file) async{
    String _imageUrl;
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirImages.child(path);
    UploadTask uploadTask = referenceImageToUpload.putFile(File(file.path));

    Completer<String> completer = Completer<String>();

    // Wait for the uploadTask to complete
    await uploadTask.whenComplete(() async {
      _imageUrl = await referenceImageToUpload.getDownloadURL();
      completer.complete(_imageUrl);
    });

    // Return the Future<String> returned by the Completer
    return completer.future;

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