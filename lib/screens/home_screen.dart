import 'package:flutter/material.dart';
import 'package:vid_call/helper/colors.dart';
// import 'package:vid_call/helper/custom_btn.dart';
import 'package:vid_call/resources/auth_resources.dart';
import 'package:vid_call/screens/past_meets.dart';

import 'meeting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //For toggling between the bottom nav bar options
  int _page = 0;
  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
    MeetingScreen(),
    const PastMeets(),
    const Text('Contacts'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          title: (_page == 0)
              ? const Text("Meety")
              : ((_page == 1)
                  ? const Text("Past Meets")
                  : const Text("Contacts")),
          centerTitle: (_page == 0) ? false : true,
          actions: (_page == 0)
              ? [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        AuthRes().signOut();
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text("Log Out"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          fixedSize: const Size(150, 30)),
                    ),
                  )
                ]
              : []),
      //giving the body as the screen with respect to current page
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 20, top: 50),
        child: pages[_page],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: footerColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: onPageChanged,
        currentIndex: _page,
        // type: BottomNavigationBarType.fixed,
        // unselectedFontSize: 14,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.lock_clock,
            ),
            label: 'All Meetings',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.person_outline,
          //   ),
          //   label: 'Contacts',
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.settings_outlined,
          //   ),
          //   label: 'Settings',
          // ),
        ],
      ),
    );
  }
}
