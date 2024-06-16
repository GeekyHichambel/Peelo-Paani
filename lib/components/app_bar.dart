import 'package:flutter/material.dart';
import 'package:peelo_paani/colors.dart';

class CustomAppBar extends StatelessWidget{

  final ThemeProvider themeNotifier;

  const CustomAppBar(this.themeNotifier, {super.key});

  @override
  Widget build(BuildContext context){
    return PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DrawerButton(
                onPressed: (){
                  Scaffold.of(context).openDrawer();
                },
              ),
              IconButton(onPressed: (){
                themeNotifier.toggleTheme();
              }, icon: !themeNotifier.isLightMode ? const Icon(Icons.light_mode_rounded) :
             const Icon(Icons.dark_mode_rounded))
            ],
          ),
      );
  }
}