import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:training_app/localization/localization.dart';
import 'package:training_app/pages/add_exercises_state.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(buildContext).signIn),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              //The email field
              TextFormField(
                validator: (input) {
                  if (input.isEmpty || !input.contains('@')) {
                    return AppLocalizations.of(buildContext).typeValidEmail;
                  }
                  return null;
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(buildContext).email,
                    contentPadding: EdgeInsets.all(10)),
              ),
              //The password field
              TextFormField(
                validator: (input) {
                  if (input.length < 6) {
                    return AppLocalizations.of(buildContext).invalidPassword;
                  }
                  return null;
                },
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(buildContext).password,
                    contentPadding: const EdgeInsets.all(10)),
                obscureText: true,
              ),
              RaisedButton(
                onPressed: () {
                  signIn();
                },
                child: Text(AppLocalizations.of(buildContext).signIn),
              )
            ],
          )),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      //retrieves the email and password field as a child of formstate
      formState.save();
      try {
        AuthResult _authResult = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password));
        //redirects to the random homepage in home.dart, delete this.
        //Navigator.push(context, MaterialPageRoute(builder: (context) => Home(currentUser: user,)));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddExercisesPage(
                      title: AppLocalizations.of(context).welcome,
                      signedInUser: _authResult.user,
                    )));
      } catch (e) {
        print('Login Failed: ' + e.toString());
      }
    }
  }
}
