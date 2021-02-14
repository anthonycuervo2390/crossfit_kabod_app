import 'package:crossfit_kabod_app/features/profile/data/model/user.dart';
import 'package:crossfit_kabod_app/features/results/data/model/result.dart';
import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:crossfit_kabod_app/core/data/res/data_constants.dart';

UserModel user = UserModel();

final resultDBS = DatabaseService<Result>(
    "${AppDBConstants.usersCollection}/${user.id}/${AppDBConstants.resultsSubCollection}",
    fromDS: (id, data) => Result.fromDS(id, data),
    toMap: (wod) => wod.toMap());
