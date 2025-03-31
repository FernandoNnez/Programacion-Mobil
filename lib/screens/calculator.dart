import 'dart:math';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key, required this.titulo});
  final String titulo;

  @override
  State<Calculator> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculator> {
  String _input = "";

  void _pressButton(String v) {
    setState(() {
      if (_esOperador(v) && (_input.isEmpty || _ultimoEsOperador())) {
        return;
      }

      if (v == ".") {
        if (_ultimoNumeroTienePunto()) return; // Evita múltiples puntos en un número
      }

      if (v == "=") {
        _calcula();
        return;
      }

      _input += v;
    });
  }

  bool _esOperador(String v) {
    return ["+", "-", "x", "/", "%", "^"].contains(v);
  }

  bool _ultimoEsOperador() {
    if (_input.isEmpty) return false;
    String lastChar = _input[_input.length - 1];
    return _esOperador(lastChar);
  }

  bool _ultimoNumeroTienePunto() {
    List<String> partes = _input.split(RegExp(r"[\+\-\*/%^]")); // Separa por operadores
    if (partes.isEmpty) return false;
    return partes.last.contains("."); // Si el último número ya tiene ".", no deja agregar otro
  }

  void _calcula() {
    try {
      String expresion = _input.replaceAll("x", "*"); // Reemplazar 'x' por '*'
      List<String> tokens = expresion.split(RegExp(r"(\+|\-|\*|\/|\%|\^)"));
      List<String> operadores = expresion.split(RegExp(r"[0-9.]+")).where((e) => e.isNotEmpty).toList();

      if (tokens.length < 2 || operadores.length < 1) return;

      double resultado = double.parse(tokens[0]);

      for (int i = 0; i < operadores.length; i++) {
        double num = double.parse(tokens[i + 1]);
        switch (operadores[i]) {
          case "+":
            resultado += num;
            break;
          case "-":
            resultado -= num;
            break;
          case "*":
            resultado *= num;
            break;
          case "/":
            if (num != 0) {
              resultado /= num;
            } else {
              _input = "Error";
              return;
            }
            break;
          case "%":
            resultado %= num;
            break;
          case "^":
            resultado = pow(resultado, num).toDouble();
            break;
        }
      }

      _input = resultado.toString();
    } catch (e) {
      _input = "Error";
    }
    setState(() {});
  }

  void _limpiar() {
    setState(() {
      _input = "";
    });
  }

  void _borrar() {
    setState(() {
      if (_input.isEmpty) return;
      _input = _input.substring(0, _input.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.titulo)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 350,
              padding: const EdgeInsets.all(20),
              color: Colors.black87,
              child: Text(
                _input.isEmpty ? "0" : _input,
                textAlign: TextAlign.end,
                style: const TextStyle(fontSize: 55, color: Colors.white),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _crearFila(["C", "⌫", "%", "/"]),
                _crearFila(["7", "8", "9", "x"]),
                _crearFila(["4", "5", "6", "-"]),
                _crearFila(["1", "2", "3", "+"]),
                _crearFila(["0", ".", "^", "="]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _crearFila(List<String> valores) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: valores.map((texto) {
        return Padding(
          padding: const EdgeInsets.all(5),
          child: MaterialButton(
            height: 95,
            minWidth: 80,
            color: Theme.of(context).primaryColor,
            child: Text(
              texto,
              style: const TextStyle(fontSize: 35, color: Colors.white),
            ),
            onPressed: () {
              if (texto == "C") {
                _limpiar();
              } else if (texto == "⌫") {
                _borrar();
              } else {
                _pressButton(texto);
              }
            },
          ),
        );
      }).toList(),
    );
  }
}
