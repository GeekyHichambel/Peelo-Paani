import 'package:flutter/material.dart';
import 'package:peelo_paani/colors.dart';
import 'package:peelo_paani/components/custom_buttons.dart';
import 'package:peelo_paani/components/set_goal_button.dart';
import 'package:provider/provider.dart';
import 'package:peelo_paani/components/app_bar.dart';
import 'package:peelo_paani/components/drawer.dart';
import 'package:peelo_paani/components/water_gauge.dart';
import 'package:peelo_paani/components/safe_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeNotifier = Provider.of<ThemeProvider>(context);

    return SafeScaffold(
      appbar: CustomAppBar(themeNotifier),
      drawer: const CustomDrawer(200),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WaterGauge(),
          CustomButtons(),
          SetGoalButton(),
        ],
      ),
    );
  }
}