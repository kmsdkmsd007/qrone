import 'package:flutter/material.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  LoginscreenState createState() => LoginscreenState();
}

class LoginscreenState extends State<Loginscreen> {
  // State variables
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscured = true; // For password visibility toggle
  bool isLoading = false; // For loading indicator

  // Login method
  void login() {
    setState(() {
      isLoading = true;
    });

    // Perform login logic
    // Update state based on login result
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 30,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(19)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                obscureText: isObscured,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(19)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      isObscured ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isObscured = !isObscured;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    login();
                  }
                },
                child: Text(
                  '  Login   ',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Important: Always dispose controllers to prevent memory leaks
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
