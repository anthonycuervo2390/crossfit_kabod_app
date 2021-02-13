// import 'dart:convert';
//
// class AppWod {
//   final String rounds;
//   final String id;
//   final String wodDescription;
//   final DateTime date;
//   final String
//       userId; //TODO: esto es extra para poder mostrar info solo a este usuario
//   final String weightliftingMovement;
//   final String reps;
//   final String weightliftingDescription;
//   final String extrasDescription;
//   final String scoring;
//   AppWod({
//     this.rounds,
//     this.scoring,
//     this.id,
//     this.wodDescription,
//     this.extrasDescription,
//     this.weightliftingDescription,
//     this.reps,
//     this.date,
//     this.userId,
//     this.weightliftingMovement,
//   });
//
//   AppWod copyWith({
//     String rounds,
//     String scoring,
//     String id,
//     String reps,
//     String wodDescription,
//     DateTime date,
//     String userId,
//     String weightliftingMovement,
//     String weightliftingDescription,
//     String extrasDescription,
//   }) {
//     return AppWod(
//       rounds: rounds ?? this.rounds,
//       scoring: scoring ?? this.scoring,
//       id: id ?? this.id,
//       reps: reps ?? this.reps,
//       wodDescription: wodDescription ?? this.wodDescription,
//       date: date ?? this.date,
//       userId: userId ?? this.userId,
//       weightliftingMovement:
//           weightliftingMovement ?? this.weightliftingMovement,
//       weightliftingDescription:
//           weightliftingDescription ?? this.weightliftingDescription,
//       extrasDescription: extrasDescription ?? this.extrasDescription,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'rounds': rounds,
//       'scoring': scoring,
//       'reps': reps,
//       'id': id,
//       'wodDescription': wodDescription,
//       'date': date.millisecondsSinceEpoch,
//       'userId': userId,
//       'weightliftingMovement': weightliftingMovement,
//       'weightliftingDescription': weightliftingDescription,
//       'extrasDescription': extrasDescription,
//     };
//   }
//
// //TODO: ESTO DE ABAJO LO COPIAMOS Y CAMBIAMOS EL FROMMAP POR FROMDS QUE SERAN LOS DOCUMENTOS QUE VENDRAN DE FIRESTORE
//   factory AppWod.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;
//
//     return AppWod(
//       rounds: map['rounds'],
//       scoring: map['scoring'],
//       id: map['id'],
//       reps: map['reps'],
//       wodDescription: map['wodDescription'],
//       date: DateTime.fromMillisecondsSinceEpoch(map['date']),
//       userId: map['userId'],
//       weightliftingDescription: map['weightliftingDescription'],
//       weightliftingMovement: map['weightliftingMovement'],
//       extrasDescription: map['extrasDescription'],
//     );
//   }
//
//   //========DOCS FROM FIRESTORE========// LE AGREGAMOS STRING ID
//   factory AppWod.fromDS(String id, Map<String, dynamic> data) {
//     if (data == null) return null;
//
//     return AppWod(
//       rounds: data['rounds'],
//       scoring: data['scoring'],
//       id: id,
//       reps: data['reps'],
//       wodDescription: data['wodDescription'],
//       date: DateTime.fromMillisecondsSinceEpoch(data['date']),
//       userId: data['user_id'],
//       weightliftingDescription: data['weightliftingDescription'],
//       weightliftingMovement: data['weightliftingMovement'],
//       extrasDescription: data['extrasDescription'],
//     );
//   }
//
//   String toJson() => json.encode(toMap());
//
//   factory AppWod.fromJson(String source) => AppWod.fromMap(json.decode(source));
//
//   @override
//   String toString() {
//     return 'AppEvent(rounds: $rounds, id: $id, wodDescription: $wodDescription, date: $date, scoring: $scoring, userId: $userId, reps: $reps, weightliftingDescription: $weightliftingDescription, weightliftingMovement: $weightliftingMovement, extrasDescription: $extrasDescription)';
//   }
//
//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;
//
//     return o is AppWod &&
//         o.rounds == rounds &&
//         o.scoring == scoring &&
//         o.reps == reps &&
//         o.id == id &&
//         o.wodDescription == wodDescription &&
//         o.date == date &&
//         o.userId == userId &&
//         o.weightliftingDescription == weightliftingDescription &&
//         o.weightliftingMovement == weightliftingMovement &&
//         o.extrasDescription == extrasDescription;
//   }
//
//   @override
//   int get hashCode {
//     return rounds.hashCode ^
//         id.hashCode ^
//         scoring.hashCode ^
//         wodDescription.hashCode ^
//         date.hashCode ^
//         userId.hashCode ^
//         reps.hashCode ^
//         weightliftingDescription.hashCode ^
//         weightliftingMovement.hashCode ^
//         extrasDescription.hashCode;
//   }
// }

