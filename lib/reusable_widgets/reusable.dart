import 'package:flutter/material.dart';

class TextFieldEmail extends StatelessWidget {
  final hintText;
  final TextEditingController textinp;
  TextFieldEmail(this.hintText, this.textinp);
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
          controller: textinp,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              border: const OutlineInputBorder(), labelText: hintText)),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
    );
  }
}

class TextFieldPassword extends StatelessWidget {
  final hintText;
  final TextEditingController textinp;
  TextFieldPassword(this.hintText, this.textinp);
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
          controller: textinp,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
              border: const OutlineInputBorder(), labelText: hintText)),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
    );
  }
}
