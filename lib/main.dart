import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:dash_bubble/dash_bubble.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Overlay test 2',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                requestOverlay();
              },
              icon: const Icon(Icons.request_page),
              label: const Text('Request Permission'),
            ),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                startBubble(
                  bubbleOptions: BubbleOptions(
                    bubbleIcon: 'assets/images/test.png',
                    bubbleSize: 50,
                    enableClose: false,
                    distanceToClose: 90,
                    enableAnimateToEdge: true,
                    enableBottomShadow: true,
                    keepAliveWhenAppExit: false,
                  ),
                  onTap: () {
                    logMessage(message: 'Bubble Tapped');
                  },
                );
              },
              icon: const Icon(Icons.play_circle),
              label: const Text('Start Bubble'),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                stopBubble();
              },
              icon: const Icon(Icons.stop),
              label: const Text('Stop Bubble'),
            ),
          ],
        ),
      ),
    );
  }
}

Future <void> requestOverlay() async {
  final isGranted = await DashBubble.instance.requestOverlayPermission();
  if (isGranted == true) {
    print("Permission is granted");
  } else {
    print("Permission not granted");
  }
}

Future <void> startBubble({
  required BubbleOptions bubbleOptions,
  VoidCallback? onTap,
}) async {
  try {
    final hasStarted = await DashBubble.instance.startBubble(
      bubbleOptions: bubbleOptions,
      onTap: onTap,
    );
    if (hasStarted == true) {
      print("Bubble has started");
    } else {
      print("Bubble not started");
    }
  } catch (e) {
    print("An error occurred while starting the bubble: $e");
  }
}

void logMessage({required String message}) {
  log(message);
}

Future <void> stopBubble() async {
  try {
    final hasStopped = await DashBubble.instance.stopBubble();
    if (hasStopped == true) {
      print("Bubble stopped");
    } else {
      print("Bubble not stopped");
    }
  } catch (e) {
    print("An error occurred while stopping the bubble: $e");
  }
}
