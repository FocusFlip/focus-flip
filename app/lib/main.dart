import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quezzy/cubits/intervention_screen/intervention_screen_cubit.dart';
import 'package:quezzy/cubits/shortcuts/heathy_app_intervention_state.dart';
import 'package:quezzy/cubits/shortcuts/shortcuts_cubit.dart';
import 'package:quezzy/repositories/main_repository.dart';
import 'package:quezzy/utils/local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'screens/splash_screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.black,
    statusBarBrightness: Brightness.light, // status bar color
  ));

  await Hive.initFlutter();
  MainRepository.instance.openBox();

  if (Platform.isIOS) {
    ShortcutsCubit.instance.init();
  }

  // Initialize local scheduled notifications
  tz.initializeTimeZones();
  initFlutterLocalNotificationsPlugin();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState appLifecycleState) {
    // TODO: refactor this method. Probably, it should be moved to a separate
    //  class and separated into several methods.

    if (appLifecycleState == AppLifecycleState.resumed) {
      print("[MyApp] The app is resumed");

      InterventionScreenState state = InterventionScreenCubit.instance.state;

      if (state is InterventionScreenOpened &&
          !(state is WaitingForInterventionResult)) {
        int currentTimestamp = DateTime.now().millisecondsSinceEpoch;
        int tolerableTimeFrom = currentTimestamp - 1000; // last second

        if (state.timestamp < tolerableTimeFrom) {
          print("[MyApp] The intervention screen can be closed because"
              " the app has been opened not from a shortcut, but from the"
              " app icon");

          InterventionScreenCubit.instance.closeScreen();
        }
      }

      // TODO: write test if this method is called after method call handler
      /// in shortcuts_cubit.dart. Manual test in debug mode shows it on IOS,
      /// but it's not reliable.

      _logHealthyAppInterventionState();
    }
  }

  Future<void> _logHealthyAppInterventionState() async {
    HealthyAppInterventionState healthyAppInterventionState =
        await ShortcutsCubit.instance.getHealthyAppInterventionState();
    print("[MyApp] Healthy app intervention state (on iOS): "
        "$healthyAppInterventionState");
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Quezzy',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
            primarySwatch: Colors.purple,
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
