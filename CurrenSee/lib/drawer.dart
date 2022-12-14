import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidget();
}
class _DrawerWidget extends State<DrawerWidget>{

  bool silent = false;
  bool conversion = false;
  String homecurr = 'USD';

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
