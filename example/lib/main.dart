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
  final TooltipProController _tooltipController = TooltipProController();

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
            const SizedBox(height: 16),
            TooltipPro.minimal(
              controller: _tooltipController,
              text: 'Controlled tooltip',
              tooltipWidth: 160,
              child: const Icon(Icons.info_outline, size: 28),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _tooltipController.show,
                  child: const Text('Show'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _tooltipController.hide,
                  child: const Text('Hide'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            TooltipPro(
              // tooltipHeight: 200,
              tooltipWidth: 180,
              tooltipContent: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbqj9Ii13d6hx5a9kyLnC5A8A96LDSaSZv_w&s',
                ),
              ),
              child: Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: TooltipPro(
        spacing: 30,

        arrowDirection: TooltipArrowDirection.left,
        direction: TooltipDirection.top,
        tooltipContent: Text("Add Item"),
        // text: "Add Item",
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
