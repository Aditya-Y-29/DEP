import 'package:flutter/material.dart';

import '../main_pages/home_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _phoneNumber;
  late String _userName;
  late String _email;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your Name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),

              TextFormField(
                decoration: const InputDecoration(labelText: 'UserName'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your UserName';
                  }
                  return null;
                },
                onSaved: (value) {
                  _userName = value!;
                },
              ),


              TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your Email Address';
                }
                return null;
              },
              onSaved: (value) {
                _email = value!;
              },
              ),




              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone Number'),
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


              ElevatedButton(
                child: const Text('Signup'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage()),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}