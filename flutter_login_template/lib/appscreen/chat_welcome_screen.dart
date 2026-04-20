import 'package:flutter/material.dart';

class ChatWelcomeScreen extends StatelessWidget {
  const ChatWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            Image.asset(
            "assets/images/splash-4.png",
            height: 300,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
            const Spacer(flex: 3),
            Text(
              "Welcome to our freedom \nmessaging app",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text(
              "Freedom talk any person of your \nmother language.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color!
                    .withOpacity(0.64),
              ),
            ),
            const Spacer(flex: 3),

            /// 🔥 TOMBOL SUDAH ADA AKSI
            TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/onboarding');
              },
              icon: const Text("Skip"),
              label: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
