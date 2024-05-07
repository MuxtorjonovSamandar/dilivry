import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xizmatdamiz/frontend/screens/home/orderHistory/order_histor.dart';
import 'package:xizmatdamiz/frontend/screens/home/trip/trip.dart';
import 'package:xizmatdamiz/frontend/screens/profile/profile.dart';
import 'package:xizmatdamiz/frontend/style/color.dart';
import 'package:xizmatdamiz/frontend/utils/app_bar_name.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _pages = [
    const Trip(),
    const OrderHistory(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: RGBcolor().bg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: RGBcolor().bg,
        title: Text(
          appBarName[_selectedIndex],
          style: TextStyle(color: RGBcolor().mainColor),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.list_bullet,
            color: RGBcolor().mainColor,
          ),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: RGBcolor().mainColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: appBarName.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      appBarName[index],
                      style: TextStyle(
                        color: _selectedIndex == index
                            ? Colors.white
                            : Colors.grey,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                      Navigator.pop(context);
                    },
                    selected: _selectedIndex == index,
                    selectedTileColor: Colors.grey[800],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
