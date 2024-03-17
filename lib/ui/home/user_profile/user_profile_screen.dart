import 'package:flutter/material.dart';

class UserProfileScrenn extends StatelessWidget {
  static const String routeName = 'user_profile';
  const UserProfileScrenn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('user profile'),
      ),
    );
  }
}
