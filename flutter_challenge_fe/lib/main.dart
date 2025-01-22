import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/pantalla_juego.dart';
import 'services/bloc/ciudad_bloc.dart';

void main() {
  runApp(const MiAplicacion());
}

class MiAplicacion extends StatelessWidget {
  const MiAplicacion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Juego de IDs',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false, // Oculta la etiqueta "Debug"
      home: BlocProvider(
        create: (_) => CiudadBloc(),
        child: PantallaJuego(),
      ),
    );
  }
}
