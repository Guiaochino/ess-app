import 'package:ess_app/login/choice_page.dart';
import 'package:ess_app/models/user_model.dart';
import 'package:ess_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'login/login_page.dart';

// Firebase Plugins
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

Future main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      value: AuthServices().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "GeriAssis",
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          fontFamily: "Montserrat"
        ),
        home: MainPage(),
      ), 
    );
  }
}

class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    
    // Return to choice page or login page
    if (user == null) {
      return LoginPage();
    } else {
      return StreamProvider<UserModel?>.value(
        value: AuthServices().user, 
        initialData: null,
        child: ChoicePage(),
        );
    }
    
  }

}
