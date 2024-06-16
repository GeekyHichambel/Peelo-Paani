import 'package:flutter/material.dart';
import 'package:peelo_paani/globals.dart';

@immutable
class AppColors{
  static const friendlyWhite = Color(0xfffafafa);
  static const overlayWhite = Color.fromARGB(255, 225, 225, 225);
  static const friendlyBlack = Color(0xff101415);
  static const overlayBlack = Color(0xff282828);
  static const wateryBlue = Color(0xff38b6ff);
}

class ThemeProvider with ChangeNotifier{
  ThemeData _currentTheme;
  bool _isLightMode;


  ThemeProvider(this._isLightMode) : _currentTheme = _isLightMode ? lightMode : darkMode;

  ThemeData get themeData => _currentTheme;

  bool get isLightMode => _isLightMode; 

  void toggleTheme() async{
    _isLightMode = !_isLightMode;
    _currentTheme = _isLightMode ? lightMode : darkMode;
    notifyListeners();
    await Globals.secureStorage.write(key: 'AppTheme',value: (_isLightMode).toString());
  }
}

ThemeData lightMode = ThemeData(
  scaffoldBackgroundColor: AppColors.friendlyWhite, 
  textTheme: const TextTheme(displaySmall: TextStyle(color: AppColors.friendlyBlack)),
  primaryTextTheme: const TextTheme(displaySmall: TextStyle(color: AppColors.friendlyBlack)),
  iconTheme: const IconThemeData(color: AppColors.friendlyBlack),
  appBarTheme: const AppBarTheme(backgroundColor: AppColors.overlayWhite),
  drawerTheme: const DrawerThemeData(backgroundColor: AppColors.overlayWhite),
  cardTheme: const CardTheme(color: AppColors.overlayWhite),
  bottomSheetTheme: const BottomSheetThemeData(backgroundColor: AppColors.overlayWhite),
  sliderTheme: const SliderThemeData(thumbColor: AppColors.wateryBlue, activeTrackColor: AppColors.friendlyBlack, inactiveTrackColor: AppColors.friendlyBlack),
  listTileTheme: const ListTileThemeData(iconColor: AppColors.overlayBlack, titleAlignment: ListTileTitleAlignment.center, titleTextStyle: TextStyle(color: AppColors.overlayBlack, fontFamily: Globals.appFont, fontSize: 24))
);

ThemeData darkMode = ThemeData(
  scaffoldBackgroundColor: AppColors.friendlyBlack,
  textTheme: const TextTheme(displaySmall: TextStyle(color: AppColors.friendlyWhite)),
  primaryTextTheme: const TextTheme(displaySmall: TextStyle(color: AppColors.friendlyWhite)),
  iconTheme: const IconThemeData(color: AppColors.friendlyWhite),
  appBarTheme: const AppBarTheme(backgroundColor: AppColors.overlayBlack),
  drawerTheme: const DrawerThemeData(backgroundColor: AppColors.overlayBlack),
  cardTheme: const CardTheme(color: AppColors.overlayBlack),
  bottomSheetTheme: const BottomSheetThemeData(backgroundColor: AppColors.overlayBlack),
  sliderTheme: const SliderThemeData(thumbColor: AppColors.wateryBlue, activeTrackColor: AppColors.friendlyWhite, inactiveTrackColor: AppColors.friendlyWhite),
  listTileTheme: const ListTileThemeData(iconColor: AppColors.overlayWhite, titleAlignment: ListTileTitleAlignment.center, titleTextStyle: TextStyle(color: AppColors.overlayWhite, fontFamily: Globals.appFont, fontSize: 24))
);