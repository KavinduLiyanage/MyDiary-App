import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mydiary/src/pages/root_app.dart';
import 'package:mydiary/src/theme/colors.dart';
import 'HomePage.dart';
import 'Login.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  late String _email, _password, _name;

  //Check authentication and navigate to the Login Screen
  checkAuthentification() async {
    // _auth.onAuthStateChanged.listen((user) async
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RootApp()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
  }

  signUp() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();

      try {
        // FirebaseUser user = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        if (user != null) {
          // UserUpdateInfo updateuser = UserUpdateInfo();
          // updateuser.displayName = _name;
          // user.updateProfile(updateuser);
          await FirebaseAuth.instance.currentUser!
              .updateProfile(displayName: _name);
        }
      } catch (error) {
        showError("error");
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  navigateToLogin() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 309,
              child: Image(
                image: AssetImage("images/signup.jpg"),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: TextFormField(
                          // ignore: missing_return
                          validator: (input) {
                            if (input!.isEmpty) return 'Enter Name';
                          },
                          decoration: InputDecoration(
                              labelText: 'Name',
                              prefixIcon: Icon(Icons.person)),
                          onSaved: (input) => _name = input!),
                    ),
                    Container(
                      child: TextFormField(
                          // ignore: missing_return
                          validator: (input) {
                            if (input!.isEmpty) return 'Enter Email';
                          },
                          decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email)),
                          onSaved: (input) => _email = input!),
                    ),
                    Container(
                      child: TextFormField(
                          // ignore: missing_return
                          validator: (input) {
                            if (input!.length < 6)
                              return 'Provide Minium 6 Character';
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                          onSaved: (input) => _password = input!),
                    ),
                    SizedBox(height: 30),
                    RaisedButton(
                        padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                        onPressed: signUp,
                        child: Text('SignUp',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: primary),
                    SizedBox(height: 20),
                    GestureDetector(
                      child: Text('Already have an Account? Sign In',
                          style: TextStyle(
                              color: primary,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold)),
                      onTap: navigateToLogin,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
