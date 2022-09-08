import 'package:desafio_starta_flutter/config/app_theme.dart';
import 'package:desafio_starta_flutter/screens/movie_details/movie_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import '../config/app_config.dart';
import '../shared/global.dart';
import 'movie_details/movie_details_screen.dart';

class AppScreen extends StatefulWidget {
  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _registerStores();
    super.initState();
  }

  void _registerStores() {
    var getIt = GetIt.I;
    getIt.registerSingleton(MovieDetailsController());
    getIt.registerSingleton(GlobalKey<NavigatorState>());
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          title: AppConfig.getInstance()!.appName,
          theme: appTheme(context),
          home: MovieDetailsScreen());
    });
  }
}
