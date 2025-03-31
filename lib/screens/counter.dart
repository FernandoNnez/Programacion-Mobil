import 'dart:math';
import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({super.key, required this.titulo});
  final String titulo;

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;
  String _randomText = "";
  String _replace = " oao ";
  String _toReplace = 'o';
  int _incrementSize = 1;
  final Random _random = Random();
  double _emojiSize = 60.0;

  String _getRandomChar() {
    int asciiCode = _random.nextInt(24) + 98;
    return String.fromCharCode(asciiCode);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _randomText += _getRandomChar();
      _emojiSize += _incrementSize;
    });
  }

  void _removeCharacter() {
    setState(() {
      if (_randomText.isNotEmpty) {
        _counter--;
        _randomText = _randomText.substring(0, _randomText.length - _incrementSize);
        _emojiSize -= 5;
      }
    });
  }

  void _replaceG() {
    setState(() {
      _randomText = _randomText.replaceAll(_toReplace, _replace);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.titulo),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _removeCharacter,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: _emojiSize,
                height: _emojiSize,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.amber,
                ),
                child: const Text(
                  "🐱",
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Contador: $_counter',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              _randomText.isEmpty ? "Texto vacío" : _randomText,
              style: const TextStyle(fontSize: 20, color: Colors.blueAccent),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _replaceG,
              child: Text("Reemplazar '$_toReplace' por $_replace"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Incrementar',
        child: const Icon(Icons.add),
      ),
    );
  }
}
