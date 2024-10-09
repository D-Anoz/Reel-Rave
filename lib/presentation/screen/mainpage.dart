// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:reelrave/core/constant/colors.dart';
import 'package:reelrave/core/constant/icons.dart';
import 'package:reelrave/presentation/screen/home.dart';
import 'package:reelrave/presentation/screen/profile.dart';
import 'package:reelrave/presentation/screen/saved.dart';
import 'package:reelrave/presentation/screen/search.dart';
import 'package:reelrave/presentation/screen/tv.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print(_selectedIndex);
  }

  List<Widget> pages = const [
    TVScreen(),
    SearchPage(),
    MovieHomePage(),
    SavedListPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.bgColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: AppColors.primaryColor,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: _selectedIndex == 0 ? const ImageIcon(AssetImage(AppIcons.tvFilledIcon)) : const Align(alignment: Alignment.center, child: ImageIcon(AssetImage(AppIcons.tvIcon))),
            label: _selectedIndex == 0 ? 'TV' : '',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1 ? const ImageIcon(AssetImage(AppIcons.searchFilledIcon)) : const ImageIcon(AssetImage(AppIcons.searchIcon)),
            label: _selectedIndex == 1 ? 'Search' : '',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2 ? const ImageIcon(AssetImage(AppIcons.homeFilledIcon)) : const ImageIcon(AssetImage(AppIcons.homeIcon)),
            label: _selectedIndex == 2 ? 'Home' : '',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 3 ? const ImageIcon(AssetImage(AppIcons.saveFilledIcon)) : const ImageIcon(AssetImage(AppIcons.saveIcon)),
            label: _selectedIndex == 3 ? 'Saved' : '',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 4 ? const ImageIcon(AssetImage(AppIcons.profileFilledIcon)) : const ImageIcon(AssetImage(AppIcons.profileIcon)),
            label: _selectedIndex == 4 ? 'Profile' : '',
          ),
        ],
      ),
    );
  }
}
