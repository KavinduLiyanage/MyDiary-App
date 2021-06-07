
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mydiary/Start.dart';
import 'Start.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  bool isloggedin = false;
  
  checkAuthentification() async{
    _auth.onAuthStateChanged.listen((user) {

      if(user == null)
      {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Start()));
      }
    });
  }

  getUser() async{
    FirebaseUser firebaseUser = await _auth.currentUser();
    await firebaseUser?.reload();
    firebaseUser = await _auth.currentUser();

    if(firebaseUser !=null)
    {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin=true;
      });
    }
  }

  signOut() async{
    _auth.signOut();

  }

  @override
  void initState(){
    this.checkAuthentification();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: !isloggedin? CircularProgressIndicator():

        Column(
          children: <Widget>[

            Container(
              height: 288,
              child: Image(image: AssetImage("images/welcome.jpg"),
              fit: BoxFit.contain,
              ),
            ),

            SizedBox(height: 20),

            Container(
              child: Text("Hello ${user.displayName} you are Logged in as ${user.email}",
              style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
              ),),
            ),

            SizedBox(height: 30),
            
            RaisedButton(
                padding: EdgeInsets.fromLTRB(70, 10, 70, 10),

                onPressed: signOut,
                child: Text('SignOut', style: TextStyle(
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
    );
  }
}
