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