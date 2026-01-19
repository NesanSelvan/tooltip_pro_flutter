import 'package:tooltip_plus/tooltip_plus.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tooltip Plus Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Tooltip Plus Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            TooltipTarget.minimal(
              text: "Counter: $_counter",
              child: Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: TooltipTarget.minimal(
        spacing: 30,

        // arrowDirection: TooltipArrowDirection.right,
        text: "Add Item",

        autoDismiss: Duration(seconds: 3),
        border: TooltipBorderConfig(radius: 100, enabled: true),
        direction: TooltipDirection.left,
        onPressed: _incrementCounter,
        child: FloatingActionButton(
          onPressed: null,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
