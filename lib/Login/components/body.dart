import 'package:linux/components/already_have_an_account_acheck.dart';
import 'package:linux/components/rounded_button.dart';
import 'package:linux/Auth/auth.dart';
import 'package:linux/Login/components/background.dart';
import 'package:linux/Signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Body extends StatelessWidget {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOGIN",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
              Image.asset(
                "assets/icons/terminal.png",
                height: size.height * 0.35,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Enter Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                controller: email,
              ),
              SizedBox(height: size.height * 0.01),
              Container(
                child: Card(
                  child: TextField(
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Enter Password",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    controller: password,
                  ),
                ),
              ),
              RoundedButton(
                text: "LOGIN",
                press: () => {
                  if (email.text.length == 0 || password.text.length == 0)
                    {
                      Fluttertoast.showToast(
                        msg: "Empty Field(s)",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16,
                      )
                    }
                  else
                    {
                      loginCheck(email.text, password.text, context),
                    }
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
