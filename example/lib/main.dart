import 'package:example/examples_home.dart';
import 'package:flutter/material.dart';

import 'tooltip_pro_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TooltipProApp());
  }
}
