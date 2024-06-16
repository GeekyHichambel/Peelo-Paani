import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:peelo_paani/colors.dart';
import 'package:peelo_paani/components/water_gauge.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:peelo_paani/database.dart';

class CustomButtons extends StatefulWidget {
  const CustomButtons({super.key});

  @override
  CustomButtonsState createState()=> CustomButtonsState();
}

class CustomButtonsState extends State<CustomButtons>{

  late Future<Image> waterMinusFuture;
  late Future<Image> waterPlusFuture;

  @override
  void initState() {
    super.initState();
    waterMinusFuture = load_water_minus();
    waterPlusFuture = load_water_plus();
  }


  Future<Image> load_water_minus() async {
    Uint8List? data = await DataBase.iconStorage?.child('water_minus.png').getData();
    return Image.memory(data!, fit: BoxFit.fitHeight, width: 50, height: 50);
  }

  Future<Image> load_water_plus() async {
    Uint8List? data = await DataBase.iconStorage?.child('water_plus.png').getData();
    return Image.memory(data!, fit: BoxFit.fitHeight, width: 50, height: 50);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeNotifier = Provider.of<ThemeProvider>(context);
    final WaterNotifier waterNotifier = Provider.of<WaterNotifier>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: FutureBuilder<Image>(
              future: waterMinusFuture,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Icon(Icons.error); // Error icon
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return Shimmer(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: themeNotifier.isLightMode ? [AppColors.overlayWhite, Colors.grey] : [AppColors.overlayBlack, Colors.grey],
                      ),
                      child: const Icon(Icons.circle, size: 50,),
                    );
                }else {
                  return IconButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(themeNotifier.isLightMode ? AppColors.overlayWhite : AppColors.overlayBlack),
                    ),
                    onPressed: () => waterNotifier.reductIntake(0.1),
                    icon: snapshot.data!,
                  );
                }
              },
            ),
          ),
          GestureDetector(
            child: FutureBuilder<Image>(
              future: waterPlusFuture,
              builder: (context, snapshot){
                if (snapshot.hasError) {
                  return const Icon(Icons.error); // Error icon
                }else if (snapshot.connectionState == ConnectionState.waiting) {
                  return Shimmer(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: themeNotifier.isLightMode ? [AppColors.overlayWhite, Colors.grey] : [AppColors.overlayBlack, Colors.grey],
                      ),
                      child: const Icon(Icons.circle, size: 50,),
                    );
                } else {
                  return IconButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(themeNotifier.isLightMode ? AppColors.overlayWhite : AppColors.overlayBlack),
                  ),
                  onPressed: () => waterNotifier.addIntake(0.1),
                  icon: snapshot.data!,
                );
              }
            }
            ),
          ),
        ],
      ),
    );
  }
}