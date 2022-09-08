import 'app_config.dart';

mixin Environment {
  static final dev = AppConfig(
      appName: 'Desafio Starta Flutter DEV',
      appEnvironment: AppEnvironment.development,
      apiBaseUrl: 'https://api.themoviedb.org/3/');

  static final prod = AppConfig(
    appName: 'Desafio Starta Flutter',
    appEnvironment: AppEnvironment.production,
    apiBaseUrl: 'https://api.themoviedb.org/3/',
  );
}
