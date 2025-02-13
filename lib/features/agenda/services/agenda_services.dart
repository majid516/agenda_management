import 'dart:math';

import 'package:agenda_management/features/agenda/model/agenda_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AgendaServices {
  void addNewAgenda(AgendaModel agenda) async {
    
    try {
      final agendaBox = await Hive.openBox<AgendaModel>('agendaBox');
      await agendaBox.put(agenda.id, agenda);
    } catch (e, s) {
      throw Exception('exception throwed by adding new agenda, $e, in $s');
    }
  }

  Future<List<AgendaModel>> getAllAgendas() async {
    try {
      final agendaBox = await Hive.openBox<AgendaModel>('agendaBox');
      final agendaModelList = agendaBox.values.toList();
      return agendaModelList;
    } catch (e, s) {
      throw Exception('exception throwed by fetching all agendas, $e, in $s');
    }
  }
}

int generateRandomNumber() {
  Random random = Random();
  return 10000000 + random.nextInt(90000000);
}
