import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>{

  @override
  void initState(){
    super.initState();
    loadConfigs(context).then((_){
      Future.delayed(const Duration(seconds: 3),(){
        Navigator.of(context).pushReplacementNamed('/homePage');
      });
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Image.asset('assets/images/app_logo.png', width: 250, height: 250,),
        ),
      ),
    );
  }

  Future<void> loadConfigs(BuildContext context) async{
   
  }
}