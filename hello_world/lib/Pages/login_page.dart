import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late String _phoneNumber;
  late String _password;

  late int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _phoneNumber = value!;
                },
              ),


              if (_counter == 0)
                ElevatedButton(
                  child: const Text('Send OTP'),
                  onPressed: () {
                    setState(() {
                      _counter++;
                    });
                  },
                ),



              if(_counter != 0)
                TextFormField(
                  decoration: const InputDecoration(labelText: 'OTP'),
                  obscureText: true,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your OTP';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),



              if (_counter != 0)     
                ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    _counter = 0;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyHomePage()),
                    );
                  },
                ),


              ElevatedButton(
                child: const Text('Create an account'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignupPage()),
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