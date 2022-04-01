import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ListTile(
            title: Text('Simple State Management'),
          ),
          ListTile(
            title: Text('Flutter Riverpod'),
          ),
          ListTile(
            title: Text('Hooks RiverPod'),
          ),
          ListTile(
            title: Text('Flutter Bloc'),
          ),
          ListTile(
            title: Text('Flutter Redux'),
          ),
          ListTile(
            title: Text('Fish Redux'),
          ),
          ListTile(
            title: Text('Flutter MobX'),
          )
        ],
      ),
    );
  }
}
