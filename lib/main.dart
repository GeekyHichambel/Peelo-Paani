import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:peelo_paani/colors.dart';
import 'package:peelo_paani/components/drawer.dart';
import 'package:peelo_paani/components/water_gauge.dart';
import 'package:peelo_paani/globals.dart';
import 'package:peelo_paani/pages/home_page.dart';
import 'package:peelo_paani/pages/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:peelo_paani/database.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  bool isLightMode = await Globals.loadTheme();
  await DataBase.connect();
  List<double> waterData = await Globals.loadData();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => WaterNotifier(waterData)),
      ChangeNotifierProvider(create: (context) => ThemeProvider(isLightMode)),
      ChangeNotifierProvider(create: (context) => CustomDrawerSelected(1)),
    ],
    child: MyApp(isLightMode)
  ));
}

class MyApp extends StatelessWidget {
  final bool isLightMode;

  const MyApp(this.isLightMode, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
        builder: (context, themeNotifier, child){
        return MaterialApp(
          title: 'Peelo Paani',
          theme: themeNotifier.themeData,
          debugShowCheckedModeBanner: false,
          routes: {
            '/splashScreen' : (context) => const SplashScreen(),
            '/homePage' : (context) => const HomePage(),
          },
          home: const SplashScreen(),
        );  
      },
    );
  }
}

