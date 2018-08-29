import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'SendChat.dart';
import 'LoginPage.dart';
import 'ResetPass.dart';
import 'Chatroom.dart';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }

}

class _HomePageState extends State<Home>{

  
  final formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Welcome To Flutter Demo',style: new TextStyle(color: Colors.white,fontSize: 20.0),),
        backgroundColor: Colors.black,
      ),
      body: new Container(
         padding: EdgeInsets.all(16.0),
        
        child: new Form(
          key: formKey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:[
              new RaisedButton(
                child:new Text('Logout',style: new TextStyle(fontSize: 20.0),),
                onPressed: logout,
              ),
              new RaisedButton(
                child:new Text('Reset Password',style: new TextStyle(fontSize: 20.0),),
                onPressed: reset,
              ),
              new RaisedButton(
                child:new Text('Inbox',style: new TextStyle(fontSize: 20.0),),
                onPressed: chat,
                              ),
              new RaisedButton(
                child:new Text('Send Message To ChatBox',style: new TextStyle(fontSize: 20.0),),
                onPressed: sendchat,
                                              )
                
                                
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                
                                
                                  
                                  void logout() {
                                    Navigator.pop(context);
                                  }
                                
                                   void reset() {
                                     Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ResetPage()),
                                    );
                                  }
                                
                                  void chat() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => Chat()),
                                    );
                  }
                
                  void sendchat() {
                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => SendChat()),
                                    );
  }
}