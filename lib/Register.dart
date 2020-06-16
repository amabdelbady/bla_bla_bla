import 'package:bla_bla_bla/chatScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Register extends StatefulWidget{


  @override
  State <StatefulWidget> createState(){
    return RegisterScreen();
  }
}

class RegisterScreen extends State<Register> {
  String email;
  String password;
  String userName;

  final FirebaseAuth _auth = FirebaseAuth.instance;

    Future<FirebaseUser> registerUser(email, password, displayName) async {
      FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      )).user;

      Firestore.instance.collection('users').document().setData({
        'display_name': displayName,
        'email': email,
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Chat(), //Chat(user: user,),
        ),
      );
      return user;
    }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.yellow[50],
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                onChanged: (value) => userName = value,
                decoration: InputDecoration(
                  hintText: "Enter Your Name...",
                  filled: true,
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(),
                ),
              ),
              Container(height:32),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => email = value,
                decoration: InputDecoration(
                  hintText: "Enter Your Email...",
                  filled: true,
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(),
                ),
              ),
              Container(height:32),
              TextField(
                autocorrect: false,
                obscureText: true,
                onChanged: (value) => password = value,
                decoration: InputDecoration(
                  hintText: "Enter Your Password...",
                  filled: true,
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(),
                ),
              ),
              Container(height:32),
              RaisedButton(
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.teal,
                onPressed: () async {
                  await registerUser(email, password, userName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}