import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gastrack/button_navigation/src/models/bottom_bar_item_model.dart';
import 'package:gastrack/button_navigation/src/notch_bottom_bar.dart';
import 'package:gastrack/button_navigation/src/notch_bottom_bar_controller.dart';
import 'package:gastrack/page/Pesanansaya.dart';
import 'package:gastrack/page/Profilsaya.dart';
import 'package:gastrack/page/home.dart';

// ignore: camel_case_types
class MyHomePage_agent extends StatefulWidget {
  const MyHomePage_agent({Key? key}) : super(key: key);

  @override
  State<MyHomePage_agent> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage_agent> {
  /// Controller to handle PageView and also handles initial page
  final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  final _controller = NotchBottomBarController(index: 0);

  int maxCount = 5;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// widget list
  final List<Widget> bottomBarPages = [
    const Home(),
    const PesananSaya(),
    const Profilsaya(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              /// Provide NotchBottomBarController
              notchBottomBarController: _controller,
              color: const Color.fromRGBO(249, 1, 131, 1.0),
              showLabel: false,
              notchColor: const Color.fromRGBO(249, 1, 131, 1.0),

              /// restart app if you change removeMargins
              removeMargins: false,
              bottomBarWidth: 500,
              durationInMilliSeconds: 300,
              bottomBarItems: [
                BottomBarItem(
                  inActiveItem: SvgPicture.asset(
                    'assets/svg/Home.svg',
                    color: Colors.white,
                  ),
                  activeItem: SvgPicture.asset(
                    'assets/svg/Home.svg',
                    color: Colors.white,
                  ),
                ),
                BottomBarItem(
                  inActiveItem: SvgPicture.asset(
                    'assets/svg/pesanan_saya.svg',
                    color: Colors.white,
                  ),
                  activeItem: SvgPicture.asset(
                    'assets/svg/pesanan_saya.svg',
                    color: Colors.white,
                  ),
                ),
                BottomBarItem(
                  inActiveItem: SvgPicture.asset(
                    'assets/svg/user.svg',
                    color: Colors.white,
                  ),
                  activeItem: SvgPicture.asset(
                    'assets/svg/user.svg',
                    color: Colors.white,
                  ),
                ),
              ],
              onTap: (index) {
                /// perform action on tab change and to update pages you can update pages without pages
                log('current selected index $index');
                _pageController.jumpToPage(index);
              },
            )
          : null,
    );
  }
}

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromARGB(255, 25, 0, 127),
        child: const Center(child: Text('Page Setting')));
  }
}
