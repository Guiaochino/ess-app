import 'package:ess_app/login/choice_page.dart';
import 'package:ess_app/login/login_page.dart';
import 'package:ess_app/models/user_model.dart';
import 'package:ess_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:ess_app/constants.dart';
import 'package:ess_app/guardian/home/patient_home.dart';
import 'package:ess_app/guardian/home/guardian_home.dart';
// Firebase Plugins
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  //local notif init
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  
    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_g_icon'); // <- default icon name is @mipmap/ic_launcher
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, );

  WidgetsFlutterBinding.ensureInitialized();
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestPermission();
  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  tz.initializeTimeZones(); //timezone init

  SharedPreferences _prefs = await SharedPreferences.getInstance();
  userPreference = _prefs.getString(userPreferenceKey) ?? '';

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      value: AuthServices().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "GeriAssis",
        theme:
            ThemeData(primarySwatch: Colors.blueGrey, fontFamily: "Montserrat"),
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
          child: userPreference.isEmpty
              ? ChoicePage()
              : userPreference == guardianPreference
                  ? guardianHomePage()
                  : patientHomePage());
    }
  }
}
