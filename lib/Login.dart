import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'HomePage.dart';
import 'SignUp.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email, _password;
  
  checkAuthentification() async
  {
    _auth.onAuthStateChanged.listen((user) {
      
      if(user!= null)
      {
         Navigator.push(context, MaterialPageRoute(
             builder: (context)=>HomePage()));
      }

    });

    @override
    void initState()
    {
      super.initState();
      this.checkAuthentification();
    }

  }

  login() async
  {
    if(_formKey.currentState.validate())
    {
      _formKey.currentState.save();

      try{
        FirebaseUser user = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
     }

     catch(e){
        showError(e.message);
     }

    }
  }
  
  showError(String errormessage){
    showDialog(
        context: context,
        builder: (BuildContext context)
        {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            
            
          actions: <Widget>[
            FlatButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },

                child: Text('OK'))
          ],  
          );
        }

    );
  }

  navigateToSignUp() async
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUp() ));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(

        child: Column(

          children: <Widget>[
            Container(

              height: 277,
              child: Image(image: AssetImage("images/login.jpg"),fit: BoxFit.contain,
              ),
            ),

            SizedBox(height: 20),

            Container(
              child: Form(

                key: _formKey,
                child: Column(

                  children: <Widget>[

                    Container(

                      child: TextFormField(

                          // ignore: missing_return
                          validator: (input)
                          {
                            if(input.isEmpty)
                            return 'Enter Email';
                          },

                            decoration: InputDecoration(

                                labelText: 'Email',
                                prefixIcon:Icon(Icons.email)

                            ),
                            onSaved: (input) => _email =input


                      ),
                    ),

                    SizedBox(height: 10),

                    Container(

                      child: TextFormField(

                          // ignore: missing_return
                          validator: (input)
                          {
                            if(input.length < 6 )
                            return 'Provide Minium 6 Character';
                          },
                            decoration: InputDecoration(

                                labelText: 'Password',
                                prefixIcon:Icon(Icons.lock),

                            ),

                            obscureText: true,

                            onSaved: (input) => _password=input

                      ),
                    ),

                    SizedBox(height: 40),

                    RaisedButton(

                      padding: EdgeInsets.fromLTRB(70, 10, 70, 10),

                      onPressed: login,
                      child: Text('LOGIN', style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold
                      )),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.orange

                    )

                  ],
                ),
              ),
            ),

            SizedBox(height: 10),

            GestureDetector(
              child: Text('Create an Account? Sign Up',style: TextStyle(
                  color: Colors.deepOrangeAccent,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold
              )),
              onTap: navigateToSignUp,
              
            )


          ],
        ),
      ),
    );
  }
}
