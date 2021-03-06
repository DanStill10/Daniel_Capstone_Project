import 'package:flutter/material.dart';
import 'package:capstone/widgets/provider_widget.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:capstone/services/auth_service.dart';
import 'package:auto_size_text/auto_size_text.dart';

final primaryColor = const Color(0xFF5B89FF);

enum AuthFormType { signIn, signUp, reset, anonymous }

class SignUpView extends StatefulWidget {
  final AuthFormType authFormType;

  SignUpView({Key key, @required this.authFormType}) : super(key: key);
  @override
  _SignUpViewState createState() =>
      _SignUpViewState(authFormType: this.authFormType);
}

class _SignUpViewState extends State<SignUpView> {
  AuthFormType authFormType;

  _SignUpViewState({this.authFormType});

  final _formKey = GlobalKey<FormState>();
  String _email, _password, _uName, _warning;

  void switchFormState(String state) {
    _formKey.currentState.reset();
    if (state == "signUp") {
      setState(() {
        authFormType = AuthFormType.signUp;
      });
    } else {
      setState(() {
        authFormType = AuthFormType.signIn;
      });
    }
  }

  bool validate() {
    final form = _formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void submit() async {
    if (validate()) {
      try {
        final auth = Provider.of(context).auth;
        if (authFormType == AuthFormType.signIn) {
          String uid = await auth.signInWithEmailAndPassword(_email, _password);
          print("Signed in with ID $uid");
          Navigator.of(context).pushReplacementNamed('/home');
        } else if (authFormType == AuthFormType.reset) {
          await auth.sendPasswordResetEmail(_email);
          _warning = "A password reset link has been sent to $_email";
          setState(() {
            authFormType = AuthFormType.signIn;
          });
        } else {
          String uid = await auth.createUserWithEmailAndPassword(
              _email, _password, _uName);
          print("Signed up with new ID $uid");
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } catch (e) {
        print(e);
        setState(() {
          _warning = e.message;
        });
      }
    }
  }

  Future submitAnonymous() async {
    final auth = Provider.of(context).auth;
    await auth.singInAnonymously();
    Navigator.of(context).pushReplacementNamed("/home");
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    if (authFormType == AuthFormType.anonymous) {
      submitAnonymous();
      return Scaffold(
        backgroundColor: primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitChasingDots(
              color: Colors.white70,
            ),
            Text(
              "Loading",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    } else {
      var children1 = <Widget>[
        SizedBox(height: _height * 0.05),
        showAlerts(),
        SizedBox(height: _height * 0.05),
        buildHeaderText(),
        SizedBox(height: 0.5),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: buildInputs() + buildButtons(),
              ),
            ),
          ),
        )
      ];
      return Scaffold(
        body: Container(
          color: primaryColor,
          height: _height,
          width: _width,
          child: ListView(
            children: children1,
          ),
        ),
      );
    }
  }

  AutoSizeText buildHeaderText() {
    String _headerText;
    if (authFormType == AuthFormType.reset) {
      _headerText = "Reset Password";
    } else if (authFormType == AuthFormType.signUp) {
      _headerText = "Create a New Account";
    } else {
      _headerText = "Sign In";
    }
    return AutoSizeText(
      _headerText,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 30,
      ),
    );
  }

  List<Widget> buildInputs() {
    List<Widget> textFields = [];

    if (authFormType == AuthFormType.reset) {
      textFields.add(
        TextFormField(
          validator: EmailValidator.validate,
          style: TextStyle(fontSize: 18.0, color: Colors.grey),
          decoration: buildSignUpDecoration("Email"),
          onSaved: (value) => _email = value,
        ),
      );
      textFields.add(SizedBox(
        height: 15,
      ));
      return textFields;
    }

    if (authFormType == AuthFormType.signUp) {
      textFields.add(
        TextFormField(
          validator: NameValidator.validate,
          style: TextStyle(fontSize: 18.0, color: Colors.grey),
          decoration: buildSignUpDecoration("User Name"),
          onSaved: (value) => _uName = value,
        ),
      );
    }
    textFields.add(SizedBox(height: 20.0));
    textFields.add(
      TextFormField(
        validator: EmailValidator.validate,
        style: TextStyle(fontSize: 18.0, color: Colors.grey),
        decoration: buildSignUpDecoration("Email"),
        onSaved: (value) => _email = value,
      ),
    );
    textFields.add(SizedBox(height: 20.0));
    textFields.add(
      TextFormField(
        validator: PasswordValidator.validate,
        style: TextStyle(fontSize: 18.0, color: Colors.grey),
        decoration: buildSignUpDecoration("Password"),
        obscureText: true,
        onSaved: (value) => _password = value,
      ),
    );
    textFields.add(SizedBox(height: 20.0));
    if (authFormType == AuthFormType.signUp) {
      textFields.add(
        TextFormField(
          style: TextStyle(fontSize: 18.0, color: Colors.grey),
          decoration: buildSignUpDecoration("Confirm Password"),
          obscureText: true,
          validator: (confirmation) {
            if (confirmation != _password) {
              return "Confirm Password should match password";
            } else {
              return null;
            }
          },
        ),
      );
    }
    return textFields;
  }

  Widget showAlerts() {
    if (_warning != null) {
      return Container(
        color: Colors.redAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.error_outline,
              ),
            ),
            Expanded(
              child: AutoSizeText(
                _warning,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _warning = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }

  List<Widget> buildButtons() {
    String _switchButton, _newFormState, _submitButtonText;
    bool _showForgotPassword = false;
    bool _showSocialSignIn = true;
    if (authFormType == AuthFormType.signIn) {
      _showForgotPassword = true;
      _switchButton = "Create New Account";
      _newFormState = "signUp";
      _submitButtonText = "Sing In";
    } else if (authFormType == AuthFormType.reset) {
      _showForgotPassword = true;
      _showSocialSignIn = false;
      _switchButton = "Return to Sign In";
      _newFormState = "signIn";
      _submitButtonText = "Submit";
    } else {
      _switchButton = "Have an Account? Sign In";
      _newFormState = "signIn";
      _submitButtonText = "Sing Up";
    }
    return [
      Container(
        width: MediaQuery.of(context).size.width * 0.65,
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          color: Colors.white,
          textColor: primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _submitButtonText,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
            ),
          ),
          onPressed: () {
            submit();
          },
        ),
      ),
      showForgotPassword(_showForgotPassword),
      FlatButton(
        child: Text(
          _switchButton,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          switchFormState(_newFormState);
        },
      ),
      buildSocialIcons(_showSocialSignIn),
    ];
  }

  Widget showForgotPassword(bool visible) {
    return Visibility(
      child: FlatButton(
        child: Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          setState(() {
            authFormType = AuthFormType.reset;
          });
        },
      ),
      visible: visible,
    );
  }

  Widget buildSocialIcons(bool visible) {
    final _auth = Provider.of(context).auth;
    return Visibility(
      child: Column(
        children: <Widget>[
          Divider(
            color: Colors.white,
          ),
          SizedBox(
            height: 10,
          ),
          GoogleSignInButton(
            onPressed: () async {
              try{
                await _auth.signInWithGoogle();
                Navigator.of(context).pushReplacementNamed("/home");
              }catch (e){
                setState(() {
                 _warning = e.message; 
                });
              }
            },
          )
        ],
      ),
      visible: visible,
    );
  }
}

InputDecoration buildSignUpDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(color: Colors.grey),
    filled: true,
    fillColor: Colors.white,
    focusColor: Colors.white,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 0.0),
    ),
    contentPadding: const EdgeInsets.only(left: 15.0, bottom: 10.0, top: 10.0),
  );
}
