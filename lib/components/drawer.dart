import 'package:flutter/material.dart';
import 'package:peelo_paani/colors.dart';
import 'package:provider/provider.dart';


class CustomDrawerSelected with ChangeNotifier{
  int _selected = 1;

  int get selected => _selected;

  CustomDrawerSelected(selected) : _selected = selected;
  
  void set_selected(int selected){
    _selected = selected;
    notifyListeners();
  }
}

class CustomDrawer extends StatelessWidget{

  final double? width;

  const CustomDrawer(this.width, {super.key});

  @override
  Widget build(BuildContext context){
   
    final CustomDrawerSelected selected = Provider.of<CustomDrawerSelected>(context);
    final ThemeProvider themeNotifier = Provider.of<ThemeProvider>(context);

    return Drawer(
      width: width,
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Image.asset('assets/images/app_logo.png', fit: BoxFit.fill,)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListBody(
                children: [
                  ListTile(
                    onTap: () => selected.set_selected(1),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                    selected: selected.selected == 1,
                    selectedTileColor: themeNotifier.isLightMode? AppColors.friendlyWhite : AppColors.friendlyBlack,
                    selectedColor: themeNotifier.isLightMode? AppColors.friendlyBlack : AppColors.friendlyWhite,
                    leading: const Icon(Icons.house_rounded),
                    title: const Text('Home'),
                  ),
                  ListTile(
                      onTap: () => selected.set_selected(2),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                    selected: selected.selected == 2,
                    selectedTileColor: themeNotifier.isLightMode? AppColors.friendlyWhite : AppColors.friendlyBlack,
                    selectedColor: themeNotifier.isLightMode? AppColors.friendlyBlack : AppColors.friendlyWhite,
                    leading: const Icon(Icons.bar_chart_rounded),
                    title: const Text('Stats'),
                  )
                ],
              ),
            )
        ],
      )
    );
  }
}