import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class ChatScreen extends State<Chat> {
  TextEditingController _controller;
  ScrollController scrollController = ScrollController();

  List<ChatTextField> _chatTextField = <ChatTextField>[];
  String input = "";
  bool _isWriting = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  @override
  void initState(){
    _controller=TextEditingController();
    super.initState();
  }

  Future<void> onSubmit() async{

    if (_controller.text.length > 0) {
      await _firestore.collection('messages').add({
        'text': _controller.text,
        'from': widget.user.email,
        'date': DateTime.now().toIso8601String().toString(),
      });

      _controller.clear();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );

      setState(() {_isWriting = false;});

      ChatTextField chatTextField = new ChatTextField(
        chatText: _controller.text,
      );

      setState(() {_chatTextField.insert(0, chatTextField);});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text('My Chat'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _auth.signOut();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
      body: _messages(),
    );
  }

  Widget _messages(){
    return Center(
      child: Padding(
          padding: const EdgeInsets.only(left: 8, top: 16, right: 8, bottom: 16,),
          child: Column(
            children: <Widget>[
              Flexible(
                  child: StreamBuilder(
                    stream: _firestore
                        .collection('messages')
                        .orderBy('date')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return Center(
                          child: CircularProgressIndicator(),
                        );

                      List<Widget> messages = snapshot.data.documents
                          .map<Widget>((doc) => ChatTextField(
                        from: doc.data['from'],
                        chatText: doc.data['text'],
                        me: widget.user.email == doc.data['from'],
                      )).toList();

                      return ListView.builder(
                        itemCount:snapshot.data.documents.length,
                        itemBuilder: (_, int index) => messages[index],
                        controller: scrollController,
                      );
                    },
                  )
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 6,
                          controller: _controller,
                          onChanged: (String txt) {
                            setState(() {_isWriting = txt.length > 0;});
                          },
                          onSubmitted: (value)=>onSubmit(),
                          decoration: InputDecoration(
                            hintText: "Type your message here...",
                            filled: true,
                            fillColor: Colors.white,

                            contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),

                            focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(25.7),
                            ),

                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                          ),
                        )
                    ),
                  ),
                  Container(width:15),
                  FloatingActionButton(
                    child: Icon(Icons.send),
                    onPressed:_isWriting
                        ? () => onSubmit()
                        : null,
                  ),
                ],
              ),
            ],
          )
      ),
    );
  }
}



// ignore: must_be_immutable
class ChatTextField extends StatelessWidget{
  String chatText;
  String from;
  bool me;

  ChatTextField({this.chatText, this.from, this.me});

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: const EdgeInsets.only(left:8,top: 8, right: 8, bottom: 8),
        child: Column(
          children: <Widget>[
            Text(from),
            Row  (
              mainAxisAlignment: me? MainAxisAlignment.end: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.all(3.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: .5,
                            spreadRadius: 1.0,
                            color: Colors.black.withOpacity(.12))
                      ],
                      color: me? Colors.greenAccent.shade100 : Colors.white,
                      borderRadius: me? BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(5.0),
                        bottomRight: Radius.circular(10.0),
                      ) : BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        bottomRight: Radius.circular(5.0),
                        bottomLeft: Radius.circular(10.0),
                      ),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 48.0),
                          child: Text(chatText, maxLines: null,),
                        ),
                        Positioned(
                          bottom: 0.0,
                          right: 0.0,
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 3.0),
                              Icon(Icons.done,
                                size: 12.0,
                                color: Colors.black38,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),),
              ],
            )
          ],
        )
    );
    //);
  }
}