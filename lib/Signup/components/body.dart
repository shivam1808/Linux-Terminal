import 'package:linux/Terminal.dart';
import 'package:linux/components/already_have_an_account_acheck.dart';
import 'package:linux/components/rounded_button.dart';
import 'package:linux/Auth/auth.dart';
import 'package:linux/Login/login_screen.dart';
import 'package:linux/Signup/components/background.dart';
import 'package:linux/Signup/components/or_divider.dart';
import 'package:linux/Signup/components/social_icon.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController ip = new TextEditingController();

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
                "SIGNUP",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Image.asset(
                "assets/icons/terminal.png",
                height: size.height * 0.25,
              ),
              SizedBox(height: size.height * 0.02),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Enter Name",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                controller: name,
              ),
              SizedBox(height: size.height * 0.01),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Enter Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                controller: email,
              ),
              SizedBox(height: size.height * 0.01),
              TextField(
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Enter Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                controller: password,
              ),
              SizedBox(height: size.height * 0.01),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Enter Server IP",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.network_check),
                ),
                controller: ip,
              ),
              RoundedButton(
                  text: "SIGNUP",
                  press: () => {
                        print(name.text),
                        print(email.text),
                        print(password.text),
                        print(ip.text),
                        // writeData(context, name.text, email.text, password.text,
                        //    ip.text)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Terminal(),
                          ),
                        )
                      }),
              SizedBox(height: size.height * 0.01),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
              ),
              OrDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocalIcon(
                    iconSrc: "assets/icons/facebook.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/twitter.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/google-plus.svg",
                    press: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
