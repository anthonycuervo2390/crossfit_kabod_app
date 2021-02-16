import 'package:crossfit_kabod_app/core/data/res/data_constants.dart';
import 'package:crossfit_kabod_app/core/presentation/providers/providers.dart';
import 'package:crossfit_kabod_app/core/presentation/res/colors.dart';
import 'package:crossfit_kabod_app/features/results/data/model/result.dart';
import 'package:crossfit_kabod_app/features/results/data/services/user_results_db_service.dart';
import 'package:crossfit_kabod_app/features/wods/data/services/models/app_wod.dart';
import 'package:crossfit_kabod_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

enum WodDescriptionMarker { wod1, wod2, wod3, wod4 }

class AddResultPage extends StatefulWidget {
  final Result result;
  final DateTime selectedDate;
  final WodApp wod;

  AddResultPage({this.result, this.selectedDate, this.wod});

  @override
  _AddResultPageState createState() => _AddResultPageState();
}

class _AddResultPageState extends State<AddResultPage> {
  WodDescriptionMarker selectedWodDescriptionMarker = WodDescriptionMarker.wod1;
  var _formKey = GlobalKey<FormBuilderState>();
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
                DateFormat('EEEE, d MMM yyyy').format(widget.selectedDate),
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor),
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                FlatButton(
                  minWidth: double.infinity,
                  color: AppColors.buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedWodDescriptionMarker = WodDescriptionMarker.wod1;
                    });
                  },
                  child: Text(
                    widget.wod.programOneDetails.name,
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                FlatButton(
                  minWidth: double.infinity,
                  color: AppColors.buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedWodDescriptionMarker = WodDescriptionMarker.wod2;
                    });
                  },
                  child: Text(
                    widget.wod.programTwoDetails.name,
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                FlatButton(
                  minWidth: double.infinity,
                  color: AppColors.buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedWodDescriptionMarker = WodDescriptionMarker.wod3;
                    });
                  },
                  child: Text(
                    widget.wod.programThreeDetails.name,
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                FlatButton(
                  minWidth: double.infinity,
                  color: AppColors.buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedWodDescriptionMarker = WodDescriptionMarker.wod4;
                    });
                  },
                  child: Text(
                    widget.wod.programFourDetails.name,
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                SizedBox(height: 20),
                FormBuilder(
                  key: _formKey,
                  child: getSelectedWodCard(),
                ),
                SizedBox(height: 20),
                FlatButton(
                  height: 60,
                  minWidth: double.infinity,
                  color: AppColors.buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  onPressed: () {
                    _saveResults(user.id);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Add Result',
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget getSelectedWodCard() {
    switch (selectedWodDescriptionMarker) {
      case WodDescriptionMarker.wod1:
        return wodCard1();
      case WodDescriptionMarker.wod2:
        return wodCard2();
      case WodDescriptionMarker.wod3:
        return wodCard3();
      case WodDescriptionMarker.wod4:
        return wodCard4();
    }
    return wodCard1();
  }

  Widget wodCard1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Wod Description:',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor),
        ),
        Container(
          color: AppColors.accentColorLight,
          height: 8,
        ),
        ListTile(
          title: Text(
            widget.wod.programOneDetails.name,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.labelColor.shade700),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            widget.wod.programOneDetails.details,
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 18, color: AppColors.labelColor.shade700),
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Container(
              width: 80,
              child: FormBuilderTextField(
                validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required(context)]),
                name: 'kg',
                style: TextStyle(color: AppColors.textColor, fontSize: 18),
                decoration: InputDecoration(
                  hintText: 'Kg',
                  hintStyle: TextStyle(color: AppColors.labelColor.shade700),
                  filled: true,
                  fillColor: Color(0xff161d27).withOpacity(0.9),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        FormBuilderTextField(
          validator: FormBuilderValidators.compose(
              [FormBuilderValidators.required(context)]),
          name: 'comment',
          style: TextStyle(color: AppColors.textColor, fontSize: 18),
          maxLines: 3,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xff161d27).withOpacity(0.9),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.red),
            ),
            hintText: 'Add Comment',
            hintStyle: TextStyle(color: AppColors.labelColor.shade700),
          ),
        ),
      ],
    );
  }

  Widget wodCard2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Wod Description:',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor),
        ),
        Container(
          color: AppColors.accentColorLight,
          height: 8,
        ),
        ListTile(
          title: Text(
            widget.wod.programTwoDetails.name,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.labelColor.shade700),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            widget.wod.programTwoDetails.details,
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 18, color: AppColors.labelColor.shade700),
          ),
        ),
      ],
    );
  }

  Widget wodCard3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Wod Description:',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor),
        ),
        Container(
          color: AppColors.accentColorLight,
          height: 8,
        ),
        ListTile(
          title: Text(
            widget.wod.programThreeDetails.name,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.labelColor.shade700),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            widget.wod.programThreeDetails.details,
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 18, color: AppColors.labelColor.shade700),
          ),
        ),
      ],
    );
  }

  Widget wodCard4() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Wod Description:',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor),
        ),
        Container(
          color: AppColors.accentColorLight,
          height: 8,
        ),
        ListTile(
          title: Text(
            widget.wod.programFourDetails.name,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.labelColor.shade700),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            widget.wod.programFourDetails.details,
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 18, color: AppColors.labelColor.shade700),
          ),
        ),
      ],
    );
  }

  _saveResults(currentUser) async {
    bool validated = _formKey.currentState.validate();
    if (validated) {
      _formKey.currentState.save();
      final data = Map<String, dynamic>.from(_formKey.currentState.value);
      ProgramOneScoreDetails programOneScoreDetails = ProgramOneScoreDetails(
          kg: data['kg'],
          reps: null,
          rounds: null,
          minutes: null,
          description: null,
          comment: data['comment'],
          seconds: null);
      ProgramTwoScoreDetails programTwoScoreDetails = ProgramTwoScoreDetails(
          reps: null,
          kg: null,
          rounds: null,
          seconds: null,
          minutes: null,
          description: null,
          comment: null);
      ProgramThreeScoreDetails programThreeScoreDetails =
          ProgramThreeScoreDetails(
              reps: null,
              kg: null,
              rounds: null,
              seconds: null,
              minutes: null,
              description: null,
              comment: null);
      ProgramFourScoreDetails programFourScoreDetails = ProgramFourScoreDetails(
          reps: null,
          kg: null,
          rounds: null,
          seconds: null,
          minutes: null,
          description: null,
          comment: null);
      ProgramFiveScoreDetails programFiveScoreDetails = ProgramFiveScoreDetails(
          reps: null,
          kg: null,
          rounds: null,
          seconds: null,
          minutes: null,
          description: null,
          comment: null);

      resultDBS.collection =
          "${AppDBConstants.usersCollection}/$currentUser/${AppDBConstants.resultsSubCollection}";
      Result result = Result(
        date: widget.selectedDate,
        programOneScore: programOneScoreDetails,
        programTwoScore: programTwoScoreDetails,
        programThreeScore: programThreeScoreDetails,
        programFourScore: programFourScoreDetails,
        programFiveScore: programFiveScoreDetails,
        id: currentUser,
      );
      await resultDBS.createItem(result);
      print(currentUser);
    } else
      print('error');
  }
}
