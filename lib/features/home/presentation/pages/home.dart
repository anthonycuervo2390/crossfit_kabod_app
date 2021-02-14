import 'package:crossfit_kabod_app/core/presentation/providers/providers.dart';
import 'package:crossfit_kabod_app/core/presentation/res/colors.dart';
import 'package:crossfit_kabod_app/features/drawer/drawer.dart';
import 'package:crossfit_kabod_app/features/results/screens/add_results.dart';
import 'package:crossfit_kabod_app/features/wods/data/services/models/app_wod.dart';
import 'package:crossfit_kabod_app/features/wods/data/services/wod_firestore_service.dart';
import 'package:crossfit_kabod_app/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crossfit_kabod_app/core/presentation/res/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarController _calendarController = CalendarController();
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    context.read(pnProvider).init();
    super.didChangeDependencies();
  }

// create a Map with the dates and wods to display in the calendar
  Map<DateTime, List<WodApp>> _groupedWods;

  _groupWods(List<WodApp> wods) {
    _groupedWods = {};
    wods.forEach((wod) {
      DateTime date =
          DateTime.utc(wod.date.year, wod.date.month, wod.date.day, 12);
      if (_groupedWods[date] == null) _groupedWods[date] = [];
      _groupedWods[date].add(wod);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final user = watch(userRepoProvider).user;
      return Scaffold(
        key: _key,
        appBar: AppBar(
          title: Text(S.of(context).appName),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _key.currentState.openDrawer();
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () => Navigator.pushNamed(context, AppRoutes.profile),
            )
          ],
        ),
        drawer: BuildDrawer(),
        body: SingleChildScrollView(
          child: StreamBuilder(
            //========SI QUISIERAMOS QUE EL USUARIO VEA SOLO EL EVENTO QUE EL CREO Y QUE NADIE MAS LO VEA======//
            //stream: wodDBS.streamQueryList( args:[
            // QueryArgsV2('user_id', isEqualTo: context.read(userRepoProvider).user.id),
            // ],
            //),
            stream: wodDBS.streamList(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                final wods = snapshot.data;
                _groupWods(wods);
                //show the wod of the selected day and if there is no wod, show an empty array
                DateTime selectedDate = _calendarController.selectedDay;
                final _selectedWods = _groupedWods[selectedDate] ?? [];
                return Column(
                  children: [
                    Card(
                      color: AppColors.scaffoldBackgroundColor,
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.all(8.0),
                      child: TableCalendar(
                        events: _groupedWods,
                        onDaySelected: (date, wods, holidays) {
                          setState(() {});
                        },
                        initialCalendarFormat: CalendarFormat.week,
                        calendarController: _calendarController,
                        locale: Localizations.localeOf(context).languageCode,
                        headerStyle: HeaderStyle(
                          centerHeaderTitle: true,
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.6),
                          ),
                          headerMargin: EdgeInsets.only(bottom: 8.0),
                          titleTextStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                          formatButtonVisible: false,
                          leftChevronIcon:
                              Icon(Icons.chevron_left, color: Colors.white),
                          rightChevronIcon:
                              Icon(Icons.chevron_right, color: Colors.white),
                        ),
                        calendarStyle: CalendarStyle(
                          eventDayStyle: TextStyle(color: AppColors.labelColor),
                          todayColor: Colors.grey,
                          markersColor: Colors.blue,
                          selectedColor: AppColors.primaryColor,
                          weekdayStyle:
                              TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _selectedWods.length,
                      itemBuilder: (BuildContext context, int index) {
                        WodApp wod = _selectedWods[index];
                        return Column(
                          children: [
                            FlatButton(
                              color: AppColors.buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddResultPage(
                                      selectedDate:
                                          _calendarController.selectedDay,
                                      wod: wod,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.description_outlined),
                                  Text(
                                    'Add Results',
                                    style: TextStyle(
                                        color: AppColors.textColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              DateFormat('EEEE, d MMM yyyy').format(wod.date),
                              style: TextStyle(
                                  fontSize: 24, color: AppColors.labelColor),
                            ),
                            if (wod.programOneDetails != null) ...[
                              Card(
                                color: Colors.grey,
                                clipBehavior: Clip.antiAlias,
                                child: Column(
                                  children: [
                                    if (wod.programOneDetails.details != null &&
                                        wod.programOneDetails.name != null &&
                                        wod.programOneDetails.score !=
                                            null) ...[
                                      ListTile(
                                        title: Text(
                                          wod.programOneDetails.name,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        trailing: user.admin == false
                                            ? null
                                            : IconButton(
                                                icon: Icon(Icons.edit),
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    AppRoutes.viewWod,
                                                    arguments: wod,
                                                  );
                                                },
                                              ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Text(
                                          wod.programOneDetails.details,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ],
                                    if (wod.programTwoDetails.name != null &&
                                        wod.programTwoDetails.details != null &&
                                        wod.programTwoDetails.score !=
                                            null) ...[
                                      ListTile(
                                        title: Text(
                                          wod.programTwoDetails.name,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Text(
                                          wod.programTwoDetails.details,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ],
                                    if (wod.programThreeDetails.name != null &&
                                        wod.programThreeDetails.details !=
                                            null &&
                                        wod.programThreeDetails.score !=
                                            null) ...[
                                      ListTile(
                                        title: Text(
                                          wod.programThreeDetails.name,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Text(
                                          wod.programThreeDetails.details,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ],
                                    if (wod.programFourDetails.name != null &&
                                        wod.programFourDetails.details !=
                                            null &&
                                        wod.programFourDetails.score !=
                                            null) ...[
                                      ListTile(
                                        title: Text(
                                          wod.programFourDetails.name,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Text(
                                          wod.programFourDetails.details,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ],
                        );
                      },
                    ),
                  ],
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
        floatingActionButton: user.admin == false
            ? Container()
            : FloatingActionButton(
                backgroundColor: AppColors.buttonColor,
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.addWod,
                      arguments: _calendarController.selectedDay);
                },
              ),
      );
    });
  }
}
