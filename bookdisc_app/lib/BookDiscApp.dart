import 'package:bookdisc_app/HomeNB.dart';
import 'package:bookdisc_app/SearchNB.dart';
import 'package:bookdisc_app/UserProfileNB.dart';
import 'package:flutter/material.dart';

class BookDiscApp extends StatefulWidget {
  @override
  _BookDiscAppState createState() => _BookDiscAppState();
}

class _BookDiscAppState extends State<BookDiscApp>{
  int currentPageIndex = 1;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ai Book Discovery App'),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index){
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.grey,
        selectedIndex: currentPageIndex,
        destinations: const<Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.account_circle),
            icon: Icon(Icons.account_circle_outlined),
            label: 'User Profile',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
      body: <Widget>[

        /// User Profile
        UserProfileNB(),
        
        /// Home Page
        HomeNB(),
        // Center(
        //   child: Text('This is the Home Screen.'),
        //   /*
        //   child: Column(
        //     children: const <Widget>[
        //       Text('This is the Home Screen.'),
        //     ],
        //   */
        // ),


        /// Search
        SearchNB(),

      ][currentPageIndex],
    );
  }

}