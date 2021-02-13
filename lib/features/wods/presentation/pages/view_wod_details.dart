import 'package:crossfit_kabod_app/core/presentation/res/colors.dart';
import 'package:crossfit_kabod_app/core/presentation/res/routes.dart';
import 'package:crossfit_kabod_app/features/wods/data/services/models/app_wod.dart';
import 'package:crossfit_kabod_app/features/wods/data/services/wod_firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WodDetails extends StatelessWidget {
  final WodApp wod;

  const WodDetails({Key key, this.wod}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => Navigator.pushReplacementNamed(
                  context, AppRoutes.editWod,
                  arguments: wod)),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                //TODO: puedo usar esta logica para mostrar una alerta cuando quieran cancelar o reservar una clase
                final confirm = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Warning!'),
                        content: Text('Are you sure you want to delete?'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: Text('Delete')),
                          TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: Colors.grey.shade700),
                              ))
                        ],
                      ),
                    ) ??
                    false;
                if (confirm) {
                  //delete and pop
                  wodDBS.removeItem(wod.id);
                  Navigator.pop(context);
                }
              }),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Text(
            DateFormat('EEEE, d MMM yyyy').format(wod.date),
            style: TextStyle(fontSize: 24, color: AppColors.labelColor),
          ),
          Column(
            children: [
              if (wod.programOneDetails.name != null &&
                  wod.programOneDetails.details != null &&
                  wod.programOneDetails.score != null) ...[
                Padding(
                  padding: EdgeInsets.only(top: 18.0),
                  child: Text(
                    wod.programOneDetails.name,
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    wod.programOneDetails.details,
                    style: TextStyle(color: AppColors.labelColor, fontSize: 16),
                  ),
                ),
              ],
              if (wod.programTwoDetails.name != null &&
                  wod.programTwoDetails.details != null &&
                  wod.programTwoDetails.score != null) ...[
                Padding(
                  padding: EdgeInsets.only(top: 18.0),
                  child: Text(
                    wod.programTwoDetails.name,
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    wod.programTwoDetails.details,
                    style: TextStyle(color: AppColors.labelColor, fontSize: 16),
                  ),
                ),
              ],
              if (wod.programThreeDetails.name != null &&
                  wod.programThreeDetails.details != null &&
                  wod.programThreeDetails.score != null) ...[
                Padding(
                  padding: EdgeInsets.only(top: 18.0),
                  child: Text(
                    wod.programThreeDetails.name,
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    wod.programThreeDetails.details,
                    style: TextStyle(color: AppColors.labelColor, fontSize: 16),
                  ),
                ),
              ],
              if (wod.programFourDetails != null &&
                  wod.programFourDetails.details != null &&
                  wod.programFourDetails.score != null) ...[
                Padding(
                  padding: EdgeInsets.only(top: 18.0),
                  child: Text(
                    wod.programFourDetails.name,
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    wod.programFourDetails.details,
                    style: TextStyle(color: AppColors.labelColor, fontSize: 16),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
