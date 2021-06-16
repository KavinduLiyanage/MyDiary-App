import 'package:flutter/material.dart';
import 'package:mydiary/src/screens/entry_list.dart';

class SideNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Nirma De Silva'),
            accountEmail: Text('nirmad@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Z2lybCUyMHByb2ZpbGV8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.pink,
            ),
          ),
          ListTile(
            leading: Icon(Icons.notes_outlined),
            title: Text('My Notes'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.calendar_today_outlined),
            title: Text('Calendar'),
            onTap: () => null,
          ),

          ListTile(
            leading: Icon(Icons.account_circle_outlined),
            title: Text('User Profile'),
            onTap: () =>null,
          ),

          ListTile(
            leading: Icon(Icons.logout_outlined),
            title: Text('Logout'),
            onTap: () =>null,
          ),
        ],
      ),
    );
  }
}
