import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> user = {
      "name": "Ibnu",
      "email": "ibnu@email.com",
      "profile_picture":
          "https://cdn.pixabay.com/photo/2016/12/09/09/52/girl-1894125_1280.jpg"
    };
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: const Color(0xFF00BF6D),

        // 🔥 BUTTON KE WELCOME
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/welcome');
            },
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user["profile_picture"] ?? ""),
            ),

            const SizedBox(height: 16),

            Text(
              user["name"] ?? "-",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            buildInfo("Email", user["email"] ?? "-"),
            buildInfo("Name", user["name"] ?? "-"),

            const SizedBox(height: 30),

            // 🔥 BUTTON KE WELCOME (OPSIONAL)
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/welcome');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00BF6D),
              ),
              child: const Text("Kembali ke Welcome"),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfo(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}