import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:training_app/training_utility/exercise.dart';

class Home extends StatelessWidget {
  const Home({Key key, this.user,}) : super(key: key);
  final FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: Text('Home ${user.email}'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        //user.uid producerer en null value hvis du ikke logger ind, jeg tror godt du kan hardcode uid ind.
        stream: Firestore.instance.collection('exercises').getDocuments().asStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            //' ${} ' kaldes for string interpolation. Dette gør at du ikke behøver at lave + omkring flere strenge!
            return Text('Error: ${snapshot.error}');
          }
          //der er andre cases såsom: active, done, none, waiting i switch casen.
          switch(snapshot.connectionState){
            case ConnectionState.waiting: return Text('Loading..');
            default: 
              return checkRole(snapshot.data);
          }
        },

      )
    );
  }
  Center checkRole(QuerySnapshot snapshot) {
    //documentsnapshot er vist den enkelte fil. Du kan vist også bruge path i stedet for 'role' etc. du kan finde path i db interface på fb console.
    if (snapshot.documents.isEmpty) {
      return Center(child: Text('this bitch empty')) ;
    } else {
      
      return Center(child: Text(snapshot.documents.elementAt(3).data['name'] + ' with size of docu: '+ snapshot.documents.length.toString()));
      
    }
  }
  Center adminPage(DocumentSnapshot snapshot) {
    return Center(child: Text('${snapshot.data['role']} ${snapshot.data['name']}'));
  }
  Center userPage(DocumentSnapshot snapshot) {
    return Center(child: Text(snapshot.data['name']));
  }
}