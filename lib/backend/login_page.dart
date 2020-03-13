import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:training_app/pages/home.dart';
import 'package:training_app/add_exercises_state.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sign in'),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (input) {
                  if (input.isEmpty || !input.contains('@')) {
                    return 'Please type an email';
                  }
                  return 'Email not found';
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                    labelText: 'Email', 
                    contentPadding: EdgeInsets.all(10)),
              ),
              TextFormField(
                validator: (input) {
                  if (input.length < 6) {
                    return 'Please provide a password above 6 characters';
                  }
                  return 'Password does not match with email';
                },
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                    labelText: 'Password',
                    contentPadding: const EdgeInsets.all(10)),
                obscureText: true,
              ),
              RaisedButton(
                onPressed: () => signIn(),
                child: Text('Sign in'),
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
        AuthResult user = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password));
        //redirects to the random homepage in home.dart, delete this.
        //Navigator.push(context, MaterialPageRoute(builder: (context) => Home(currentUser: user,)));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                      title: 'welcome ' + user.user.email,
                    )));
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
