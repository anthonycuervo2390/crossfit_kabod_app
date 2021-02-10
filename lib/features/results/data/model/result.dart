import 'package:crossfit_kabod_app/features/results/data/model/result_field.dart';
import 'package:firebase_helpers/firebase_helpers.dart';

class Result {
  String id;
  DateTime date;
  WeightliftingScoreDetails weightliftingScore;
  WodScoreDetails wodScore;

  Result({this.id, this.date, this.weightliftingScore, this.wodScore});

  Result.fromDS(String id, Map<String, dynamic> data)
      : id = id,
        date = DateTime.fromMillisecondsSinceEpoch(data[ResultFields.date]),
        weightliftingScore = WeightliftingScoreDetails.fromJson(
            data[ResultFields.weightliftingScore]),
        wodScore = WodScoreDetails.fromJson(data[ResultFields.wodScore]);

  Map<String, dynamic> toMap() {
    return {
      ResultFields.date: date,
      ResultFields.weightliftingScore: weightliftingScore.toJson(),
      ResultFields.wodScore: wodScore.toJson(),
    };
  }
}

class WeightliftingScoreDetails {
  String kg;
  String reps;
  String rounds;
  String comment;
  String description;

  WeightliftingScoreDetails(
      {this.kg, this.reps, this.rounds, this.description, this.comment});

  WeightliftingScoreDetails.fromJson(Map<String, dynamic> json) {
    kg = json[WeightliftingScoreDetailsFields.kg];
    reps = json[WeightliftingScoreDetailsFields.reps];
    rounds = json[WeightliftingScoreDetailsFields.rounds];
    comment = json[WeightliftingScoreDetailsFields.comment];
    description = json[WeightliftingScoreDetailsFields.description];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[WeightliftingScoreDetailsFields.kg] = this.kg;
    data[WeightliftingScoreDetailsFields.reps] = this.reps;
    data[WeightliftingScoreDetailsFields.rounds] = this.rounds;
    data[WeightliftingScoreDetailsFields.comment] = this.comment;
    data[WeightliftingScoreDetailsFields.description] = this.description;
    return data;
  }
}

class WodScoreDetails {
  String reps;
  String rounds;
  String minutes;
  String seconds;
  String comment;
  String description;
  WodScoreDetails(
      {this.reps,
      this.rounds,
      this.minutes,
      this.seconds,
      this.comment,
      this.description});

  WodScoreDetails.fromJson(Map<String, dynamic> json) {
    reps = json[WodScoreDetailsFields.reps];
    rounds = json[WodScoreDetailsFields.rounds];
    minutes = json[WodScoreDetailsFields.minutes];
    seconds = json[WodScoreDetailsFields.seconds];
    comment = json[WodScoreDetailsFields.comment];
    description = json[WodScoreDetailsFields.description];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[WodScoreDetailsFields.reps] = this.reps;
    data[WodScoreDetailsFields.rounds] = this.rounds;
    data[WodScoreDetailsFields.minutes] = this.minutes;
    data[WodScoreDetailsFields.seconds] = this.seconds;
    data[WodScoreDetailsFields.comment] = this.comment;
    data[WodScoreDetailsFields.description] = this.description;
    return data;
  }
}
