import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:innovins_tech/const/app_colors.dart';
import 'package:innovins_tech/main.dart';
import 'package:innovins_tech/models/data_wrapper.dart';
import 'package:innovins_tech/models/product_data_model.dart';
import 'package:innovins_tech/views/home.dart';

import 'package:innovins_tech/views/home_screen/home_screen.dart';
import 'package:innovins_tech/views/product_detail_screen/product_detail_screen.dart';
import 'package:innovins_tech/views/profile_screen/profile_screen.dart';
import 'package:innovins_tech/views/sign_in_screen/sign_in_screen.dart';
import 'package:innovins_tech/views/sign_up_screen/sign_up_screen.dart';
import 'package:innovins_tech/views/splash_screen/splash_screen.dart';

class AppRouter {
  AppRouter.internal();
  static AppRouter _instance = AppRouter.internal();
  factory AppRouter() => _instance;

  GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: '/',
        name: SplashScreen.id,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: '/signinscreen',
        name: SignInScreen.id,
        builder: (context, state) => SignInScreen(),
        routes: [
          GoRoute(
            path: 'signupscreen',
            name: SignUpScreen.id,
            builder: (context, state) => SignUpScreen(),
          ),
        ],
      ),
      GoRoute(
          path: '/home',
          name: Home.id,
          builder: (context, state) => Home(),
          routes: [
            GoRoute(
              path: 'homescreen',
              name: HomeScreen.id,
              builder: (context, state) => HomeScreen(),
            ),
            GoRoute(
                path: 'productdetailscreen',
                name: ProductDetailScreen.id,
                builder: (context, state) {
                  DataWrapper data = state.extra as DataWrapper;
                  return ProductDetailScreen(
                    data: data,
                  );
                }),
            GoRoute(
              path: 'profilescreen',
              name: ProfileScreen.id,
              builder: (context, state) => ProfileScreen(),
            ),
          ]),
    ],
  );
}
