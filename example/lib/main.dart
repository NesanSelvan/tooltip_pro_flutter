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
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: TooltipTarget(
        tooltipHeight: 50,
        tooltipWidth: 100,
        spacing: 40,
        horizontalPadding: 20,
        verticalPadding: 20,
        tooltipColor: Colors.white,
        direction: TooltipDirection.top,
        arrowDirection: TooltipArrowDirection.custom,
        // customArrowOffset: 0.4,
        autoDismiss: const Duration(seconds: 2),
        onPressed: _incrementCounter,
        tooltipContent: const Text("data"),
        border: const TooltipBorderConfig(enabled: true, radius: 10),
        shadow: const TooltipShadowConfig(
          enabled: true,
          elevation: 0.4,
          blurRadius: 2,
        ),
        // tooltipBuilder: (context) {
        //   return Material(
        //     child: Container(color: Colors.red, child: const Text('Hello')),
        //   );
        // },
        blur: TooltipBlurConfig(
          enabled: true,
          sigma: 0,
          color: Colors.black.withValues(alpha: 0.5),
          includeChild: false,
        ),
        child: FloatingActionButton(
          onPressed: null,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
