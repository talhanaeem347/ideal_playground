import 'package:flutter/material.dart';
import 'package:ideal_playground/repositories/user_repository.dart';

class EditProfileScreen extends StatefulWidget {
  final UserRepository userRepository;
  const EditProfileScreen({super.key, required this.userRepository});

  @override
  State<EditProfileScreen> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Edit Profile"),
      ),
    );
  }
}
