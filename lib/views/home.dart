import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innovins_tech/const/app_colors.dart';
import 'package:innovins_tech/views/home_screen/home_screen.dart';
import 'package:innovins_tech/views/profile_screen/profile_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static String id = "Home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedScreen = 0;
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedScreen = 0;
                  pageController.jumpToPage(0);
                });
              },
              child: Icon(
                size: 30.sp,
                Icons.home_filled,
                color: selectedScreen == 0
                    ? AppColors.greenColor
                    : AppColors.blackColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedScreen = 1;
                  pageController.jumpToPage(1);
                });
              },
              child: Icon(
                size: 30.sp,
                Icons.person_2_rounded,
                color: selectedScreen == 1
                    ? AppColors.greenColor
                    : AppColors.blackColor,
              ),
            ),
          ],
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: PageView(
          physics: ScrollPhysics(parent: ClampingScrollPhysics()),
          onPageChanged: (value) {
            setState(() {
              selectedScreen = value;
            });
          },
          children: [
            HomeScreen(),
            ProfileScreen(),
          ],
          controller: pageController,
        ),
      ),
    );
  }
}
