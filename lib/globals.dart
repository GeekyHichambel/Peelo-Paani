import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Globals {
  static const String appFont = 'WaveFont';
  static FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  static Future<bool> loadTheme() async {
    if (await secureStorage.read(key: 'AppTheme') != null){
      bool isLightMode = await secureStorage.read(key: 'AppTheme') == 'true';
      return isLightMode;
    }
    return false;
  }

  static Future<List<double>> loadData() async{
    if (await secureStorage.read(key: 'currentIntake') != null || await secureStorage.read(key: 'gaolIntake') != null){
      double currentIntake = double.parse(await secureStorage.read(key: 'currentIntake')?? '0.0');
      double goalIntake = double.parse(await secureStorage.read(key: 'goalIntake')?? '0.0');
      return [currentIntake, goalIntake];
    }
    return [0.0, 0.0];
  }
}
