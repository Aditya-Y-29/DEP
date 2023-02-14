import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String _email="";
  String _password="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText:  "Email",
                  icon: Icon(Icons.email),
                ),
                validator: (input) =>
                    input!.isEmpty ? 'Please enter your email' : null,
                onSaved: (input) => _email = input!,
              ),

              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  icon: Icon(Icons.lock),
                ),
                validator: (input) =>
                    input!.isEmpty ? 'Please enter your password' : null,
                onSaved: (input) => _password = input!,
              ),
              
              const SizedBox(height: 20.0),

              ElevatedButton(
                onPressed: () {
                  print(_email);
                  print(_password);
                },
                child: const Text('Login'),
              ),  
            ],
          ),
        ),
      ),
    );
  }
}