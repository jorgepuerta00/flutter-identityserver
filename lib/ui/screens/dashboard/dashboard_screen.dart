import 'package:flutter/material.dart';
import '../../constants/AppColors.dart';
import '../home/home_screen.dart';
import '../../widgets/screen/app_appbar_screen.dart';
import '../../widgets/text/header_1.dart';

class DashboardScreenArgs {
  final String userName;
  DashboardScreenArgs({
    required this.userName,
  });
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  static const String Route = '/dashboard/dashboard_screen';
  final DashboardScreenArgs args;

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        //child: _pages.elementAt(_selectedIndex),
        child: Padding(
          padding: EdgeInsets.only(top: 100, left: 20, right: 20),
          child: Column(
            children: <Widget>[
              Header1(
                title: '''Welcome to revvy ${widget.args.userName}''',
                signs: '!',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: this.navInferior(context),
    );
  }

  BottomNavigationBar navInferior(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: AppColors.ORANGE,
      unselectedItemColor: AppColors.WHITE,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Discover',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add,
          ),
          label: 'Discover',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.messenger_outline_rounded),
          label: 'Inbox',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outlined),
          label: 'Me',
        ),
      ],
      currentIndex: _selectedIndex, //New
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _pages = [
    Center(child: Container()),
    Center(child: Container()),
    Center(child: Container()),
    Center(child: Container()),
    Center(child: Container()),
  ];
}
