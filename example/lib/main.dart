import 'package:tooltip_pro/tooltip_pro.dart';
import 'package:flutter/material.dart' hide TooltipTriggerMode;

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
            TooltipPro.minimal(
              autoDismiss: Duration(seconds: 3),
              triggerMode: TooltipProTriggerMode.tap,
              animation: TooltipAnimationConfig(
                type: TooltipAnimationType.scale,
                duration: Duration(milliseconds: 1000),
                curve: TooltipAnimationCurve.easeOut,
              ),
              showAtTapPosition: false,
              text: "Counter: $_counter",
              child: Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: TooltipPro.minimal(
        spacing: 30,

        arrowDirection: TooltipArrowDirection.left,
        direction: TooltipDirection.bottom,
        text: "Add Item",

        border: TooltipBorderConfig(
          enabled: true,
          color: Colors.black,
          width: 1,
          radius: 100,
        ),
        autoDismiss: Duration(seconds: 3),
        // direction: TooltipDirection.left,
        onPressed: _incrementCounter,
        child: FloatingActionButton(
          onPressed: null,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
