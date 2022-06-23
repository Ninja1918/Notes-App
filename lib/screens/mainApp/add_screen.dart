import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/screens/mainApp/database_services.dart';
import 'package:to_do_list/screens/mainApp/main_home.dart';
import 'package:intl/intl.dart';

class AddPage extends StatelessWidget {
  final title = TextEditingController();
  final details = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final String _email;
  String date = DateFormat('dd-MM-yyyy').format(DateTime.now());
  AddPage(this._email);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Notes",
          style: TextStyle(fontFamily: "Roboto"),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Form(
          key: formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const Spacer(flex: 20),
            TextFormField(
              controller: title,
              validator: (v) {
                if (v!.isEmpty) {
                  return "Please enter the title";
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  hintText: "Title"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: details,
              validator: (v) {
                if (v!.isEmpty) {
                  return "Please enter the details";
                } else {
                  return null;
                }
              },
              maxLines: 7,
              minLines: 1,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  hintText: "Details"),
            ),
            const Spacer(flex: 30),
            Container(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (DateTime selected) {
                    date = DateFormat('dd-MM-yyyy').format(selected);
                  },
                )),
            const Spacer(flex: 20),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  DataBaseServices.addData(
                          title.text, details.text, _email, date)
                      .then((value) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            MainHomePage(_email)));
                  });
                }
              },
              child: const Text(
                "ADD",
                style: TextStyle(fontFamily: "Roboto"),
              ),
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(250, 40))),
            ),
            const Spacer(flex: 100)
          ]),
        ),
      ),
    );
  }
}