import 'package:crossfit_kabod_app/features/wods/data/services/models/wod_field.dart';

class WodApp {
  String id;
  DateTime date;
  String userId;
  ProgramOneDetails programOneDetails;
  ProgramTwoDetails programTwoDetails;
  ProgramThreeDetails programThreeDetails;
  ProgramFourDetails programFourDetails;
  ProgramFiveDetails programFiveDetails;

  WodApp(
      {this.id,
      this.date,
      this.userId,
      this.programOneDetails,
      this.programTwoDetails,
      this.programThreeDetails,
      this.programFourDetails,
      this.programFiveDetails});

  WodApp.fromDS(String id, Map<String, dynamic> data)
      : id = id,
        date = DateTime.fromMillisecondsSinceEpoch(data[WodFields.date]),
        userId = data[WodFields.userId],
        programOneDetails =
            ProgramOneDetails.fromJson(data[WodFields.programOneDetails]),
        programTwoDetails =
            ProgramTwoDetails.fromJson(data[WodFields.programTwoDetails]),
        programThreeDetails =
            ProgramThreeDetails.fromJson(data[WodFields.programThreeDetails]),
        programFourDetails =
            ProgramFourDetails.fromJson(data[WodFields.programFourDetails]),
        programFiveDetails =
            ProgramFiveDetails.fromJson(data[WodFields.programFiveDetails]);

  Map<String, dynamic> toMap() {
    return {
      WodFields.date: date,
      WodFields.userId: userId,
      WodFields.programOneDetails: programOneDetails.toJson(),
      WodFields.programTwoDetails: programTwoDetails.toJson(),
      WodFields.programThreeDetails: programThreeDetails.toJson(),
      WodFields.programFourDetails: programFourDetails.toJson(),
      WodFields.programFiveDetails: programFiveDetails.toJson(),
    };
  }
}

class ProgramOneDetails {
  String name;
  String details;
  String score;

  ProgramOneDetails({this.name, this.details, this.score});

  ProgramOneDetails.fromJson(Map<String, dynamic> json) {
    name = json[ProgramOneDetailsFields.name];
    details = json[ProgramOneDetailsFields.details];
    score = json[ProgramOneDetailsFields.score];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[ProgramOneDetailsFields.name] = this.name;
    data[ProgramOneDetailsFields.details] = this.details;
    data[ProgramOneDetailsFields.score] = this.score;
    return data;
  }
}

class ProgramTwoDetails {
  String name;
  String details;
  String score;

  ProgramTwoDetails({this.name, this.details, this.score});

  ProgramTwoDetails.fromJson(Map<String, dynamic> json) {
    name = json[ProgramTwoDetailsFields.name];
    details = json[ProgramTwoDetailsFields.details];
    score = json[ProgramTwoDetailsFields.score];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[ProgramTwoDetailsFields.name] = this.name;
    data[ProgramTwoDetailsFields.details] = this.details;
    data[ProgramTwoDetailsFields.score] = this.score;
    return data;
  }
}

class ProgramThreeDetails {
  String name;
  String details;
  String score;

  ProgramThreeDetails({this.name, this.details, this.score});

  ProgramThreeDetails.fromJson(Map<String, dynamic> json) {
    name = json[ProgramThreeDetailsFields.name];
    details = json[ProgramThreeDetailsFields.details];
    score = json[ProgramThreeDetailsFields.score];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[ProgramThreeDetailsFields.name] = this.name;
    data[ProgramThreeDetailsFields.details] = this.details;
    data[ProgramThreeDetailsFields.score] = this.score;
    return data;
  }
}

class ProgramFourDetails {
  String name;
  String details;
  String score;

  ProgramFourDetails({this.name, this.details, this.score});

  ProgramFourDetails.fromJson(Map<String, dynamic> json) {
    name = json[ProgramFourDetailsFields.name];
    details = json[ProgramFourDetailsFields.details];
    score = json[ProgramFourDetailsFields.score];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[ProgramFourDetailsFields.name] = this.name;
    data[ProgramFourDetailsFields.details] = this.details;
    data[ProgramFourDetailsFields.score] = this.score;
    return data;
  }
}

class ProgramFiveDetails {
  String name;
  String details;
  String score;

  ProgramFiveDetails({this.name, this.details, this.score});

  ProgramFiveDetails.fromJson(Map<String, dynamic> json) {
    name = json[ProgramFiveDetailsFields.name];
    details = json[ProgramFiveDetailsFields.details];
    score = json[ProgramFiveDetailsFields.score];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[ProgramFiveDetailsFields.name] = this.name;
    data[ProgramFiveDetailsFields.details] = this.details;
    data[ProgramFiveDetailsFields.score] = this.score;
    return data;
  }
}
