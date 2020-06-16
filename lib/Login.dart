import 'package:bla_bla_bla/chatScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Login extends StatefulWidget{

  @override
  State <StatefulWidget> createState(){
    return LoginScreen();
  }
}

class LoginScreen extends State<Login> {
  String email;
  String password;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginUser() async{
    FirebaseUser user = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password)).user;

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>Chat(),
        )
    );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[50],
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
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
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.teal,
                onPressed: () async {
                  await loginUser();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}