import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({
    Key key,
    this.currentUser,
  }) : super(key: key);
  final AuthResult currentUser;
  

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home${widget.currentUser.user.email.toString()}'),
      ),
    );
  }
}
