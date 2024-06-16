import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gradient_mask/gradient_mask.dart';
import 'package:peelo_paani/colors.dart';
import 'package:peelo_paani/database.dart';
import 'package:peelo_paani/globals.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';


class WaterNotifier with ChangeNotifier{
  double _currentIntake = 0.0;
  double _goalIntake = 1.0;

  double get currentIntake => _currentIntake;
  double get goalIntake => _goalIntake;

  WaterNotifier(data) : _currentIntake = data[0], _goalIntake = data[1];

  void addIntake(double amount) async{
    if (_currentIntake + amount > _goalIntake) return;
    _currentIntake += amount;
    _currentIntake = double.parse(_currentIntake.toStringAsFixed(1));
    notifyListeners();
    await Globals.secureStorage.write(key: 'currentIntake', value: _currentIntake.toString());
  }

  void reductIntake(double amount) async{
    if (_currentIntake - amount < 0.0) return;
    _currentIntake -= amount;
    _currentIntake = double.parse(_currentIntake.toStringAsFixed(1));
    notifyListeners();
    await Globals.secureStorage.write(key: 'currentIntake', value: _currentIntake.toString());
  }

  void setGoal(double amount) async{
    _goalIntake = amount;
    _goalIntake = double.parse(_goalIntake.toStringAsFixed(1));
    notifyListeners();
    await Globals.secureStorage.write(key: 'goalIntake', value: _goalIntake.toString());
  }
}

class WaterGauge extends StatefulWidget{

  const WaterGauge({super.key});

  @override
  WaterGaugeState createState()=> WaterGaugeState();
}

class WaterGaugeState extends State<WaterGauge>{

  late Future loadGauge;

  @override
  void initState(){
    super.initState();
    loadGauge = load_water_glass();
  }

  Future<Image> load_water_glass() async{
    Uint8List? data = await DataBase.iconStorage?.child('glass.png').getData();
    return Image.memory(data!, height: 300,);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeNotifier = Provider.of<ThemeProvider>(context);
    final WaterNotifier waterNotifier = Provider.of<WaterNotifier>(context);

    double percentage = (waterNotifier.currentIntake / waterNotifier.goalIntake).clamp(0.0, 1.0);
    // print(percentage);

    return FutureBuilder(
      future: loadGauge,
      builder: (context, snapshot) {
        if (snapshot.hasError){
          return const Icon(Icons.error);
        } else if (snapshot.connectionState == ConnectionState.waiting){
          return Shimmer(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: themeNotifier.isLightMode ? [AppColors.overlayWhite, Colors.grey] : [AppColors.overlayBlack, Colors.grey],
                      ),
                      child: Container(height: 300, color: Colors.grey, decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16.0))),),
                    );
        }else{
          return  Stack(
        alignment: Alignment.center,
        children: [
          GradientMask(
            gradient: LinearGradient(colors: themeNotifier.isLightMode? [AppColors.wateryBlue.withOpacity(0.5), AppColors.overlayWhite, AppColors.overlayWhite, AppColors.overlayWhite] : [AppColors.wateryBlue.withOpacity(0.5), AppColors.overlayBlack, AppColors.overlayBlack, AppColors.overlayBlack], 
            begin: Alignment.bottomCenter, 
            end: Alignment.topCenter,
            stops: [percentage, (percentage + 0.01).clamp(0.0, 1.0), (percentage + 0.02).clamp(0.0, 1.0), 1.0],
            ),
            child: snapshot.data,
            ),
          Positioned(
            bottom: 50,
            child: Column(
              children: [
                Text(
                  '${(percentage * 100).toStringAsFixed(1)}%',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.wateryBlue),
                ),
                Text(
                  '${waterNotifier.currentIntake} / ${waterNotifier.goalIntake} L',
                  style: TextStyle(fontSize: 18, color: AppColors.wateryBlue.withOpacity(0.5)),
                ),
              ],
            ),
          ),
        ],
      );
        }
      },
    );
  }
}
