import 'package:agenda_management/common/screen_size/screen_size.dart';
import 'package:agenda_management/features/view/screens/first_screen.dart';
import 'package:agenda_management/features/view/screens/second_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize().initializeScreenSize(context);
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AgendaScreen(),
      routes: {
        '/homeScreen' : (context)=> AgendaScreen(),
        '/addTaskScreen' : (context)=> AddAgendaScreen(),
      },

    );
  }
}
