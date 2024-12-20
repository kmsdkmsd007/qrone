import 'package:flutter/material.dart';
import 'package:qrone/features/login/login_controller.dart';
import 'package:qrone/features/login/login_state.dart';
import 'package:qrone/main.dart';

class LoginPage extends StatelessWidget {
   LoginPage({super.key});


  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final controller= container.get<LoginController>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      backgroundColor: Colors.white,
      body: ValueListenableBuilder<LoginState>(
        valueListenable: controller, // Ensure this listens to the correct controller
        builder: (context, value,child) {
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Title
                      Text(
                        "Login here",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Subtitle
                      Text(
                        "Welcome back you've been missed!",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                       TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(8.0)),
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
                      const SizedBox(height: 20),
                      // Password TextField
                      TextFormField(
                        controller: passwordController,
                        obscureText: !value.isPassword, // Correct the obscureText condition
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              value.isPassword ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      // Forgot password link
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Add your forgot password logic
                          },
                          child: Text(
                            "Forgot your password?",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Sign In Button
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                           controller.login(emailController.text, passwordController.text);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(double.infinity, 50), // Full width button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          "Sign in",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Create new account link
                      TextButton(
                        onPressed: () {
                          // Add your create account logic
                        },
                        child: Text(
                          "Create new account",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Or continue with
                      Text("Or continue with"),
                      const SizedBox(height: 20),
                      // Social Media Buttons
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
