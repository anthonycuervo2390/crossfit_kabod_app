import 'package:crossfit_kabod_app/core/presentation/providers/providers.dart';
import 'package:crossfit_kabod_app/core/presentation/res/colors.dart';
import 'package:crossfit_kabod_app/features/wods/data/services/models/app_wod.dart';
import 'package:crossfit_kabod_app/features/wods/data/services/wod_firestore_service.dart';
import 'package:crossfit_kabod_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// class AddWodPage extends StatefulWidget {
//   final DateTime selectedDate;
//   final WodApp wod;
//   AddWodPage({this.selectedDate, this.wod});
//   @override
//   _AddWodPageState createState() => _AddWodPageState();
// }
//
// class _AddWodPageState extends State<AddWodPage> {
//   TextEditingController wodNameController1;
//   TextEditingController wodDetailsController1;
//   TextEditingController wodNameController2;
//   TextEditingController wodDetailsController2;
//   TextEditingController wodNameController3;
//   TextEditingController wodDetailsController3;
//   TextEditingController wodNameController4;
//   TextEditingController wodDetailsController4;
//
//   var formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     wodNameController1 =
//         TextEditingController(text: widget.wod.programOneDetails?.name);
//     wodDetailsController1 =
//         TextEditingController(text: widget.wod.programOneDetails?.details);
//     wodNameController2 =
//         TextEditingController(text: widget.wod.programTwoDetails?.name);
//     wodDetailsController2 =
//         TextEditingController(text: widget.wod.programTwoDetails?.details);
//     wodNameController3 =
//         TextEditingController(text: widget.wod.programThreeDetails?.name);
//     wodDetailsController3 =
//         TextEditingController(text: widget.wod.programThreeDetails?.details);
//     wodNameController4 =
//         TextEditingController(text: widget.wod.programFourDetails?.name);
//     wodDetailsController4 =
//         TextEditingController(text: widget.wod.programFourDetails?.details);
//   }
//
//   var wodNameFocus1 = FocusNode();
//   var wodDetailsFocus1 = FocusNode();
//   var wodNameFocus2 = FocusNode();
//   var wodDetailsFocus2 = FocusNode();
//   var wodNameFocus3 = FocusNode();
//   var wodDetailsFocus3 = FocusNode();
//   var wodNameFocus4 = FocusNode();
//   var wodDetailsFocus4 = FocusNode();
//
//   var score1;
//   var score2;
//   var score3;
//   var score4;
//
//   bool visible1 = false;
//   bool visible2 = false;
//   bool visible3 = false;
//   bool visible4 = false;
//   var currentDate = DateTime.now();
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime picked = await showDatePicker(
//         helpText: 'Select a date',
//         cancelText: 'Go back',
//         confirmText: "Select",
//         errorFormatText: 'Enter valid date',
//         errorInvalidText: 'Enter date in valid range',
//         context: context,
//         initialDate: currentDate,
//         firstDate: DateTime(2015, 8),
//         lastDate: DateTime(2101));
//     if (picked != null && picked != widget.selectedDate)
//       setState(() {
//         print(picked);
//         currentDate = picked;
//       });
//   }
//
//   @override
//   void setState(fn) {
//     if (mounted) super.setState(fn);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer(builder: (context, watch, _) {
//       final user = watch(userRepoProvider).user;
//       return SafeArea(
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text(S.of(context).addNewWODTitleText),
//             leading: IconButton(
//               icon: Icon(Icons.clear),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             actions: [
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     bool validated = formKey.currentState.validate();
//                     if (validated) {
//                       formKey.currentState.save();
//                       ProgramOneDetails programOneDetails = ProgramOneDetails(
//                           name: wodNameController1.text,
//                           details: wodDetailsController1.text,
//                           score: score1);
//                       ProgramTwoDetails programTwoDetails = ProgramTwoDetails(
//                           name: wodNameController2.text,
//                           details: wodDetailsController2.text,
//                           score: score2);
//                       ProgramThreeDetails programThreeDetails =
//                           ProgramThreeDetails(
//                               name: wodNameController3.text,
//                               details: wodDetailsController3.text,
//                               score: score3);
//                       ProgramFourDetails programFourDetails =
//                           ProgramFourDetails(
//                               name: wodNameController4.text,
//                               details: wodDetailsController4.text,
//                               score: score4);
//                       ProgramFiveDetails programFiveDetails =
//                           ProgramFiveDetails(name: '', details: '', score: '');
//
//                       WodApp wod = WodApp(
//                           date: currentDate,
//                           programOneDetails: programOneDetails,
//                           programTwoDetails: programTwoDetails,
//                           programThreeDetails: programThreeDetails,
//                           programFourDetails: programFourDetails,
//                           programFiveDetails: programFiveDetails,
//                           id: user.id,
//                           userId: user.id);
//                       final data = Map<String, dynamic>.from(wod.toMap());
//                       data['date'] = wod.date.millisecondsSinceEpoch;
//                       if (widget.wod == null) {
//                         await wodDBS.create(data);
//                       } else {
//                         await wodDBS.updateData(widget.wod.id, data);
//                       }
//                       Navigator.pop(context);
//                     }
//                   },
//                   child: Text(S.of(context).saveButtonLabel),
//                 ),
//               )
//             ],
//           ),
//           body: Container(
//             padding: EdgeInsets.all(16),
//             child: SingleChildScrollView(
//               child: Form(
//                 key: formKey,
//                 child: Column(
//                   children: [
//                     Card(
//                         elevation: 4,
//                         child: ListTile(
//                           onTap: () {
//                             _selectDate(context);
//                           },
//                           title: Text(
//                             'Select the Workout date',
//                             style: primaryTextStyle(),
//                           ),
//                           subtitle: Text(
//                             "${currentDate.toLocal()}".split(' ')[0],
//                             style: secondaryTextStyle(),
//                           ),
//                           trailing: IconButton(
//                             icon: Icon(
//                               Icons.date_range,
//                               color: AppColors.primaryColor,
//                               size: 35,
//                             ),
//                             onPressed: () {
//                               _selectDate(context);
//                             },
//                           ),
//                         )),
//                     Divider(),
//                     SwitchListTile(
//                       title: const Text(
//                         'Part A:',
//                         style: TextStyle(fontSize: 16, color: Colors.grey),
//                       ),
//                       value: visible1,
//                       onChanged: (bool value) {
//                         setState(() {
//                           visible1 = value;
//                         });
//                       },
//                       secondary: const Icon(
//                         Icons.line_weight,
//                         color: Colors.red,
//                       ),
//                     ),
//                     if (visible1) ...[
//                       TextFormField(
//                         controller: wodNameController1,
//                         focusNode: wodNameFocus1,
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(Icons.short_text),
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(25),
//                               borderSide:
//                                   BorderSide(color: AppColors.primaryColor)),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(25.0),
//                               borderSide: BorderSide(
//                                   width: 1, color: AppColors.primaryColor)),
//                           labelText: 'Title',
//                           labelStyle: primaryTextStyle(),
//                           alignLabelWithHint: true,
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       TextFormField(
//                         controller: wodDetailsController1,
//                         focusNode: wodDetailsFocus1,
//                         style: primaryTextStyle(),
//                         decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(25.0),
//                             borderSide:
//                                 BorderSide(color: AppColors.primaryColor),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(25.0),
//                             borderSide: BorderSide(
//                                 width: 1, color: AppColors.primaryColor),
//                           ),
//                           labelText: 'Details',
//                           labelStyle: primaryTextStyle(),
//                           alignLabelWithHint: true,
//                         ),
//                         maxLines: 8,
//                         keyboardType: TextInputType.multiline,
//                         validator: (s) {
//                           if (s.trim().isEmpty) return 'Details are required';
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 16),
//                       Wrap(
//                         crossAxisAlignment: WrapCrossAlignment.center,
//                         alignment: WrapAlignment.start,
//                         direction: Axis.horizontal,
//                         children: [
//                           Theme(
//                             data: Theme.of(context)
//                                 .copyWith(unselectedWidgetColor: Colors.green),
//                             child: Radio(
//                               value: 'Time',
//                               groupValue: score1,
//                               onChanged: (value) {
//                                 setState(() {
//                                   score1 = value;
//
//                                   toast("Time Selected");
//                                 });
//                               },
//                             ),
//                           ),
//                           Text('Time', style: primaryTextStyle()),
//                           Theme(
//                             data: Theme.of(context).copyWith(
//                               unselectedWidgetColor: Colors.green,
//                             ),
//                             child: Radio(
//                               value: 'amrap',
//                               groupValue: score1,
//                               onChanged: (value) {
//                                 setState(() {
//                                   score1 = value;
//
//                                   toast("$score1 Selected");
//                                 });
//                               },
//                             ),
//                           ),
//                           Text('AMRAP', style: primaryTextStyle()),
//                           Theme(
//                             data: Theme.of(context)
//                                 .copyWith(unselectedWidgetColor: Colors.green),
//                             child: Radio(
//                               value: 'weight',
//                               groupValue: score1,
//                               onChanged: (value) {
//                                 setState(() {
//                                   score1 = value;
//
//                                   toast("$score1 Selected");
//                                 });
//                               },
//                             ),
//                           ),
//                           Text('Kg', style: primaryTextStyle()),
//                           Theme(
//                             data: Theme.of(context)
//                                 .copyWith(unselectedWidgetColor: Colors.green),
//                             child: Radio(
//                               value: 'none',
//                               groupValue: score1,
//                               onChanged: (value) {
//                                 setState(() {
//                                   score1 = value;
//
//                                   toast("$score1 Selected");
//                                 });
//                               },
//                             ),
//                           ),
//                           Text('none', style: primaryTextStyle()),
//                         ],
//                       ),
//                     ],
//                     SwitchListTile(
//                       title: const Text(
//                         'Part B:',
//                         style: TextStyle(fontSize: 16, color: Colors.grey),
//                       ),
//                       value: visible2,
//                       onChanged: (bool value) {
//                         setState(() {
//                           visible2 = value;
//                         });
//                       },
//                       secondary: const Icon(
//                         Icons.line_weight,
//                         color: Colors.red,
//                       ),
//                     ),
//                     if (visible2) ...[
//                       TextFormField(
//                         controller: wodNameController2,
//                         focusNode: wodNameFocus2,
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(Icons.short_text),
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(25),
//                               borderSide:
//                                   BorderSide(color: AppColors.primaryColor)),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(25.0),
//                               borderSide: BorderSide(
//                                   width: 1, color: AppColors.primaryColor)),
//                           labelText: 'Title',
//                           labelStyle: primaryTextStyle(),
//                           alignLabelWithHint: true,
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       TextFormField(
//                         controller: wodDetailsController2,
//                         focusNode: wodDetailsFocus2,
//                         style: primaryTextStyle(),
//                         decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(25.0),
//                             borderSide:
//                                 BorderSide(color: AppColors.primaryColor),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(25.0),
//                             borderSide: BorderSide(
//                                 width: 1, color: AppColors.primaryColor),
//                           ),
//                           labelText: 'Details',
//                           labelStyle: primaryTextStyle(),
//                           alignLabelWithHint: true,
//                         ),
//                         maxLines: 8,
//                         keyboardType: TextInputType.multiline,
//                         validator: (s) {
//                           if (s.trim().isEmpty) return 'Details are required';
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 16),
//                       Wrap(
//                         crossAxisAlignment: WrapCrossAlignment.center,
//                         alignment: WrapAlignment.start,
//                         direction: Axis.horizontal,
//                         children: [
//                           Theme(
//                             data: Theme.of(context)
//                                 .copyWith(unselectedWidgetColor: Colors.green),
//                             child: Radio(
//                               value: 'Time',
//                               groupValue: score2,
//                               onChanged: (value) {
//                                 setState(() {
//                                   score2 = value;
//
//                                   toast("Time Selected");
//                                 });
//                               },
//                             ),
//                           ),
//                           Text('Time', style: primaryTextStyle()),
//                           Theme(
//                             data: Theme.of(context).copyWith(
//                               unselectedWidgetColor: Colors.green,
//                             ),
//                             child: Radio(
//                               value: 'amrap',
//                               groupValue: score2,
//                               onChanged: (value) {
//                                 setState(() {
//                                   score2 = value;
//
//                                   toast("$score2 Selected");
//                                 });
//                               },
//                             ),
//                           ),
//                           Text('AMRAP', style: primaryTextStyle()),
//                           Theme(
//                             data: Theme.of(context)
//                                 .copyWith(unselectedWidgetColor: Colors.green),
//                             child: Radio(
//                               value: 'weight',
//                               groupValue: score2,
//                               onChanged: (value) {
//                                 setState(() {
//                                   score2 = value;
//
//                                   toast("$score2 Selected");
//                                 });
//                               },
//                             ),
//                           ),
//                           Text('Kg', style: primaryTextStyle()),
//                           Theme(
//                             data: Theme.of(context)
//                                 .copyWith(unselectedWidgetColor: Colors.green),
//                             child: Radio(
//                               value: 'none',
//                               groupValue: score2,
//                               onChanged: (value) {
//                                 setState(() {
//                                   score2 = value;
//
//                                   toast("$score2 Selected");
//                                 });
//                               },
//                             ),
//                           ),
//                           Text('none', style: primaryTextStyle()),
//                         ],
//                       ),
//                     ],
//                     SwitchListTile(
//                       title: const Text(
//                         'Part C:',
//                         style: TextStyle(fontSize: 16, color: Colors.grey),
//                       ),
//                       value: visible3,
//                       onChanged: (bool value) {
//                         setState(() {
//                           visible3 = value;
//                         });
//                       },
//                       secondary: const Icon(
//                         Icons.line_weight,
//                         color: Colors.red,
//                       ),
//                     ),
//                     if (visible3) ...[
//                       TextFormField(
//                         controller: wodNameController3,
//                         focusNode: wodNameFocus3,
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(Icons.short_text),
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(25),
//                               borderSide:
//                                   BorderSide(color: AppColors.primaryColor)),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(25.0),
//                               borderSide: BorderSide(
//                                   width: 1, color: AppColors.primaryColor)),
//                           labelText: 'Title',
//                           labelStyle: primaryTextStyle(),
//                           alignLabelWithHint: true,
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       TextFormField(
//                         controller: wodDetailsController3,
//                         focusNode: wodDetailsFocus3,
//                         style: primaryTextStyle(),
//                         decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(25.0),
//                             borderSide:
//                                 BorderSide(color: AppColors.primaryColor),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(25.0),
//                             borderSide: BorderSide(
//                                 width: 1, color: AppColors.primaryColor),
//                           ),
//                           labelText: 'Details',
//                           labelStyle: primaryTextStyle(),
//                           alignLabelWithHint: true,
//                         ),
//                         maxLines: 8,
//                         keyboardType: TextInputType.multiline,
//                         validator: (s) {
//                           if (s.trim().isEmpty) return 'Details are required';
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 16),
//                       Wrap(
//                         crossAxisAlignment: WrapCrossAlignment.center,
//                         alignment: WrapAlignment.start,
//                         direction: Axis.horizontal,
//                         children: [
//                           Theme(
//                             data: Theme.of(context)
//                                 .copyWith(unselectedWidgetColor: Colors.green),
//                             child: Radio(
//                               value: 'Time',
//                               groupValue: score3,
//                               onChanged: (value) {
//                                 setState(() {
//                                   score3 = value;
//
//                                   toast("Time Selected");
//                                 });
//                               },
//                             ),
//                           ),
//                           Text('Time', style: primaryTextStyle()),
//                           Theme(
//                             data: Theme.of(context).copyWith(
//                               unselectedWidgetColor: Colors.green,
//                             ),
//                             child: Radio(
//                               value: 'amrap',
//                               groupValue: score3,
//                               onChanged: (value) {
//                                 setState(() {
//                                   score3 = value;
//
//                                   toast("$score3 Selected");
//                                 });
//                               },
//                             ),
//                           ),
//                           Text('AMRAP', style: primaryTextStyle()),
//                           Theme(
//                             data: Theme.of(context)
//                                 .copyWith(unselectedWidgetColor: Colors.green),
//                             child: Radio(
//                               value: 'weight',
//                               groupValue: score3,
//                               onChanged: (value) {
//                                 setState(() {
//                                   score3 = value;
//
//                                   toast("$score3 Selected");
//                                 });
//                               },
//                             ),
//                           ),
//                           Text('Kg', style: primaryTextStyle()),
//                           Theme(
//                             data: Theme.of(context)
//                                 .copyWith(unselectedWidgetColor: Colors.green),
//                             child: Radio(
//                               value: 'none',
//                               groupValue: score3,
//                               onChanged: (value) {
//                                 setState(() {
//                                   score3 = value;
//
//                                   toast("$score3 Selected");
//                                 });
//                               },
//                             ),
//                           ),
//                           Text('none', style: primaryTextStyle()),
//                         ],
//                       ),
//                     ],
//                     SwitchListTile(
//                       title: const Text(
//                         'Part D:',
//                         style: TextStyle(fontSize: 16, color: Colors.grey),
//                       ),
//                       value: visible4,
//                       onChanged: (bool value) {
//                         setState(() {
//                           visible4 = value;
//                         });
//                       },
//                       secondary: const Icon(
//                         Icons.line_weight,
//                         color: Colors.red,
//                       ),
//                     ),
//                     if (visible4) ...[
//                       TextFormField(
//                         controller: wodNameController4,
//                         focusNode: wodNameFocus4,
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(Icons.short_text),
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(25),
//                               borderSide:
//                                   BorderSide(color: AppColors.primaryColor)),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(25.0),
//                               borderSide: BorderSide(
//                                   width: 1, color: AppColors.primaryColor)),
//                           labelText: 'Title',
//                           labelStyle: primaryTextStyle(),
//                           alignLabelWithHint: true,
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       TextFormField(
//                         controller: wodDetailsController4,
//                         focusNode: wodDetailsFocus4,
//                         style: primaryTextStyle(),
//                         decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(25.0),
//                             borderSide:
//                                 BorderSide(color: AppColors.primaryColor),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(25.0),
//                             borderSide: BorderSide(
//                                 width: 1, color: AppColors.primaryColor),
//                           ),
//                           labelText: 'Details',
//                           labelStyle: primaryTextStyle(),
//                           alignLabelWithHint: true,
//                         ),
//                         maxLines: 8,
//                         keyboardType: TextInputType.multiline,
//                         validator: (s) {
//                           if (s.trim().isEmpty) return 'Details are required';
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 16),
//                       Wrap(
//                         crossAxisAlignment: WrapCrossAlignment.center,
//                         alignment: WrapAlignment.start,
//                         direction: Axis.horizontal,
//                         children: [
//                           Theme(
//                             data: Theme.of(context)
//                                 .copyWith(unselectedWidgetColor: Colors.green),
//                             child: Radio(
//                               value: 'Time',
//                               groupValue: score4,
//                               onChanged: (value) {
//                                 setState(() {
//                                   score4 = value;
//
//                                   toast("Time Selected");
//                                 });
//                               },
//                             ),
//                           ),
//                           Text('Time', style: primaryTextStyle()),
//                           Theme(
//                             data: Theme.of(context).copyWith(
//                               unselectedWidgetColor: Colors.green,
//                             ),
//                             child: Radio(
//                               value: 'amrap',
//                               groupValue: score4,
//                               onChanged: (value) {
//                                 setState(() {
//                                   score4 = value;
//
//                                   toast("$score4 Selected");
//                                 });
//                               },
//                             ),
//                           ),
//                           Text('AMRAP', style: primaryTextStyle()),
//                           Theme(
//                             data: Theme.of(context)
//                                 .copyWith(unselectedWidgetColor: Colors.green),
//                             child: Radio(
//                               value: 'weight',
//                               groupValue: score4,
//                               onChanged: (value) {
//                                 setState(() {
//                                   score4 = value;
//
//                                   toast("$score4 Selected");
//                                 });
//                               },
//                             ),
//                           ),
//                           Text('Kg', style: primaryTextStyle()),
//                           Theme(
//                             data: Theme.of(context)
//                                 .copyWith(unselectedWidgetColor: Colors.green),
//                             child: Radio(
//                               value: 'none',
//                               groupValue: score4,
//                               onChanged: (value) {
//                                 setState(() {
//                                   score4 = value;
//
//                                   toast("$score4 Selected");
//                                 });
//                               },
//                             ),
//                           ),
//                           Text('none', style: primaryTextStyle()),
//                         ],
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
