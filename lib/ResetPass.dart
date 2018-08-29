import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';







class ResetPage extends StatefulWidget{


@override
  State<StatefulWidget> createState() {
    return new _ResetPageState();
  }
}

class _ResetPageState extends State<ResetPage>{
  DocumentReference documentReference = Firestore.instance.document('Users/dummy');
  final formKey = new GlobalKey<FormState>();
  
  



  String _email;
  String _pass;
  String _conPass;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
        title: new Text("Update Password"),

      ),
      body: new Container(
        
        padding: EdgeInsets.all(16.0),
        // child: new Text("As Salam o Alaikum !  "),
        child: new Form(
          key: formKey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:[
              new TextFormField(
                decoration: new InputDecoration(labelText: 'Password'),
                validator: (value)=> value.isEmpty ? 'Required' : null,
                obscureText: true,
                onSaved: (value) => _pass = value ,
              ),
              new TextFormField(
                decoration: new InputDecoration(labelText: 'Confrim Password'),
                validator: (value)=> value.isEmpty ? 'Required' : null,
                obscureText: true,
                onSaved: (value) => _conPass = value ,
              ),
              new RaisedButton(
                child:new Text('Save',style: new TextStyle(fontSize: 20.0),),
                onPressed: save,
              ),

            ],
          ),
        ),
      ),
    );
  }


  bool check(){
    final form = formKey.currentState;
    if(form.validate()){
      
      form.save();
      if(_pass != _conPass)
         return false;
      return true;
    }
    return false;
  }
  
  void save() async {
      if(check()){
         FirebaseUser user = await FirebaseAuth.instance.currentUser();
        setState(() {
            documentReference = Firestore.instance.document('Users/${user.uid}');
            documentReference.get().then((dataSnapshot){
            if(dataSnapshot.exists){
              _email = dataSnapshot.data['email'];
          }
        });
                });
        
         Map<String,String> data = <String,String> {
            "email" : "$_email",
            "password" : "$_pass"
          };
        
        documentReference.updateData(data).whenComplete((){
            print("User Updated");
          }).catchError((e)=>print(e));
        print(user.uid);
        Navigator.pop(context);
      }
    

  }
}