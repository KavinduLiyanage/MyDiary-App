import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydiary/Login.dart';
import 'package:mydiary/SignUp.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

//navigation to login and register
class _StartState extends State<Start> {
  navigateToLogin() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  navigateToRegister() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Container(
              child: Image(
                image: AssetImage("images/start.jpg"),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 40),
            RichText(
              text: TextSpan(
                  text: 'Welcome to ',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'My Dairy',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold))
                  ]),
            ),
            SizedBox(height: 10.0),
            Text(
              'Fresh creations are welcome',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 40.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                    padding: EdgeInsets.only(left: 50, right: 50),
                    onPressed: navigateToLogin,
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.orange),
                SizedBox(width: 20.0),
                RaisedButton(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    onPressed: navigateToRegister,
                    child: Text(
                      'REGISTER',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.orange),
              ],
            ),
            SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
