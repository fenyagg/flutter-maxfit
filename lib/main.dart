import 'package:flutter/material.dart';
import 'package:flutter_app/domain/appUser.dart';
import 'package:flutter_app/screens/landing.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaxFitApp());
}

class MaxFitApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print('Firebase init errors');
          return Container();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<AppUser>.value(
            value: AuthService().currentUser,
            child: MaterialApp(
              title: "Max fitness",
              theme: ThemeData(
                  primaryColor: Color.fromRGBO(50, 65, 85, 1),
                  textTheme: TextTheme(subtitle1: TextStyle(color: Colors.white))
              ),
              home: LandingPage(),
            ),
          );
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return Container();
      },
    );
  }
}


