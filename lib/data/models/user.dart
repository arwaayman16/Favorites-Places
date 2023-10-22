import 'package:flutter/material.dart';

class User {
final String name,email,password;

  User({required this.name, required this.email, required this.password});

Map <String,String> toMap (){
  return {"name": name,"email":email,"password":password};
}
factory User.fromMap (Map m){
  return User(name:m["name"],email:m["email"],password:m["password"]);
}
}