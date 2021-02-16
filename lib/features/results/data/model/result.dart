import 'package:crossfit_kabod_app/features/results/data/model/result_field.dart';

class Result {
  String id;
  DateTime date;
  ProgramOneScoreDetails programOneScore;
  ProgramTwoScoreDetails programTwoScore;
  ProgramThreeScoreDetails programThreeScore;
  ProgramFourScoreDetails programFourScore;
  ProgramFiveScoreDetails programFiveScore;

  Result(
      {this.id,
      this.date,
      this.programOneScore,
      this.programTwoScore,
      this.programThreeScore,
      this.programFourScore,
      this.programFiveScore});

  Result.fromDS(String id, Map<String, dynamic> data)
      : id = id,
        date = DateTime.fromMillisecondsSinceEpoch(data[ResultFields.date]),
        programOneScore =
            ProgramOneScoreDetails.fromJson(data[ResultFields.programOneScore]),
        programTwoScore =
            ProgramTwoScoreDetails.fromJson(data[ResultFields.programTwoScore]),
        programThreeScore = ProgramThreeScoreDetails.fromJson(
            data[ResultFields.programThreeScore]),
        programFourScore = ProgramFourScoreDetails.fromJson(
            data[ResultFields.programFourScore]),
        programFiveScore = ProgramFiveScoreDetails.fromJson(
            data[ResultFields.programFiveScore]);

  Map<String, dynamic> toMap() {
    return {
      ResultFields.date: date,
      ResultFields.programOneScore: programOneScore.toJson(),
      ResultFields.programTwoScore: programTwoScore.toJson(),
      ResultFields.programThreeScore: programThreeScore.toJson(),
      ResultFields.programFourScore: programFourScore.toJson(),
      ResultFields.programFiveScore: programFiveScore.toJson(),
    };
  }
}

class ProgramOneScoreDetails {
  String kg;
  String reps;
  String rounds;
  String minutes;
  String seconds;
  String comment;
  String description;

  ProgramOneScoreDetails(
      {this.kg,
      this.reps,
      this.rounds,
      this.description,
      this.comment,
      this.minutes,
      this.seconds});

  ProgramOneScoreDetails.fromJson(Map<String, dynamic> json) {
    kg = json[ProgramScoreDetailsFields.kg];
    reps = json[ProgramScoreDetailsFields.reps];
    rounds = json[ProgramScoreDetailsFields.rounds];
    minutes = json[ProgramScoreDetailsFields.minutes];
    seconds = json[ProgramScoreDetailsFields.seconds];
    comment = json[ProgramScoreDetailsFields.comment];
    description = json[ProgramScoreDetailsFields.description];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[ProgramScoreDetailsFields.kg] = this.kg;
    data[ProgramScoreDetailsFields.reps] = this.reps;
    data[ProgramScoreDetailsFields.rounds] = this.rounds;
    data[ProgramScoreDetailsFields.minutes] = this.minutes;
    data[ProgramScoreDetailsFields.seconds] = this.seconds;
    data[ProgramScoreDetailsFields.comment] = this.comment;
    data[ProgramScoreDetailsFields.description] = this.description;
    return data;
  }
}

class ProgramTwoScoreDetails {
  String kg;
  String reps;
  String rounds;
  String minutes;
  String seconds;
  String comment;
  String description;
  ProgramTwoScoreDetails(
      {this.kg,
      this.reps,
      this.rounds,
      this.minutes,
      this.seconds,
      this.comment,
      this.description});

  ProgramTwoScoreDetails.fromJson(Map<String, dynamic> json) {
    kg = json[ProgramScoreDetailsFields.kg];
    reps = json[ProgramScoreDetailsFields.reps];
    rounds = json[ProgramScoreDetailsFields.rounds];
    minutes = json[ProgramScoreDetailsFields.minutes];
    seconds = json[ProgramScoreDetailsFields.seconds];
    comment = json[ProgramScoreDetailsFields.comment];
    description = json[ProgramScoreDetailsFields.description];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data[ProgramScoreDetailsFields.kg] = this.kg;
    data[ProgramScoreDetailsFields.reps] = this.reps;
    data[ProgramScoreDetailsFields.rounds] = this.rounds;
    data[ProgramScoreDetailsFields.minutes] = this.minutes;
    data[ProgramScoreDetailsFields.seconds] = this.seconds;
    data[ProgramScoreDetailsFields.comment] = this.comment;
    data[ProgramScoreDetailsFields.description] = this.description;
    return data;
  }
}

