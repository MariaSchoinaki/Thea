import 'dart:convert';
import 'ticket.dart';
import 'base_model.dart';
import '../util/parser.dart';
import 'user.dart';

class Play implements BaseModel {
  final String title;
  final String headline;
  final String description;
  final String playwriter;
  final List<String> cast;
  final String genre;
  final String runtime;
  final Map<String, Map<String, List<String>>> availableDates;
  final String afternoon;
  final String night;
  final Ticket regularTickets;
  final Ticket specialNeedsTickets;
  final String stage;
  final String ageLimit;
  final String additionalInfo;
  final String imageUrl;

  Play({
    required this.title,
    required this.headline,
    required this.description,
    required this.playwriter,
    required this.cast,
    required this.genre,
    required this.runtime,
    required this.availableDates,
    required this.afternoon,
    required this.night,
    required this.regularTickets,
    required this.specialNeedsTickets,
    required this.stage,
    required this.ageLimit,
    required this.additionalInfo,
    required this.imageUrl,
  });

  factory Play.fromJson(Map<String, dynamic> json) {
    return Play(
      title: json['title'] as String,
      headline: json['headline'] as String,
      description: json['description'] as String,
      playwriter: json['playwriter'] as String,
      cast: (json['cast'] as List<dynamic>).map((e) => e as String).toList(),
      genre: json['genre'] as String,
      runtime: json['runtime'] as String,
      availableDates: (json['availableDates'] as Map<String, dynamic>).map(
            (dateKey, dateValue) => MapEntry(
          dateKey,
          (dateValue as Map<String, dynamic>).map(
                (timeKey, timeValue) => MapEntry(
              timeKey,
              (timeValue as List<dynamic>).map((e) => e as String).toList(),
            ),
          ),
        ),
      ),
      afternoon: json['afternoon'] as String,
      night: json['night'] as String,
      regularTickets: Ticket.fromJson(json['regularTickets']),
      specialNeedsTickets: Ticket.fromJson(json['specialNeedsTickets']),
      stage: json['stage'] as String,
      ageLimit: json['ageLimit'] as String,
      additionalInfo: json['additionalInfo'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'headline': headline,
      'description': description,
      'playwriter': playwriter,
      'cast': cast,
      'genre': genre,
      'runtime': runtime,
      'availableDates': availableDates,
      'afternoon': afternoon,
      'night': night,
      'regularTickets': regularTickets.toJson(),
      'specialNeedsTickets': specialNeedsTickets.toJson(),
      'stage': stage,
      'ageLimit': ageLimit,
      'additionalInfo': additionalInfo,
      'imageUrl': imageUrl,
    };
  }
}