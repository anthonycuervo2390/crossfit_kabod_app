import 'package:crossfit_kabod_app/core/data/res/data_constants.dart';
import 'package:crossfit_kabod_app/features/wods/data/services/models/app_wod.dart';
import 'package:flutter/material.dart';
import 'package:firebase_helpers/firebase_helpers.dart';

// final wodDBS = DatabaseService<AppWod>(AppDBConstants.wodsCollection,
//     fromDS: (id, data) => AppWod.fromDS(id, data), toMap: (wod) => wod.toMap());

final wodDBS = DatabaseService<WodApp>(AppDBConstants.wodsCollection,
    fromDS: (id, data) => WodApp.fromDS(id, data), toMap: (wod) => wod.toMap());
