import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';

import 'ColorScheme.dart';
import 'Data.dart';
import 'FinalizeOrder.dart';

class MainPage extends StatefulWidget {
  static String id = '/MainPage';
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  CalendarController _calendarController;
  var data = InputData();

  String extra1 = '';
  String extra2 = '';
  String extra3 = '';
  String type1 = '';
  String type2 = '';

  void initState() {
    // TODO: implement initState
    super.initState();
    _calendarController = CalendarController();
  }

  void dispose() {
    // TODO: implement dispose
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purple,
      appBar: AppBar(
        title: Text(
          "Your Plan",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Selected Cleaning",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            type1 = type1 == 'initial' ? '' : 'initial';
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.43,
                              decoration: BoxDecoration(
                                color: Color(0xffdfdeff),
                                image: DecorationImage(
                                  image: AssetImage('asset/image/img1.png'),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Initial Cleaning\n70-100 rub/m^2",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffededed),
                              ),
                              child: (type1 == "initial")
                                  ? Icon(
                                      Icons.check_circle,
                                      color: pink,
                                      size: 30,
                                    )
                                  : Container(),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            type2 = type2 == "upkeep" ? '' : 'upkeep';
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.43,
                              decoration: BoxDecoration(
                                color: Color(0xffdfdeff),
                                image: DecorationImage(
                                  image: AssetImage('asset/image/img2.png'),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Upkeep Cleaning\n140-200 rub/m^2",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffededed),
                              ),
                              child: (type2 == "upkeep")
                                  ? Icon(
                                      Icons.check_circle,
                                      color: pink,
                                      size: 30,
                                    )
                                  : Container(),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Selected Date",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TableCalendar(
                    onDaySelected: (time, List, _) {
                      data.date = time.day;
                      data.month = time.month;
                      data.year = time.year;
                    },
                    calendarController: _calendarController,
                    initialCalendarFormat: CalendarFormat.week,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    formatAnimation: FormatAnimation.slide,
                    headerStyle: HeaderStyle(
                      centerHeaderTitle: true,
                      formatButtonVisible: false,
                      titleTextStyle:
                          TextStyle(color: Color(0xff5c4db1), fontSize: 16),
                      leftChevronIcon: Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xffdc4f89),
                        size: 15,
                      ),
                      rightChevronIcon: Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xffdc4f89),
                        size: 15,
                      ),
                      leftChevronMargin: EdgeInsets.only(left: 70),
                      rightChevronMargin: EdgeInsets.only(right: 70),
                    ),
                    calendarStyle: CalendarStyle(
                        weekendStyle: TextStyle(color: Color(0xffdc4f89)),
                        weekdayStyle: TextStyle(color: Color(0xffdc4f89))),
                    daysOfWeekStyle: DaysOfWeekStyle(
                        weekendStyle: TextStyle(color: Color(0xffdc4f89)),
                        weekdayStyle: TextStyle(color: Color(0xffdc4f89))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Selected Extras',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            extra1 = extra1 == 'fridge' ? null : 'fridge';
                          });
                        },
                        child: extraWidget(
                          "fridge",
                          "Inside Fridge\n1000-2000 rub",
                          extra1 == 'fridge',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            extra2 = extra2 == 'patio' ? null : 'patio';
                          });
                        },
                        child: extraWidget("garden", "Patio\n100-140/m^2",
                            extra2 == ('patio') ? true : false),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            extra3 = extra3 == 'materials' ? null : 'materials';
                          });
                        },
                        child: extraWidget(
                            "organise",
                            "We bring materials\n1500-2000 rub",
                            extra3 == 'materials' ? true : false),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          data.selectedExtras = "$extra1,   $extra2,   $extra3";
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FinalizeOrder(data: data)));
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 60, vertical: 15),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: purple),
                          child: Text(
                            "Finalize",
                            style: TextStyle(
                                fontSize: 19,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void changeCleaningType(String type) {
    data.selectedType = type;
    setState(() {});
  }

  void changeFrequency(String frequency) {
    data.selectedFrequency = frequency;
    setState(() {});
  }

  Column extraWidget(String img, String name, bool isSelected) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(shape: BoxShape.circle, color: purple),
              child: Container(
                margin: EdgeInsets.all(17),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('asset/image/icons/$img.png'),
                        fit: BoxFit.contain)),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: (isSelected == true)
                  ? Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Center(
                        child: Icon(
                          Icons.check_circle,
                          color: pink,
                        ),
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          name,
          style: TextStyle(fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
