import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DataBase{
  static Reference? iconStorage;
  static late final FirebaseApp db;

  static connect() async{
   FirebaseOptions options = FirebaseOptions(
    apiKey: dotenv.env['API_KEY'] ?? '',
    appId: dotenv.env['APP_ID'] ?? '',
    messagingSenderId: '',
    projectId: dotenv.env['PROJECT_ID'] ?? '',
    storageBucket: dotenv.env['STORAGE_BUCKET'] ?? '',
    );
   db = await Firebase.initializeApp(options: options);
   iconStorage = FirebaseStorage.instance.ref().child('icons'); 
  }
}