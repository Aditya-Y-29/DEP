import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name, _phone, _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter a valid Name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value ?? "",
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'PhoneNum'),
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter a valid PhoneNum';
                  }
                  return null;
                },
                onSaved: (value) => _phone = value ?? "",
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) => _email = value ?? "",
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter a valid password';
                  }
                  return null;
                },
                onSaved: (value) => _password = value ?? "",
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // _formKey.currentState.save();
                    _loginUser();
                  }
                },
                child: const Text('Signup'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _loginUser() async {
    print("Signup function called");
    // print(_email);
  }
}
