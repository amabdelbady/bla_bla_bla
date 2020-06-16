import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Login.dart';
import 'Register.dart';
import 'main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainScreen extends State<User> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text(
                "Register",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.teal,
              onPressed: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Register()),
                );
              },
            ),
            RaisedButton(
              child: Text("Login",style: TextStyle(color: Colors.white),),
              color: Colors.teal,
              onPressed: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}