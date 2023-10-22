import 'package:fav_place/data/models/user.dart';
import 'package:fav_place/data/models/user_local_data_source/user_local_data_source.dart';
import 'package:fav_place/presntation/pages/places_page.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          title: Text("Sign Up Page"),
        ),
        body: FutureBuilder(
            future: UserLocalDSImpl().hasSignUp().then((value) {
              if (value) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlacesPage(),
                    ));
              }
            }),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                    key: key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                             style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: " Name",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                          validator: (String? text) {
                            if (text == null || text.isEmpty) {
                              return "field is requerd";
                            } else {
                              return null;
                            }
                          },
                          controller: name,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                             style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: " Email",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                          controller: email,
                          validator: (value) {
                            if (value == null ||
                                !value.contains("@") ||
                                !value.endsWith(".com") ||
                                value.length < 5 ||
                                value.startsWith("@")) {
                              return "invali email";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: " password",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return "password must be more than 6 charcter";
                            }
                          },
                          controller: password,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Spacer(),
                        Container(
                          width: 400,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (key.currentState!.validate()) {
                                await UserLocalDSImpl().setUser(User(
                                    name: name.text,
                                    email: email.text,
                                    password: password.text));
                                //   UserLocalDSImpl().hasSignUp();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlacesPage(),
                                    ));
                              }
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                          ),
                        ),
                      ],
                    )),
              );
            }));
  }
}
