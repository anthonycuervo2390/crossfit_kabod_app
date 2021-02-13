import 'package:crossfit_kabod_app/core/data/res/data_constants.dart';
import 'package:crossfit_kabod_app/core/presentation/providers/providers.dart';
import 'package:crossfit_kabod_app/core/presentation/res/colors.dart';
import 'package:crossfit_kabod_app/features/results/data/model/result.dart';
import 'package:crossfit_kabod_app/features/results/data/services/user_results_db_service.dart';
import 'package:crossfit_kabod_app/features/wods/data/services/models/app_wod.dart';
import 'package:crossfit_kabod_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AddResultPage extends StatefulWidget {
  final Result result;
  final DateTime selectedDate;
  final WodApp wod;

  const AddResultPage({Key key, this.result, this.selectedDate, this.wod})
      : super(key: key);
  @override
  _AddResultPageState createState() => _AddResultPageState();
}

class _AddResultPageState extends State<AddResultPage> {
  TextEditingController _testController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final user = watch(userRepoProvider).user;
      return Scaffold(
        appBar: AppBar(
          title: Text('Add your Score'),
        ),
        body: ListView(
          children: [
            Center(
              child: Text(
                  DateFormat('EEEE, d MMM yyyy').format(widget.selectedDate)),
            ),
            TextField(
              controller: _testController,
              style: TextStyle(color: AppColors.textColor, fontSize: 18),
              decoration: InputDecoration(
                  labelText: S.of(context).phoneFieldLabel,
                  labelStyle: TextStyle(color: AppColors.primaryColor)),
            ),
            FlatButton(
                onPressed: () async {
                  await _saveResults(user.id);
                },
                child: Icon(Icons.ac_unit))
          ],
        ),
      );
    });
  }

  _saveResults(currentUser) async {
    WodScoreDetails wodScoreDetails = WodScoreDetails(
        reps: '1',
        rounds: '2',
        minutes: '123',
        description: 'wod',
        comment: ' wocmendt',
        seconds: '10');
    WeightliftingScoreDetails weightliftingScoreDetails =
        WeightliftingScoreDetails(
            reps: _testController.text,
            kg: '20',
            rounds: '5',
            description: 'testest',
            comment: ' comment');
    resultDBS.collection =
        "${AppDBConstants.usersCollection}/$currentUser/results";
    Result result = Result(
      date: widget.selectedDate,
      wodScore: wodScoreDetails,
      weightliftingScore: weightliftingScoreDetails,
      id: currentUser,
    );
    await resultDBS.createItem(result);
    print(currentUser);
  }
}
