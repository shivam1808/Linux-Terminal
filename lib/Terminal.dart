import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_icons/flutter_icons.dart';
import 'package:linux/FirebaseUpload/firebaseUpload.dart';
import 'package:linux/Login/components/background.dart';
import 'package:linux/Welcome/welcome_screen.dart';

String query;
String IP_Value = "192.168.43.114";
var i = 0;

class Terminal extends StatelessWidget {
  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Text(
        "Linux Terminal",
        style: GoogleFonts.lato(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }

  BottomAppBar bottomAppBar(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      shape: CircularNotchedRectangle(),
      notchMargin: 5,
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            iconSize: 28.0,
            tooltip: "Home",
            onPressed: () => {},
          ),
          IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              iconSize: 28.0,
              tooltip: "Setting",
              onPressed: () => {}),
        ],
      ),
    );
  }

  FloatingActionButton floatingActionButton() {
    return FloatingActionButton(
      child: const Icon(
        Icons.refresh,
        color: Colors.white,
      ),
      backgroundColor: Colors.black,
      elevation: 2,
      tooltip: "Refresh",
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context),
      body: ListOfDockerImagesBody(),
      floatingActionButton: floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: bottomAppBar(context),
    );
  }
}

class ListOfDockerImagesBody extends StatefulWidget {
  @override
  _ListOfDockerImagesBodyState createState() => _ListOfDockerImagesBodyState();
}

class _ListOfDockerImagesBodyState extends State<ListOfDockerImagesBody> {
  var cmd;
  var webdata;
  var query, display = "";

  myweb(cmd) async {
    var url = "http://$IP_Value/cgi-bin/web.py?x=${cmd}";
    var r = await http.get(url);
    setState(() {
      webdata = r.body;
    });

    setState(() {
      display += "[root@localhost ~]# " + cmd + "\n" + webdata + "\n";
    });
    writeDataFirebase(i, cmd, webdata);
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
          child: SafeArea(
        minimum: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Image.asset(
                  "assets/icons/redhat12.png",
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children: <Widget>[
                  Opacity(
                    opacity: 1,
                    child: GestureDetector(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Colors.grey[800],
                        child: InkWell(
                          splashColor: Colors.red,
                          child: Container(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(
                                    Octicons.terminal,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    "Terminal",
                                    style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                  onTap: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WelcomeScreen(),
                                      ),
                                    ),
                                  },
                                ),
                                _divider(),
                                SingleChildScrollView(
                                  child: Container(
                                    width: 400,
                                    padding: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[800],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                    child: Text(
                                      display ?? "Output",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "[root@localhost ~]# ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      width: 200,
                                      height: 60,
                                      padding: EdgeInsets.only(top: 4),
                                      child: TextField(
                                        onChanged: (val) {
                                          query = val;
                                        },
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                        decoration: InputDecoration(),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                RaisedButton(
                                  onPressed: () {
                                    print("Ip : $IP_Value");
                                    myweb(query);
                                    i = i + 1;
                                  },
                                  textColor: Colors.black,
                                  padding: const EdgeInsets.all(0.0),
                                  child: Container(
                                    child: const Text('Enter',
                                        style: TextStyle(fontSize: 20)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}

Widget _divider() {
  return Container(
    child: Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Divider(
              color: Colors.black,
              thickness: 1,
            ),
          ),
        ),
      ],
    ),
  );
}
