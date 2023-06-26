import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loakulukota_app/pages/announcement/announcement_detail.dart';
import 'package:loakulukota_app/pages/announcement/announcement_list.dart';
import 'package:loakulukota_app/pages/birth/birth_form.dart';
import 'package:loakulukota_app/pages/birth/birth_list.dart';
import 'package:loakulukota_app/pages/death/death_form.dart';
import 'package:loakulukota_app/pages/death/death_list.dart';
import 'package:loakulukota_app/pages/information/information_list.dart';
import 'package:loakulukota_app/pages/moving_in/moving_in_form.dart';
import 'package:loakulukota_app/pages/moving_in/moving_in_list.dart';
import 'package:loakulukota_app/pages/moving_out/moving_out_form.dart';
import 'package:loakulukota_app/pages/moving_out/moving_out_list.dart';
import 'package:loakulukota_app/pages/report/report_list.dart';
import 'package:loakulukota_app/pages/splash_screen/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loakulukota_app/globals.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loakulukota_app/pages/villager/villager_detail.dart';
import 'package:nb_utils/nb_utils.dart';


// AUTH
import 'package:loakulukota_app/pages/auth/sign_in.dart';
import 'package:loakulukota_app/pages/auth/log_in.dart';

// SETTINGS
import 'package:loakulukota_app/pages/settings/settings_change_password.dart';
import 'package:loakulukota_app/pages/settings/settings_profil.dart';

// * ANNOUNCEMENT

// * INFORMATION

// * VILLAGERS

// * BIRTH

// * DEATH

// * MOVING-IN

// * MOVING-OUT

// * REPORT

import 'dart:convert';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(defaultTargetPlatform != TargetPlatform.windows) {
    if(kIsWeb) {
      await Firebase.initializeApp(options: const FirebaseOptions(
        apiKey: "AIzaSyDsD75Pz7Z4ktjKdLHa20qNTn4Ws5NLr3o",
        appId: "1:12801065433:android:fabee83f004f5b9a2859c8",
        messagingSenderId: "12801065433",
        projectId: "anandita-c67ba",
      ));
    } else {
      await Firebase.initializeApp();
    }
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
 const MyApp({
    Key? key
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    if(state == AppLifecycleState.inactive || state == AppLifecycleState.paused) return;

    if(state == AppLifecycleState.detached) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Map<String,dynamic> _auth = json.decode(prefs.getString('auth') ?? "{}");
      if(_auth['id'] != null) {
        EasyLoading.show(status: 'Mohon Ditunggu', maskType: EasyLoadingMaskType.black);
        navigatorKey.currentState!.pushNamed('log-in');
        EasyLoading.dismiss();
      }
    }
    if(state == AppLifecycleState.detached) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(
          Theme.of(context).textTheme,
        ),
        // Add the line below to get horizontal sliding transitions for routes.
        pageTransitionsTheme: const PageTransitionsTheme(builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder(),}),
      ),
      title: 'Anandita App',
      scaffoldMessengerKey: snackbarKey,
      navigatorKey: navigatorKey,
      home: const SplashScreen(),
      builder: EasyLoading.init(),
      routes: {
        'log-in': (context) => const LogInScreen(),
        'sign-in': (context) => const SignIn(),
        'settings-profil': (context) => const SettingsProfilScreen(),
        'settings-change-password': (context) => const SettingsChangePasswordScreen(),
        'birth-list':(context) => const BirthListScreen(),
        'birth-form':(context) => const BirthFormScreen(),
        'moving-in-list': (context) => const MovingInListScreen(),
        'moving-in-form':(context) => const MovingInFormScreen(),
        'moving-out-list':(context) => const MovingOutListScreen(),
        'moving-out-form':(context) => const MovingOutFormScreen(),
        'death-form': (context) => const DeathFormScreen(),
        'death-list':(context) => const DeathListScreen(),
        'report-list': (context) => const ReportListScreen(),
        'information-list': (context) => const InformationListScreen(),
        'announcement-list': (context) => const AnnouncementListScreen(),
        'announcement-detail':(context) => AnnouncementDetailScreen(args: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        'villager-detail':(context) => VillagerDetailScreen(args: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>)

      },
    );
  }
}
