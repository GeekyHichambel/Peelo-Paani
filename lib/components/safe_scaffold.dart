import 'package:flutter/material.dart';

class SafeScaffold extends StatelessWidget{
  final Widget? child;
  final Widget? appbar;
  final Widget? drawer;

  const SafeScaffold({super.key, this.child, this.appbar, this.drawer});

  @override
  Widget build(BuildContext context){
    return SafeArea(child: Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: appbar!,
      ),
      body: child,
      drawer: drawer,
      key: key,
    ));
  }
}