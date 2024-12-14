import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('This is the Home Screen.'),

            // No need for explicit Logout Button
            // The back button is covered by the Material App

            /*
            ElevatedButton(
              child: Text('Exit App'),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            */
            
          ],
        ),
      ),
    );
  }

}