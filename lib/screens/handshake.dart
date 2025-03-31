import 'package:flutter/material.dart';

class Handshake extends StatelessWidget {
  final String titulo;
  final String nombre;
  final Function(int) cambiarPagina;

  const Handshake({super.key, required this.titulo, required this.nombre, required this.cambiarPagina});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Tu nombre es: $nombre",
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            MaterialButton(
              height: 60,
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                cambiarPagina(1);
              },
              child: Text("Regresar"),
            ),
          ],
        ),
      ),
    );
  }
}
