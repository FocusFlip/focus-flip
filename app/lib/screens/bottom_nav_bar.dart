import 'package:flutter/material.dart';
import 'package:quezzy/screens/discover_screen/discover_screen.dart';
import 'package:quezzy/screens/home_screen/home_screeen.dart';
import 'package:quezzy/screens/leaderboard/leaderboard_screen.dart';

import 'package:quezzy/screens/profile_screen/profile_screen.dart';
import 'package:quezzy/screens/quiz/create_quiz_screen/create_quiz_screen.dart';

import 'package:quezzy/utils/constant.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  BottomNavScreenState createState() => BottomNavScreenState();
}

class BottomNavScreenState extends State<BottomNavScreen> {
  final navKey = GlobalKey<BottomNavScreenState>();
  int _currentIndex = 0;
  bool isSelected = true;
  bool isSelected2 = false;
  bool isSelected3 = false;
  bool isSelected4 = false;

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageStorage(bucket: bucket, child: currentScreen),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: ColorsHelpers.primaryColor,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreateQuizScreen()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          elevation: 10,
          notchMargin: 7,
          child: ClipPath(
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (isSelected == false) {
                          isSelected = true;
                          isSelected4 = false;
                        } else {
                          isSelected = false;
                          isSelected4 = false;
                        }
                        currentScreen = const HomeScreen();
                        _currentIndex = 0;
                      });
                    },
                    splashRadius: 0.1,
                    icon: isSelected
                        ? const Icon(Icons.home)
                        : const Icon(Icons.home_outlined),
                    isSelected: isSelected,
                    color: _currentIndex == 0 ? Colors.black : Colors.grey,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (isSelected == true) {
                          isSelected = false;
                          isSelected4 = false;
                        } else {
                          isSelected4 = false;
                          isSelected = false;
                        }
                        currentScreen = const DiscoverScreen();
                        _currentIndex = 1;
                      });
                    },
                    splashRadius: 0.1,
                    icon: const Icon(Icons.search),
                    selectedIcon: const Icon(Icons.search),
                    color: _currentIndex == 1 ? Colors.black : Colors.grey,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        // if(isSelected == true){
                        //   isSelected = false;
                        //   isSelected4 = false;
                        // }else{
                        //   isSelected = false;
                        //   isSelected4 = false;
                        // }
                        // currentScreen = DiscoverScreen();
                        // _currentIndex = 2;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    const LeaderboardScreen())));
                      });
                    },
                    splashRadius: 0.1,
                    icon: const Icon(Icons.bar_chart),
                    color: _currentIndex == 2 ? Colors.black : Colors.grey,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (isSelected == true) {
                          isSelected4 = true;
                          isSelected = false;
                        } else {
                          isSelected = false;
                        }
                        isSelected4 = true;
                        currentScreen = const ProfileScreen();
                        _currentIndex = 3;
                      });
                    },
                    splashRadius: 0.1,
                    icon: isSelected4
                        ? const Icon(Icons.person)
                        : const Icon(Icons.person_outline),
                    color: _currentIndex == 3 ? Colors.black : Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
