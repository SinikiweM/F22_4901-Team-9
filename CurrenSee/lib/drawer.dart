import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidget();
}
class _DrawerWidget extends State<DrawerWidget>{

  bool silent = false;
  bool conversion = false;
  String homecurr = 'USD';


  FlutterTts flutterTts = FlutterTts(); // This initializes a text to speech instance.

  Future _speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(1);
    await flutterTts.speak(text);
  }// so now whenever we call flutterTts.speak() it uses these settings.

  @override
  Widget build(BuildContext context) => Drawer(
    child: ListView(
      children: [
        const DrawerHeader (child: Text('CurrenSee')),

        ListTile( //The drop dowm to choose Home Currency
          title: Text('Home Currency'),
          trailing: DropdownButton<String>(
            value: homecurr,
            onChanged: (String? val){
              setState(() {
                homecurr = val!;
                flutterTts.speak(homecurr); //this reads out what the new home currency is.
                //will be used in demo to show that we have tts imported.
              });
            } ,
            items: const [
              DropdownMenuItem(
                value: 'USD',
                child: Text('USD'),
              ),
              DropdownMenuItem(
                  value: 'EURO',
                  child: Text('EURO')
              ),
              DropdownMenuItem(
                  value: 'GBP',
                  child: Text('GBP')
              ),
              DropdownMenuItem(
                  value: 'AUS',
                  child: Text('AUS')
              ),
            ],
          ),
        ),

        SwitchListTile( //Toggle Silent mode on & off
          title: Text('Silent Mode'),
          value: silent,
          //placeholder for actual silent function
          //probably need new class to implement haptics
          onChanged: (bool k){
            setState(() {
              silent = k;
            });
          },
        ),

        SwitchListTile( //Toggle currency conversion on and off
          title: Text('Currency conversion'),
          value: conversion,
          //placeholder for actual conversion function
          //probably need new class to link to conversion API
          onChanged: (bool j){
            setState(() {
              conversion = j;
            });
          },
        ),
      ],
    ),
  );
}
