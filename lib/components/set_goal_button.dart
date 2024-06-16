import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peelo_paani/colors.dart';
import 'package:peelo_paani/components/water_gauge.dart';
import 'package:peelo_paani/globals.dart';
import 'package:provider/provider.dart';

class SetGoalButton extends StatelessWidget{
  const SetGoalButton({super.key});

  @override
  Widget build(BuildContext context){
    ThemeProvider themeNotifier = Provider.of<ThemeProvider>(context);
    WaterNotifier waterNotifier = Provider.of<WaterNotifier>(context);

    return Align(
      alignment: Alignment.center,
      child: IconButton(onPressed: (){
        showModalBottomSheet(context: context, builder: (BuildContext context)=> inputGoal(waterNotifier, themeNotifier), useSafeArea: true);
      },
      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(themeNotifier.isLightMode? AppColors.overlayWhite : AppColors.overlayBlack)), 
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      alignment: Alignment.center,
      icon: Text('Set Goal', style: TextStyle(fontFamily: Globals.appFont, fontSize: 25, fontWeight: FontWeight.w500, color: themeNotifier.isLightMode? AppColors.overlayBlack : AppColors.overlayWhite),)
      ),
    );
  }

  Widget inputGoal(WaterNotifier waterNotifier, ThemeProvider themeProvider){

    double amount = 0.0;

    return StatefulBuilder(
      builder: (context, setState) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Slider(value: amount, max: 10.0, onChanged: (newVal){
              setState((){
                amount = newVal;
              });
            })
          ),
          Center(
            child: RichText(text: TextSpan(text: amount.toStringAsFixed(1), style: TextStyle(color: themeProvider.isLightMode? AppColors.friendlyBlack : AppColors.friendlyWhite, fontSize: 24.0), children: const [
              TextSpan(text: ' L', style: TextStyle(fontSize: 24, color: AppColors.wateryBlue)),
            ])),
          ),
          const SizedBox(height: 8.0,),
          CupertinoButton(padding: const EdgeInsets.symmetric(horizontal: 40.0), color: AppColors.wateryBlue, onPressed: ()=> waterNotifier.setGoal(amount), child: const Icon(CupertinoIcons.check_mark)),
          const SizedBox(height: 8.0,),
        ],
      ),
    );
  }
}
