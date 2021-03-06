import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydiary/src/screens/Login.dart';
import 'package:mydiary/src/screens/SignUp.dart';
import 'package:mydiary/src/theme/colors.dart';

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
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: primary))
                  ]),
            ),
            SizedBox(height: 10.0),
            Text(
              'Fresh creations are welcome',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 50.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                    padding: EdgeInsets.only(left: 100, right: 100),
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
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: primary),
                SizedBox(width: 60.0),
                RaisedButton(
                    padding: EdgeInsets.only(left: 80, right: 80),
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
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: primary),
              ],
            ),
            SizedBox(height: 60.0),
          ],
        ),
      ),
    );
  }
}
