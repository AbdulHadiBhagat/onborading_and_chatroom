import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'LoginPage.dart';
import 'ResetPass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';


class SendChat extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new SendChatState();
  }

}


class SendChatState extends State<SendChat>{
  String _message;
  final formKey = new GlobalKey<FormState>();
  DocumentReference documentReference = Firestore.instance.collection("Chat").document('chats');
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Chat with the World"),

      ), body: new Container(
        
        padding: EdgeInsets.all(16.0),
        // child: new Text("As Salam o Alaikum !  "),
        child: new Form(
          key: formKey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:buildInputs(),
          ),
        ),
      ),);
  }

  List<Widget> buildInputs(){
    return[
      
        new TextFormField(
                decoration: new InputDecoration(labelText: 'Enter Message To Send'),
                validator: (value)=> value.isEmpty ? 'Empty Message Cant Be Send' : null,
                onSaved: (value) => _message = value ,
              ),
              new RaisedButton(
                child:new Text('Send',style: new TextStyle(fontSize: 20.0),),
                onPressed: validateAndSend,
              ),
              new RaisedButton(
                child:new Text('Back',style: new TextStyle(fontSize: 20.0),),
                onPressed: back,
                              )
              
    ];
  }
  void validateAndSend() async {
                    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
                    final form = formKey.currentState;
                    if(form.validate())
                    {
                      form.save();
                      Firestore.instance.collection('Chat').document().setData({
                        'name' : '${firebaseUser.email}',
                        'message': '$_message'
                      });
                      Navigator.pop(context);
                    }
                
                  }
                
                  void back() {
                    Navigator.pop(context);
                    }
  }