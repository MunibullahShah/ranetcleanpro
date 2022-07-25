
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import 'ColorScheme.dart';
import 'Data.dart';
import 'MainPage.dart';

class FinalizeOrder extends StatefulWidget {
  static String id = '/finalizeOrder';
  InputData data;
  var sent;

  FinalizeOrder({this.data});

  @override
  _FinalizeOrderState createState() => _FinalizeOrderState();
}

class _FinalizeOrderState extends State<FinalizeOrder> {
  CalendarController _calendarController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _calendarController = CalendarController();
  }

  @override
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
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            height: 570,
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Name",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 350,
                    child: TextFormField(
                      onChanged: (value) {
                        widget.data.customerName = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Name",
                      ),
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Your Name';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Enter your address",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 350,
                    child: TextFormField(
                      onChanged: (value) {
                        widget.data.address = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Your Address';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Address",
                      ),
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Enter phone number",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 350,
                    child: TextFormField(
                      onChanged: (value) {
                        widget.data.phoneNumber = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Your Phone number';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "phone No",
                      ),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Enter your email address",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 350,
                    child: TextFormField(
                      onChanged: (value) {
                        widget.data.email = value;
                      },
                      validator: (value) {
                        if (EmailValidator.validate(value))
                          return null;
                        else
                          return "Enter valid your Email";
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: 'email'),
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      var confirmation = false;
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        widget.sent = await sendEmail(widget.data);
                        confirmation = true;
                      }
                      setState(() {
                        _showMyDialog(confirmation);
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: purple),
                      child: Text(
                        "Reserve slot",
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> sendEmail(InputData data) async {
    final smtpServer = qq(userName, password);

    final message = Message()
      ..from = Address(userName, 'renatCleanPro')
      ..recipients.add('ranetcleanpro@gmail.com')
      ..subject = ('Reserve cleaning slot')
      ..text = (data.customerName +
          ' wants to reserve cleaning slot. \nHis order contains \n Selected cleaning: ${data.selectedType}, \nSelected in Extras: ${data.selectedExtras}, \n on ${data.date.toString()}' +
          '\nCustomer\'s email address:' +
          data.email +
          '\nhis/address :' +
          data.customerName +
          "\nhis phone number: " +
          data.phoneNumber);
    try {
      final sendReport = await send(message, smtpServer);
      if (sendReport.messageSendingEnd != null) {
        return true;
      }
      print('message sent:' + sendReport.toString());
    } catch (Exception) {
      print(Exception);
      return false;
    }
  }

  Future<void> _showMyDialog(bool confirmation) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(confirmation
                    ? 'Your message has been sent'
                    : 'Your message is not sent'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                confirmation
                    ? Navigator.pushNamed(context, MainPage.id)
                    : Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
