import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:capstone/widgets/custom_dialog.dart';

class FirstView extends StatelessWidget {
  final primaryColor = const Color(0xFF5B89FF);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: _width,
        height: _height,
        color: primaryColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: _height * 0.1),
                Text(
                  'Get Together',
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
                SizedBox(height: _height * 0.05),
                AutoSizeText(
                  'Lets Plan your next group outing',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(height: _height * 0.05),
                RaisedButton(color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 30.0, right: 30.0),
                    child: Text(
                      'Sign up',
                      style: TextStyle(color: primaryColor, fontSize:20 ),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => CustomDialog(
                        title: "Would you like to create an account?",
                        description:"With an account your data will be saved and accessable across multiple devices",
                        primaryButtonText: "Create an Account",
                        primaryButtonRoute: "/signUp",
                        secondaryButtonText: "Maybe Later?",
                        secondaryButtonRoute: "/home",
                      ),
                    );
                  },
                ),
                SizedBox(height: _height * 0.05),
                FlatButton(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 30.0, right: 30.0),
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                onPressed: (){
                  Navigator.of(context).pushReplacementNamed("/signIn");
                },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
