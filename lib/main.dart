import 'package:app_auth/auth_selector.dart';
import 'package:app_auth/model/usermodel.dart';
import 'package:app_auth/service/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
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
          headline1: TextStyle(fontSize: 42.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 26.0),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
        colorScheme:
            ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
          secondary: const Color(0xffBFFF80),
        ),
      ),
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot){
          if(snapshot.hasError){
            return const Scaffold(body: Center(child: Text("Something went wrong!"),),);
          }
         if (snapshot.connectionState == ConnectionState.done) {
            return MultiProvider(
              providers: [
                StreamProvider<UserModel?>.value(
                  initialData: null,
                  catchError: (_, op) => null,
                  value: AuthService().user,
                ),
              ],
              child: const AuthSelector(),
            );
            // return AuthSelector();
          }
          return const Scaffold(body: Center(child: CircularProgressIndicator(),));
        },
      ),
    );
  }
}
