import 'package:desafio_starta_flutter/screens/app_screen.dart';
import 'package:flutter/material.dart';

import 'config/app_config.dart';
import 'config/environments.dart';

void main() {
  AppConfig.getInstance(config: Environment.dev);
  runApp(AppScreen());
}

