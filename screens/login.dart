// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:futures_local_storage_and_database/screens/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // variable for the obscurity of the password
  bool isPasswordObscured = true;
  // key for the password in the local storage
  final String passwordKey = "login-password";
  // temp variable for password from the local storage
  late String localPassword;
  // controller for the password text field
  final myPasswordController = TextEditingController();
  // controller for the username text field
  final myUserNameController = TextEditingController();

  // function to change the obscurity of the password
  changeObscurity() {
    setState(() {
      isPasswordObscured = !isPasswordObscured;
    });

    @override
    // ignore: unused_element
    void dispose() {
      // Clean up the controller when the widget is disposed.
      myPasswordController.dispose();
      super.dispose();
    }
  }

//#region shared Preferences

// controller of widgets

  // init of the SharedPreferences / local storage
  final Future<SharedPreferences> meinSpeicher =
      SharedPreferences.getInstance();

  // function to save a password in the local storage / shared preferences
  Future<bool> setPassword({required String neuesPasswort}) async {
    SharedPreferences speicher = await meinSpeicher;
    bool result = await speicher.setString(passwordKey, neuesPasswort);
    return result;
  }

  // function to get the password from the local storage / shared preferences
  Future<String> getPassword() async {
    SharedPreferences speicher = await meinSpeicher;
    localPassword = speicher.getString(passwordKey) ?? "default";
    return localPassword;
  }

//#endregion

  SnackBar snackBarWithErrorMessage = SnackBar(
    content: Center(
      child: Text(
        "Falsches oder fehlendes Passwort",
        style: TextStyle(
          color: Colors.red,
        ),
      ),
    ),
  );

  @override
  void initState() {
    setPassword(neuesPasswort: "passwort");
    getPassword();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.blueGrey,
              padding: EdgeInsets.all(2.h),
              child: TextField(
                controller: myUserNameController,
                decoration: InputDecoration(
                  hintText: "UserName",
                  hintStyle: TextStyle(color: Colors.black45),
                ),
              ),
            ),
            SizedBox(height: 5.h),
            Container(
              color: Colors.teal,
              padding: EdgeInsets.all(2.h),
              child: TextField(
                controller: myPasswordController,
                decoration: InputDecoration(
                    hintText: "Passwort",
                    hintStyle: TextStyle(color: Colors.black45),
                    // Button to change obscurity of the password
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: IconButton(
                          icon: Icon(Icons.visibility_off),
                          color: Colors.white,
                          onPressed: () => changeObscurity(),
                        ))),
                obscureText: isPasswordObscured,
                obscuringCharacter: "*",
                // besser keine Autokorrektur bei Passwörtern
                autocorrect: false,
                // damit die Passwörter bei der Angabe nicht in den Suggestions angezeigt werden
                enableSuggestions: false,
              ),
            ),
            SizedBox(height: 5.h),
            ElevatedButton(
              onPressed: () {
                // falls das Passwort aus dem local storage
                // mit dem angegebenen Passwort übereinstimmt
                if (localPassword == myPasswordController.text) {
                  // Navigiere zum To Do Screem
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ToDos(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(snackBarWithErrorMessage);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
              ),
              child: Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