class ProgramThreeScoreDetails {
  String kg;
  String reps;
  String rounds;
  String minutes;
  String seconds;
  String comment;
  String description;

  ProgramThreeScoreDetails(
      {this.kg,
      this.reps,
      this.rounds,
      this.description,
      this.comment,
      this.minutes,
      this.seconds});

  ProgramThreeScoreDetails.fromJson(Map<String, dynamic> json) {
    kg = json[ProgramScoreDetailsFields.kg];
    reps = json[ProgramScoreDetailsFields.reps];
    rounds = json[ProgramScoreDetailsFields.rounds];
    minutes = json[ProgramScoreDetailsFields.minutes];
    seconds = json[ProgramScoreDetailsFields.seconds];
    comment = json[ProgramScoreDetailsFields.comment];
    description = json[ProgramScoreDetailsFields.description];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[ProgramScoreDetailsFields.kg] = this.kg;
    data[ProgramScoreDetailsFields.reps] = this.reps;
    data[ProgramScoreDetailsFields.rounds] = this.rounds;
    data[ProgramScoreDetailsFields.minutes] = this.minutes;
    data[ProgramScoreDetailsFields.seconds] = this.seconds;
    data[ProgramScoreDetailsFields.comment] = this.comment;
    data[ProgramScoreDetailsFields.description] = this.description;
    return data;
  }
}

class ProgramFourScoreDetails {
  String kg;
  String reps;
  String rounds;
  String minutes;
  String seconds;
  String comment;
  String description;

  ProgramFourScoreDetails(
      {this.kg,
      this.reps,
      this.rounds,
      this.description,
      this.comment,
      this.minutes,
      this.seconds});

  ProgramFourScoreDetails.fromJson(Map<String, dynamic> json) {
    kg = json[ProgramScoreDetailsFields.kg];
    reps = json[ProgramScoreDetailsFields.reps];
    rounds = json[ProgramScoreDetailsFields.rounds];
    minutes = json[ProgramScoreDetailsFields.minutes];
    seconds = json[ProgramScoreDetailsFields.seconds];
    comment = json[ProgramScoreDetailsFields.comment];
    description = json[ProgramScoreDetailsFields.description];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[ProgramScoreDetailsFields.kg] = this.kg;
    data[ProgramScoreDetailsFields.reps] = this.reps;
    data[ProgramScoreDetailsFields.rounds] = this.rounds;
    data[ProgramScoreDetailsFields.minutes] = this.minutes;
    data[ProgramScoreDetailsFields.seconds] = this.seconds;
    data[ProgramScoreDetailsFields.comment] = this.comment;
    data[ProgramScoreDetailsFields.description] = this.description;
    return data;
  }
}

class ProgramFiveScoreDetails {
  String kg;
  String reps;
  String rounds;
  String minutes;
  String seconds;
  String comment;
  String description;

  ProgramFiveScoreDetails(
      {this.kg,
      this.reps,
      this.rounds,
      this.description,
      this.comment,
      this.minutes,
      this.seconds});

  ProgramFiveScoreDetails.fromJson(Map<String, dynamic> json) {
    kg = json[ProgramScoreDetailsFields.kg];
    reps = json[ProgramScoreDetailsFields.reps];
    rounds = json[ProgramScoreDetailsFields.rounds];
    minutes = json[ProgramScoreDetailsFields.minutes];
    seconds = json[ProgramScoreDetailsFields.seconds];
    comment = json[ProgramScoreDetailsFields.comment];
    description = json[ProgramScoreDetailsFields.description];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[ProgramScoreDetailsFields.kg] = this.kg;
    data[ProgramScoreDetailsFields.reps] = this.reps;
    data[ProgramScoreDetailsFields.rounds] = this.rounds;
    data[ProgramScoreDetailsFields.minutes] = this.minutes;
    data[ProgramScoreDetailsFields.seconds] = this.seconds;
    data[ProgramScoreDetailsFields.comment] = this.comment;
    data[ProgramScoreDetailsFields.description] = this.description;
    return data;
  }
}
