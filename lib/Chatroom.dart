import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'LoginPage.dart';
import 'ResetPass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';


class Chat extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new ChatState();
  }

}


class ChatState extends State<Chat>{
  String _message;
  final formKey = new GlobalKey<FormState>();
  DocumentReference documentReference = Firestore.instance.collection("Chat").document('chats');
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Chat with the World"),

      ),
      body: new ChatList(),
      
                    );
                
                
                  }
                
                
                  void validateAndSend() async {
                    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
                    final form = formKey.currentState;
                    if(form.validate())
                    {
                      form.save();
                      Firestore.instance.collection('Chat').document().setData({
                        "name" : '${firebaseUser.email}'
                        "message" "$_message"
                      });
                    }
                
                  }
                
                  void back() {
                    Navigator.pop(context);
  }

  List<Widget> buildInputs(){
    return[
      
        new TextFormField(
                decoration: new InputDecoration(labelText: 'Email'),
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
}



class ChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('Chat').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        snapshot.data.documents.reversed;
        print(snapshot.data.documents.length);
        return new ListView(
          

           children: snapshot.data.documents.map((DocumentSnapshot document) {
            return new ListTile(
              
              title: new Text(document['message']),
              subtitle: new Text(document['name']),
              
            );
          }).toList(),
        );
      },
    );
  }
}


