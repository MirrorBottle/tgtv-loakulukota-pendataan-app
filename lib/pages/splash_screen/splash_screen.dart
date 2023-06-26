import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loakulukota_app/services/auth_service.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../constant.dart';
import '../../models/app_config.dart';
import '../../services/http_service.dart';
import 'on_board.dart';
import 'package:loakulukota_app/pages/home/main_screen.dart';
import 'package:loakulukota_app/pages/auth/sign_in.dart';
import 'package:loakulukota_app/pages/auth/log_in.dart';
import 'package:loakulukota_app/pages/auth/maintenance.dart';
import 'package:flutter/foundation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> _setup(BuildContext _context) async {
    final getIt = GetIt.instance;
    final configFile = await rootBundle.loadString("assets/config/main.json");
    final configData = jsonDecode(configFile);

    getIt.registerSingleton<AppConfig>(AppConfig(
        BASE_API_URL: configData['BASE_API_URL'],
        BASE_IMAGE_API_URL: configData['BASE_IMAGE_API_URL'],
        API_KEY: configData['API_KEY']));

    getIt.registerSingleton<HTTPService>(HTTPService());

    getIt.registerSingleton<AuthService>(AuthService());
  }

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 2));

    await Future.delayed(const Duration(seconds: 2)).then(
      (_) => _setup(context).then(
        (_) => goTo(),
      ),
    );
    defaultBlurRadius = 10.0;
    defaultSpreadRadius = 0.5;
  }

  void goTo() async {
    finish(context);
    AuthService _authService = AuthService();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirst = prefs.getBool('isFirst') ?? true;
    bool isLogin = prefs.getBool('isLogin') ?? false;
    Map<dynamic, dynamic> isMaintenance = await _authService.maintenance();
    if (isMaintenance['status']) {
      const MaintenanceScreen().launch(context);
    } else {
      if (isFirst) {
        const OnBoard().launch(context, isNewTask: true);
      } else {
        if (isLogin) {
          // if(defaultTargetPlatform != TargetPlatform.windows) {
          //   const LogInScreen().launch(context);
          // } else {
          //   const MainScreen().launch(context);
          // }
          const MainScreen().launch(context);
        } else {
          const SignIn().launch(context);
        }
      }
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/splash.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
              ),
              const Image(
                image: AssetImage('assets/images/logo_full.png'),
                height: 200,
              ),
              const Spacer(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'Version 1.0.0',
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
