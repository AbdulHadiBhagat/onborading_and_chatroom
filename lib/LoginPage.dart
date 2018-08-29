import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget{


@override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

  enum FormType{
    login,
    register
  }


  class _LoginPageState extends State<LoginPage> {

  DocumentReference documentReference = Firestore.instance.document('Users/test');
  final formKey = new GlobalKey<FormState>();
  String email;
  String _pass;
  String _check;
  FormType formType = FormType.login;
  String buttonName = 'Login';
  String lastButton = 'New User ... Create An account here ...';
  bool isSignIn = true;
  bool validateAndSave() {

    final form = formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if(validateAndSave()){
      try{

      if(formType == FormType.login){
          FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email,password: _pass);
               setState(() {
            documentReference = Firestore.instance.document('Users/${user.uid}');
            documentReference.get().then((dataSnapshot){
            if(dataSnapshot.exists){
              _check = dataSnapshot.data['password'];
          }
        });
                });    
          
          
          print('Signed In : ${user.uid}');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
            );
          
      }
      else{
         FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email,password: _pass);
         Map<String,String> data = <String,String> {
            "email" : "$email",
            "password" : "$_pass"
          };
         documentReference = Firestore.instance.document('Users/${user.uid}');
          documentReference.setData(data).whenComplete((){
            print("User Added");
          }).catchError((e)=>print(e));
      }      
        }
      catch(e){
        print('Eror : $e');
      }
    }
  }
    void moveToSignin(){
    formKey.currentState.reset();
      setState(() {
          formType = FormType.login;
            });
    }
   void moveToRegister(){
    formKey.currentState.reset();
    setState(() {
    //My Way 
    //         isSignIn = !isSignIn;
    // if(isSignIn){
    //   print('$isSignIn $lastButton $buttonName');
    //   buttonName = 'Login';
    //   lastButton = 'New User ... Create An account here ...';
    // }
    // else{
    //   print('$isSignIn $lastButton $buttonName');
    //   buttonName = 'SignUp';
    //   lastButton = 'Already Have An Account ... Signin here ...';
    //     }
    formType = FormType.register;
    });
    
  
  //   }
    
    
    
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Login Form"),

      ),
      body: new Container(
        
        padding: EdgeInsets.all(16.0),
        // child: new Text("As Salam o Alaikum !  "),
        child: new Form(
          key: formKey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:buildInputs() + buildSubmitButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs(){
    return[
        new TextFormField(
                decoration: new InputDecoration(labelText: 'Email'),
                validator: (value)=> value.isEmpty ? 'Email Required' : null,
                onSaved: (value) => email = value ,
              ),
              new TextFormField(
                decoration: new InputDecoration(labelText: 'Password'),
                validator: (value)=> value.isEmpty ? 'Password Required' : null,
                obscureText: true,
                onSaved: (value) => _pass = value ,
              ),
              
    ];
  }

  List<Widget> buildSubmitButtons(){
    if(formType == FormType.login){
    return [
      new RaisedButton(
                child:new Text('$buttonName',style: new TextStyle(fontSize: 20.0),),
                onPressed: validateAndSubmit,
              ),
              new FlatButton(
                child: new Text('$lastButton',style: new TextStyle(fontSize: 10.0),),
                onPressed: moveToRegister,
              )

    ];
  }else{
    return [
      new RaisedButton(
                child:new Text('SignUp',style: new TextStyle(fontSize: 20.0),),
                onPressed: validateAndSubmit,
              ),
              new FlatButton(
                child: new Text('Already Have An Account ? Signin',style: new TextStyle(fontSize: 10.0),),
                onPressed: moveToSignin,
              )

    ];
  }

  }

  

  }