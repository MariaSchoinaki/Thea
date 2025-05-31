import 'package:thea/models/play.dart';

import '../data/plays.dart' as plays_db;
import '../util/parser.dart';

List<Play> plays = [];



Future<void> loadPlays() async {
  final String response = plays_db.rawPlayData;
  final data = parseJsonList(response, (map) => Play.fromJson(map));
  plays = data;
}