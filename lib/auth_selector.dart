import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_selector.dart';
import 'model/usermodel.dart';
import 'service/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Firebase Auth",
      theme: ThemeData(
        primaryColor: Colors.white,
        inputDecorationTheme: const InputDecorationTheme(
          focusColor: Colors.blue,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 42.0, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 26.0),
          bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
        colorScheme:
            ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
          secondary: const Color(0xffBFFF80),
        ),
      ),
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text("Something went wrong!"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MultiProvider(
              providers: [
                //stream provider listens to changes in firebase user
                //filter for "debug_auth" in debug console to see key events
                StreamProvider<UserModel?>.value(
                  initialData: null,
                  catchError: (_, op) => null,
                  //updateShouldNotify: (_, __) => true,
                  value: AuthService().user,
                ),
              ],
              child:
                  const AuthSelector(), //select either login or home page based on user state
            );
          }
          return const Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        },
      ),
    );
  }
}
