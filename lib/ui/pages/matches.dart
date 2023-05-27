import 'package:flutter/material.dart';
import 'package:ideal_playground/ui/pages/messages.dart';
import 'package:ideal_playground/ui/pages/search.dart';

class Matches extends StatefulWidget {
  const Matches({Key? key}) : super(key: key);

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Matches")),
    );
  }
}
