import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/reusable_widgets/reusable.dart';
import 'package:to_do_list/screens/signin_screen.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailtext = TextEditingController();
  final _passwordtext = TextEditingController();
  bool _err = false;
  _stateChanger() {
    setState(() {
      _err = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
            width: double.infinity,
            child: Column(
              children: [
                const Spacer(flex: 100),
                const Text(
                  "Welcome",
                  style: TextStyle(
                      fontSize: 50,
                      fontFamily: "Archivo",
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                const Spacer(flex: 40),
                TextFieldEmail("Email", _emailtext),
                const Spacer(flex: 1),
                TextFieldPassword("Password", _passwordtext),
                const Spacer(flex: 20),
                ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: _emailtext.text,
                            password: _passwordtext.text)
                        .then((value) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => SignIn()));
                    }).catchError((onError) => _stateChanger());
                  },
                  child: const Text("SignUp"),
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 30))),
                ),
                _err
                    ? const Text(
                        "Invalid Password/Email",
                        style: TextStyle(color: Colors.red),
                      )
                    : const Text(""),
                const Spacer(flex: 100),
              ],
            )));
  }
}
