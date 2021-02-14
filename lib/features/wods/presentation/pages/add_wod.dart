import 'package:crossfit_kabod_app/core/presentation/providers/providers.dart';
import 'package:crossfit_kabod_app/core/presentation/res/colors.dart';
import 'package:crossfit_kabod_app/features/wods/data/services/models/app_wod.dart';
import 'package:crossfit_kabod_app/features/wods/data/services/wod_firestore_service.dart';
import 'package:crossfit_kabod_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AddWodPage extends StatefulWidget {
  final DateTime selectedDate;
  final WodApp wod;
  AddWodPage({this.selectedDate, this.wod});
  @override
  _AddWodPageState createState() => _AddWodPageState();
}

class _AddWodPageState extends State<AddWodPage> {
  var _formKey = GlobalKey<FormBuilderState>();

  var wodNameFocus1 = FocusNode();
  var wodDetailsFocus1 = FocusNode();
  var wodNameFocus2 = FocusNode();
  var wodDetailsFocus2 = FocusNode();
  var wodNameFocus3 = FocusNode();
  var wodDetailsFocus3 = FocusNode();
  var wodNameFocus4 = FocusNode();
  var wodDetailsFocus4 = FocusNode();

  var score1;
  var score2;
  var score3;
  var score4;

  bool visible1 = false;
  bool visible2 = false;
  bool visible3 = false;
  bool visible4 = false;

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final user = watch(userRepoProvider).user;
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).addNewWODTitleText),
            leading: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    bool validated = _formKey.currentState.validate();
                    if (validated) {
                      _formKey.currentState.save();
                      final data = Map<String, dynamic>.from(
                          _formKey.currentState.value);
                      ProgramOneDetails programOneDetails = ProgramOneDetails(
                          name: data['name_1'],
                          details: data['details_1'],
                          score: data['score_1']);
                      ProgramTwoDetails programTwoDetails = ProgramTwoDetails(
                          name: data['name_2'],
                          details: data['details_2'],
                          score: data['score_2']);
                      ProgramThreeDetails programThreeDetails =
                          ProgramThreeDetails(
                              name: data['name_3'],
                              details: data['details_3'],
                              score: data['score_3']);
                      ProgramFourDetails programFourDetails =
                          ProgramFourDetails(
                              name: data['name_4'],
                              details: data['details_4'],
                              score: data['score_4']);
                      ProgramFiveDetails programFiveDetails =
                          ProgramFiveDetails(name: '', details: '', score: '');

                      WodApp wod = WodApp(
                          date: data['date'],
                          programOneDetails: programOneDetails,
                          programTwoDetails: programTwoDetails,
                          programThreeDetails: programThreeDetails,
                          programFourDetails: programFourDetails,
                          programFiveDetails: programFiveDetails,
                          id: user.id,
                          userId: user.id);
                      final dataNew = Map<String, dynamic>.from(wod.toMap());
                      dataNew['date'] = wod.date.millisecondsSinceEpoch;
                      if (widget.wod == null) {
                        await wodDBS.create(dataNew);
                      } else {
                        await wodDBS.updateData(widget.wod.id, dataNew);
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Text(S.of(context).saveButtonLabel),
                ),
              )
            ],
          ),
          body: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    FormBuilderDateTimePicker(
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required(context)]),
                      name: 'date',
                      initialValue: widget.wod != null
                          ? widget.wod.date
                          : widget.selectedDate ?? DateTime.now(),
                      fieldHintText: S.of(context).dateHintLabel,
                      inputType: InputType.date,
                      resetIcon: Icon(
                        Icons.close,
                        color: AppColors.labelColor,
                      ),
                      style:
                          TextStyle(color: AppColors.textColor, fontSize: 16),
                      format: DateFormat('EEEE, dd MMMM, yyyy'),
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
                        // border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    SwitchListTile(
                      title: const Text(
                        'Part A:',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      value: visible1,
                      onChanged: (bool value) {
                        setState(() {
                          visible1 = value;
                        });
                      },
                      secondary: const Icon(
                        Icons.line_weight,
                        color: Colors.red,
                      ),
                    ),
                    if (visible1) ...[
                      FormBuilderTextField(
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required(context)]),
                        name: 'name_1',
                        initialValue: widget.wod == null
                            ? ''
                            : widget.wod.programOneDetails?.name,
                        style:
                            TextStyle(color: AppColors.textColor, fontSize: 18),
                        decoration: InputDecoration(
                          hintText: S.of(context).titleHintLabel,
                          hintStyle:
                              TextStyle(color: AppColors.labelColor.shade700),
                          contentPadding: EdgeInsets.only(left: 48.0),
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
                      SizedBox(height: 16),
                      FormBuilderTextField(
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required(context)]),
                        name: 'details_1',
                        style:
                            TextStyle(color: AppColors.textColor, fontSize: 18),
                        maxLines: 6,
                        keyboardType: TextInputType.multiline,
                        initialValue: widget.wod == null
                            ? ''
                            : widget.wod.programOneDetails?.details,
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
                          hintText: S.of(context).detailsHintLabel,
                          hintStyle:
                              TextStyle(color: AppColors.labelColor.shade700),
                          // prefixIcon: Icon(
                          //   Icons.short_text,
                          //   color: AppColors.primaryColor,
                          // ),
                        ),
                      ),
                      SizedBox(height: 16),
                      FormBuilderChoiceChip(
                          validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required(context)]),
                          alignment: WrapAlignment.spaceEvenly,
                          name: 'score_1',
                          initialValue: widget.wod == null
                              ? ''
                              : widget.wod.programOneDetails?.score,
                          decoration: InputDecoration(
                              labelText: 'type of score?',
                              labelStyle:
                                  TextStyle(color: Colors.grey, fontSize: 18)),
                          options: [
                            FormBuilderFieldOption(value: 'AMRAP'),
                            FormBuilderFieldOption(value: 'Time'),
                            FormBuilderFieldOption(value: 'Weight'),
                            FormBuilderFieldOption(value: 'None')
                          ]),
                      SizedBox(height: 50),
                    ],
                    SwitchListTile(
                      title: const Text(
                        'Part B:',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      value: visible2,
                      onChanged: (bool value) {
                        setState(() {
                          visible2 = value;
                        });
                      },
                      secondary: const Icon(
                        Icons.line_weight,
                        color: Colors.red,
                      ),
                    ),
                    if (visible2) ...[
                      FormBuilderTextField(
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required(context)]),
                        name: 'name_2',
                        initialValue: widget.wod == null
                            ? ''
                            : widget.wod.programTwoDetails?.name,
                        style:
                            TextStyle(color: AppColors.textColor, fontSize: 18),
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
                          hintText: S.of(context).titleHintLabel,
                          hintStyle:
                              TextStyle(color: AppColors.labelColor.shade700),
                          contentPadding: EdgeInsets.only(left: 48.0),
                        ),
                      ),
                      SizedBox(height: 16),
                      FormBuilderTextField(
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required(context)]),
                        name: 'details_2',
                        initialValue: widget.wod == null
                            ? ''
                            : widget.wod.programTwoDetails?.details,
                        style:
                            TextStyle(color: AppColors.textColor, fontSize: 18),
                        maxLines: 6,
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
                          hintText: S.of(context).detailsHintLabel,
                          hintStyle: TextStyle(color: AppColors.labelColor),
                        ),
                      ),
                      SizedBox(height: 16),
                      FormBuilderChoiceChip(
                          validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required(context)]),
                          alignment: WrapAlignment.spaceEvenly,
                          name: 'score_2',
                          initialValue: widget.wod == null
                              ? ''
                              : widget.wod.programTwoDetails?.score,
                          decoration: InputDecoration(
                              labelText: 'type of score?',
                              labelStyle:
                                  TextStyle(color: Colors.grey, fontSize: 18)),
                          options: [
                            FormBuilderFieldOption(value: 'AMRAP'),
                            FormBuilderFieldOption(value: 'Time'),
                            FormBuilderFieldOption(value: 'Weight'),
                            FormBuilderFieldOption(value: 'None')
                          ]),
                      SizedBox(height: 50),
                    ],
                    SwitchListTile(
                      title: const Text(
                        'Part C:',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      value: visible3,
                      onChanged: (bool value) {
                        setState(() {
                          visible3 = value;
                        });
                      },
                      secondary: const Icon(
                        Icons.line_weight,
                        color: Colors.red,
                      ),
                    ),
                    if (visible3) ...[
                      FormBuilderTextField(
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required(context)]),
                        name: 'name_3',
                        initialValue: widget.wod == null
                            ? ''
                            : widget.wod.programThreeDetails?.name,
                        style:
                            TextStyle(color: AppColors.textColor, fontSize: 18),
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
                          hintText: S.of(context).titleHintLabel,
                          hintStyle:
                              TextStyle(color: AppColors.labelColor.shade700),
                          contentPadding: EdgeInsets.only(left: 48.0),
                        ),
                      ),
                      SizedBox(height: 16),
                      FormBuilderTextField(
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required(context)]),
                        name: 'details_3',
                        initialValue: widget.wod == null
                            ? ''
                            : widget.wod.programThreeDetails?.details,
                        style:
                            TextStyle(color: AppColors.textColor, fontSize: 18),
                        maxLines: 6,
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
                          hintText: S.of(context).detailsHintLabel,
                          hintStyle:
                              TextStyle(color: AppColors.labelColor.shade700),
                        ),
                      ),
                      SizedBox(height: 16),
                      FormBuilderChoiceChip(
                          validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required(context)]),
                          alignment: WrapAlignment.spaceEvenly,
                          name: 'score_3',
                          initialValue: widget.wod == null
                              ? ''
                              : widget.wod.programThreeDetails?.score,
                          decoration: InputDecoration(
                              labelText: 'type of score?',
                              labelStyle:
                                  TextStyle(color: Colors.grey, fontSize: 18)),
                          options: [
                            FormBuilderFieldOption(value: 'AMRAP'),
                            FormBuilderFieldOption(value: 'Time'),
                            FormBuilderFieldOption(value: 'Weight'),
                            FormBuilderFieldOption(value: 'None')
                          ]),
                      SizedBox(height: 50),
                    ],
                    SwitchListTile(
                      title: const Text(
                        'Part D:',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      value: visible4,
                      onChanged: (bool value) {
                        setState(() {
                          visible4 = value;
                        });
                      },
                      secondary: const Icon(
                        Icons.line_weight,
                        color: Colors.red,
                      ),
                    ),
                    if (visible4) ...[
                      FormBuilderTextField(
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required(context)]),
                        name: 'name_4',
                        initialValue: widget.wod == null
                            ? ''
                            : widget.wod.programFourDetails?.name,
                        style:
                            TextStyle(color: AppColors.textColor, fontSize: 18),
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
                          hintText: S.of(context).titleHintLabel,
                          hintStyle:
                              TextStyle(color: AppColors.labelColor.shade700),
                          contentPadding: EdgeInsets.only(left: 48.0),
                        ),
                      ),
                      SizedBox(height: 16),
                      FormBuilderTextField(
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required(context)]),
                        name: 'details_4',
                        initialValue: widget.wod == null
                            ? ''
                            : widget.wod.programFourDetails?.details,
                        style:
                            TextStyle(color: AppColors.textColor, fontSize: 18),
                        maxLines: 6,
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
                          hintText: S.of(context).detailsHintLabel,
                          hintStyle:
                              TextStyle(color: AppColors.labelColor.shade700),
                        ),
                      ),
                      SizedBox(height: 16),
                      FormBuilderChoiceChip(
                          validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required(context)]),
                          alignment: WrapAlignment.spaceEvenly,
                          name: 'score_4',
                          initialValue: widget.wod == null
                              ? ''
                              : widget.wod.programFourDetails?.score,
                          decoration: InputDecoration(
                              labelText: 'type of score?',
                              labelStyle: TextStyle(
                                  color: AppColors.labelColor, fontSize: 18)),
                          options: [
                            FormBuilderFieldOption(value: 'AMRAP'),
                            FormBuilderFieldOption(value: 'Time'),
                            FormBuilderFieldOption(value: 'Weight'),
                            FormBuilderFieldOption(value: 'None')
                          ]),
                      SizedBox(height: 50),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
