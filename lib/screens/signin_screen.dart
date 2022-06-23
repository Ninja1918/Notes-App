import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/reusable_widgets/reusable.dart';
import 'package:to_do_list/screens/mainApp/main_home.dart';
import 'package:to_do_list/screens/signup_screen.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => SignInState();
}

class SignInState extends State<SignIn> {
  final _emailtext = TextEditingController();
  final _passwordtext = TextEditingController();
  bool _err = false;
  stateChanger() {
    setState(() {
      _err = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            child: Column(
              children: [
                const Spacer(flex: 100),
                const Text(
                  "Notebook App",
                  style: TextStyle(
                      fontSize: 60,
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
                        .signInWithEmailAndPassword(
                            email: _emailtext.text,
                            password: _passwordtext.text)
                        .then((value) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              MainHomePage(_emailtext.text)));
                    }).catchError((onError) {
                      print(onError);
                      stateChanger();
                    });
                  },
                  child: const Text("Login"),
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 30))),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("New here? ",
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w100)),
                    TextButton(
                        child: const Text("Signup",
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w100)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        }),
                  ],
                ),
                _err
                    ? const Text(
                        "Invalid Password/Email",
                        style: TextStyle(color: Colors.red),
                      )
                    : const Text(""),
                const Spacer(flex: 60),
              ],
            )));
  }
}
