// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'agenda_model.g.dart';

@HiveType(typeId: 0)
class AgendaModel {
  @HiveField(0)
  String startingTime;
  @HiveField(1)
  String endingTime;
  @HiveField(2)
  String title;
  @HiveField(3)
  String description;
  @HiveField(4)
  List<String> members;
  @HiveField(5)
  String id;
  @HiveField(6)
  String date;
  AgendaModel({
    required this.startingTime,
    required this.endingTime,
    required this.title,
    required this.description,
    required this.members,
    required this.id,
    required this.date,
  });

  AgendaModel copyWith({
    String? startingTime,
    String? endingTime,
    String? title,
    String? description,
    List<String>? members,
    String? id,
    String? date,
  }) {
    return AgendaModel(
      startingTime: startingTime ?? this.startingTime,
      endingTime: endingTime ?? this.endingTime,
      title: title ?? this.title,
      description: description ?? this.description,
      members: members ?? this.members,
      id: id ?? this.id,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'startingTime': startingTime,
      'endingTime': endingTime,
      'title': title,
      'description': description,
      'members': members,
      'id': id,
      'date': date,
    };
  }

  factory AgendaModel.fromMap(Map<String, dynamic> map) {
    return AgendaModel(
      startingTime: map['startingTime'] as String,
      endingTime: map['endingTime'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      members: List<String>.from((map['members'] as List<String>),),
      id: map['id'] as String,
      date: map['date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AgendaModel.fromJson(String source) => AgendaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AgendaModel(startingTime: $startingTime, endingTime: $endingTime, title: $title, description: $description, members: $members, id: $id, date: $date)';
  }

  @override
  bool operator ==(covariant AgendaModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.startingTime == startingTime &&
      other.endingTime == endingTime &&
      other.title == title &&
      other.description == description &&
      listEquals(other.members, members) &&
      other.id == id &&
      other.date == date;
  }

  @override
  int get hashCode {
    return startingTime.hashCode ^
      endingTime.hashCode ^
      title.hashCode ^
      description.hashCode ^
      members.hashCode ^
      id.hashCode ^
      date.hashCode;
  }
  }
