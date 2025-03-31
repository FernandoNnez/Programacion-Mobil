import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Locator extends StatefulWidget {
  final String titulo;
  const Locator({super.key, required this.titulo});

  @override
  State<Locator> createState() => _LocatorState();
}

class _LocatorState extends State<Locator> {
  String _ubicacion = "Presiona el botón para obtener la ubicación";

  Future<void> _obtenerUbicacion() async {
    bool servicioHabilitado;
    LocationPermission permiso;

    servicioHabilitado = await Geolocator.isLocationServiceEnabled();
    if (!servicioHabilitado) {
      setState(() => _ubicacion = "El servicio de ubicación está desactivado.");
      return;
    }

    permiso = await Geolocator.checkPermission();
    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
      if (permiso == LocationPermission.denied) {
        setState(() => _ubicacion = "Permiso denegado.");
        return;
      }
    }

    if (permiso == LocationPermission.deniedForever) {
      setState(() => _ubicacion = "Permiso denegado permanentemente.");
      return;
    }

    Position posicion = await Geolocator.getCurrentPosition();
    setState(() {
      _ubicacion = "Lat: ${posicion.latitude}, Lon: ${posicion.longitude}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.titulo)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _ubicacion,
              style: const TextStyle(fontSize: 18, color: Colors.blue),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _obtenerUbicacion,
              child: const Text("Obtener Ubicación"),
            ),
          ],
        ),
      ),
    );
  }
}
