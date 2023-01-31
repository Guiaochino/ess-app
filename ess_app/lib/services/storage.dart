import 'package:firebase_storage/firebase_storage.dart';

class StorageServices {

  final String uid;

  StorageServices({ required this.uid });

  final storage = FirebaseStorage.instance.ref();

  

}