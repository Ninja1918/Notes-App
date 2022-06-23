import 'package:flutter/material.dart';
import 'package:to_do_list/screens/mainApp/database_services.dart';

class EditPage extends StatelessWidget {
  String dataID;
  String dataTitle;
  String dataDetail;
  final title = TextEditingController();
  final details = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final String _email;
  EditPage(this.dataID, this.dataTitle, this.dataDetail, this._email);
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
              decoration: InputDecoration(
                hintText: dataTitle,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
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
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  hintText: dataDetail),
            ),
            const Spacer(flex: 20),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  updateData(dataID, title.text, details.text, _email);
                }
              },
              child: const Text(
                "UPDATE",
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
