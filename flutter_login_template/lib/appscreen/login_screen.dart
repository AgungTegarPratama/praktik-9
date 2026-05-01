import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../services/api_service.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Sign In"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Sign in with your username and password",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF757575)),
                  ),

                  const SizedBox(height: 30),

                  const SignInForm(),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

@override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // USERNAME
          TextFormField(
            decoration: InputDecoration(
              hintText: "Enter your username",
              labelText: "Username",
              suffix: SvgPicture.string(mailIcon),
              border: authOutlineInputBorder,
              enabledBorder: authOutlineInputBorder,
              focusedBorder: authOutlineInputBorder.copyWith(
                borderSide: const BorderSide(color: Color(0xFFFF7643)),
              ),
            ),
            onSaved: (value) => username = value ?? "",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Username wajib diisi";
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          // PASSWORD
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Enter your password",
              labelText: "Password",
              suffix: SvgPicture.string(lockIcon),
              border: authOutlineInputBorder,
              enabledBorder: authOutlineInputBorder,
              focusedBorder: authOutlineInputBorder.copyWith(
                borderSide: const BorderSide(color: Color(0xFFFF7643)),
              ),
            ),
            onSaved: (value) => password = value ?? "",
            validator: (value) =>
                value!.isEmpty ? "Password wajib diisi" : null,
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: isLoading ? null : handleLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF7643),
              minimumSize: const Size(double.infinity, 50),
            ),
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text("Login"),
          ),
        ],
      ),
    );
  }
}

// ICONS (biarkan seperti ini)
const mailIcon = '''<svg width="18" height="13" ...></svg>''';
const lockIcon = '''<svg width="15" height="18" ...></svg>''';