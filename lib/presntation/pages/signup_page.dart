import 'package:fav_place/presntation/bloc/authentication_bloc_bloc.dart';
import 'package:fav_place/presntation/pages/places_page.dart';
import 'package:fav_place/presntation/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  @override
  void initState() {
    context.read<AuthenticationBlocBloc>().add(AuthenticationIsSignedInEvent());
    super.initState();
  }

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
        body: BlocListener<AuthenticationBlocBloc, AuthenticationBlocState>(
          listener: (context, state) async {
            if (state is AuthenticationBlocAuthorizedState) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => PlacesPage(),
              ));
            }
          },
         
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Sign Up",
                        style: Theme.of(context).textTheme.bodyMedium),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        labelText: " Email",
                        labelStyle: TextStyle(
                            fontSize: 18,
                            fontFamily: "",
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
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
                        icon: Icon(
                          Icons.key,
                          color: Colors.white,
                        ),
                        labelText: " password",
                        labelStyle: TextStyle(
                            fontSize: 18,
                            fontFamily: "",
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
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
                    const SizedBox(
                      height: 32,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInPage(),
                            ));
                      },
                      child: const Text(
                        "Do You Have Account?",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            fontFamily: ""),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      width: 400,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (key.currentState!.validate()) {
                            context.read<AuthenticationBlocBloc>().add(
                                AuthenticationSignUpEvent(
                                    email: email.text,
                                    password: password.text));
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
                            fontSize: 15,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }
}
