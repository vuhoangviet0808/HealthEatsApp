import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatelessWidget {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isValidEmail(String email){
    final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    return password.length >= 6;
  }

  Future<void> _registerUser(BuildContext context,String username,String email, String password) async {
    try{
      final url = Uri.parse('http://10.0.2.2:5000/auth/user/register');

      final body = json.encode({
        'username': username,
        'email': email,
        'password': password
      });

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body:body,
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration successful')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to connect to the server')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome back!",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 10),
            Text(
              "Please fill the following fields to register",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Name")
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  String email = _emailController.text;
                  String password = _passwordController.text;
                  String name = _nameController.text;

                  if(!_isValidEmail(email)){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please enter a valid email adddress")),
                    );
                  } else if(!_isValidPassword(password)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Password must be at least 6 characters long")),
                    );
                  }else{
                    _registerUser(context, name, email, password);
                  }
                },
                child: Text("Register"),

              ),
            ),
          ],
        ),
      ),
    );
  }
}