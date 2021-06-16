import 'package:firebase_auth/firebase_auth.dart';
import 'package:mydiary/Start.dart';
import 'package:mydiary/src/pages/budget_page.dart';
import 'package:mydiary/src/pages/create_budge_page.dart';
import 'package:mydiary/src/pages/daily_page.dart';
import 'package:mydiary/src/pages/profile_page.dart';
import 'package:mydiary/src/pages/stats_page.dart';
import 'package:mydiary/src/screens/calendar_list2.dart';
import 'package:mydiary/src/screens/entry_filter.dart';
import 'package:mydiary/src/screens/entry_insert.dart';
import 'package:mydiary/src/screens/entry_list.dart';
import 'package:mydiary/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import '../globals.dart' as globals;

class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;
  List<Widget> pages = [
    EntryList(),
    CalendarDiaryExample(),
    EntryFilter(),
    // BudgetPage(),
    ProfilePage(),
    EntryInsert()
  ];

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // FirebaseUser user;
  late User user;
  bool isloggedin = false;
  bool searchState = false;

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  checkAuthentification() async {
    // _auth.onAuthStateChanged.listen((user) {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Start()));
      }
    });
  }

  getUser() async {
    // FirebaseUser firebaseUser = await _auth.currentUser();
    User? firebaseUser = await _auth.currentUser;
    await firebaseUser?.reload();
    // firebaseUser = await _auth.currentUser();
    firebaseUser = await _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser!;
        this.isloggedin = true;
        globals.userName = user.displayName!;
        globals.userEmail = user.email!;
      });
    }
  }

  signOut() async {
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: getBody(),
        extendBodyBehindAppBar: true,
        bottomNavigationBar: getFooter(),
        drawer: Container(
          width: 250,
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Column(
                    children: <Widget>[
                      Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.elliptical(9999.0, 9999.0)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://images.unsplash.com/photo-1531256456869-ce942a665e80?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTI4fHxwcm9maWxlfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60"),
                                  fit: BoxFit.cover),
                            border: Border.all(
                                width: 1.0, color: const Color(0xffffffff)),
                          )),
                      Text(
                        "${user.displayName}",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          primary,
                          secondary,
                        ]),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  // onTap: () {
                  //   Navigator.pop(context);
                  // },
                ),
                ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text('Profile'),
                  // onTap: () {
                  //   Navigator.pop(context);
                  //   Navigator.push(context,
                  //       MaterialPageRoute(builder: (_) => UserProfile()));
                  // },
                ),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Edit Profile'),
                  // onTap: () {
                  //   Navigator.pop(context);
                  //   Navigator.push(
                  //       context, MaterialPageRoute(builder: (_) => UserEdit()));
                  // },
                ),
                ListTile(
                  leading: Icon(Icons.message),
                  title: Text('Feedback'),
                  // onTap: () {
                  //   Navigator.pop(context);
                  //   Navigator.push(context,
                  //       MaterialPageRoute(builder: (_) => UserFeedback()));
                  // },
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Sign Out'),
                  onTap: () {
                    Navigator.pop(context);
                    signOut();
                  },
                ),
              ],
            ), // Populate the Drawer in the next step.
          ),
        ),
        floatingActionButton: FloatingActionButton(
            // onPressed: () {
            //   selectedTab(4);
            // },
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => EntryInsert()));
            },
            child: Icon(
              Icons.add,
              size: 25,
            ),
            backgroundColor: Colors.pink
            //params
            ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget getFooter() {
    List<IconData> iconItems = [
      Ionicons.md_list,
      Ionicons.md_calendar,
      Ionicons.md_search,
      Ionicons.ios_person,
    ];

    return AnimatedBottomNavigationBar(
      activeColor: primary,
      splashColor: secondary,
      inactiveColor: Colors.black.withOpacity(0.5),
      icons: iconItems,
      activeIndex: pageIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 10,
      iconSize: 25,
      rightCornerRadius: 10,
      onTap: (index) {
        selectedTab(index);
      },
      //other params
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
