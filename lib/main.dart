import 'package:agenda_management/common/screen_size/screen_size.dart';
import 'package:agenda_management/features/agenda/model/agenda_model.dart';
import 'package:agenda_management/features/agenda/view/screens/home_screen.dart';
import 'package:agenda_management/features/agenda/view/screens/add_agenda_screen.dart';
import 'package:agenda_management/features/agenda/view/screens/select_members_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(AgendaModelAdapter().typeId)){
    Hive.registerAdapter(AgendaModelAdapter());
  }
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize().initializeScreenSize(context);
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AgendaHomeScreen(), 
      routes: {
        '/homeScreen' : (context)=> AgendaHomeScreen(),
        '/addTaskScreen' : (context)=> AddAgendaScreen(),
        '/selectMembersScreen' : (context)=> SelectMembersScreen(),
      },

    );
  }
}
