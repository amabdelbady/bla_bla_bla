import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'chatScreen.dart';
import 'ChatInfo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'Bla Bla Bla'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

 @override
 Widget build(BuildContext context) {

   return Scaffold(
     backgroundColor: Colors.red,
     appBar: AppBar(
       title: Text(widget.title),
     ),
     body: Center(
         child: User(),
       ),
   );
 }
}

class User extends StatefulWidget{
  @override
  State <StatefulWidget> createState(){
    return MainScreen();
  }
}

class Chat extends StatefulWidget {
  final FirebaseUser user;

  const Chat({Key key, this.user}) : super(key: key);
  @override
  State <StatefulWidget> createState(){
    return ChatScreen();
  }
}