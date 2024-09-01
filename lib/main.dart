import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:innovins_tech/const/app_router.dart';
import 'package:innovins_tech/controller/auth_controller.dart';
import 'package:innovins_tech/controller/home_controller.dart';
import 'package:provider/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const InnovinsTech());
}

class InnovinsTech extends StatelessWidget {
  const InnovinsTech({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthController()),
          ChangeNotifierProvider(create: (_) => HomeController()),
        ],
        child: MaterialApp.router(
          routerConfig: AppRouter().router,
        ),
      ),
    );
  }
}
