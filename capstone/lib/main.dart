import 'package:flutter/material.dart';

import 'package:capstone/views/landing_view.dart';
import 'package:capstone/views/signup_view.dart';
import 'package:capstone/widgets/home_widget.dart';
import 'package:capstone/services/auth_service.dart';
import 'package:capstone/widgets/provider_widget.dart';

void main() => runApp(MyApp());

final primaryColor = const Color(0xFF5B89FF);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
          auth: AuthService(),
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Get Together App",
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          accentColor: Colors.blueAccent,
        ),
        home: HomeController(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => HomeController(),
          
          '/signUp': (BuildContext context) => SignUpView(authFormType: AuthFormType.signUp,),
          '/signIn': (BuildContext context) => SignUpView(authFormType: AuthFormType.signIn,),
          '/anonymousSignIn': (BuildContext context) => SignUpView(authFormType: AuthFormType.anonymous,),
        },
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? Home(): FirstView();
        }
        return CircularProgressIndicator();
      }
    );
  }
}


