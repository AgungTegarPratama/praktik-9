import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ChatWelcomeScreen extends StatefulWidget {
  const ChatWelcomeScreen({super.key});

  @override
  State<ChatWelcomeScreen> createState() => _ChatWelcomeScreenState();
}

class _ChatWelcomeScreenState extends State<ChatWelcomeScreen> {

  String apiMessage = "Checking API...";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    checkAPI();
  }

  Future<void> checkAPI() async {
    try {
      final result = await ApiService.checkKelompok4();

      setState(() {
        apiMessage = result;
        isLoading = false;
      });

    } catch (e) {
      print("ERROR: $e");

      setState(() {
        apiMessage = "API gagal terhubung";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

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

            /// 🔥 HASIL API
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                apiMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: apiMessage.contains("gagal")
                      ? Colors.red
                      : Colors.green,
                ),
              ),
            ),

            const Spacer(flex: 3),

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