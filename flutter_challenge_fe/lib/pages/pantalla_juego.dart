import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/bloc/ciudad_bloc.dart';
import '../services/bloc/ciudad_event.dart';
import '../services/bloc/ciudad_state.dart';

class PantallaJuego extends StatefulWidget {
  @override
  _PantallaJuegoState createState() => _PantallaJuegoState();
}

class _PantallaJuegoState extends State<PantallaJuego> {
  String? ciudadSeleccionada;
  final TextEditingController controladorID = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ciudades = context.read<CiudadBloc>().obtenerCiudades();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFAA1A88), // Color del AppBar
        title: const Text(
          'Working out 1',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white), // Texto blanco
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CiudadBloc, CiudadEstado>(
        builder: (context, estado) {
          if (estado is EstadoPantallaExito) {
            return _pantallaExito(estado.ciudad, estado.intentos);
          }

          return _pantallaInicial(ciudades);
        },
      ),
      bottomNavigationBar: BlocBuilder<CiudadBloc, CiudadEstado>(
        builder: (context, estado) {
          if (estado is EstadoPantallaExito) {
            return SizedBox.shrink(); // Oculta el botón de continuar en la pantalla de éxito
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: _botonContinuar(context),
            );
          }
        },
      ),
    );
  }

  Widget _pantallaInicial(List<String> ciudades) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Descubrí el ID',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _dropdownCiudades(ciudades),
            const SizedBox(height: 16),
            _inputID(),
            const SizedBox(height: 16),
            BlocBuilder<CiudadBloc, CiudadEstado>(
              builder: (context, estado) {
                if (estado is EstadoError) {
                  return Column(
                    children: [
                      const Text(
                        'ID incorrecto.',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Intentos: ${estado.intentos}',
                        style: const TextStyle(
                            color: Colors.red, fontSize: 14),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _pantallaExito(String ciudad, int intentos) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Añade padding para mejor presentación
        child: Text(
          '¡Has descubierto el ID de $ciudad en $intentos intentos!',
          textAlign: TextAlign.center, // Centra el texto
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _dropdownCiudades(List<String> ciudades) {
    return DropdownButton<String>(
      isExpanded: true,
      value: ciudadSeleccionada,
      hint: const Text('Selecciona una ciudad'),
      items: ciudades
          .map((ciudad) => DropdownMenuItem(
                value: ciudad,
                child: Text(ciudad),
              ))
          .toList(),
      onChanged: (nuevaCiudad) {
        setState(() {
          ciudadSeleccionada = nuevaCiudad;
        });
      },
    );
  }

  Widget _inputID() {
    return TextField(
      controller: controladorID,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Ingresa el ID',
      ),
    );
  }

  Widget _botonContinuar(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: const Color(0xFFAA1A88), // Color del texto del botón
        ),
        onPressed: () {
          if (ciudadSeleccionada != null && controladorID.text.isNotEmpty) {
            final idIngresado = int.tryParse(controladorID.text);
            if (idIngresado != null) {
              context.read<CiudadBloc>().add(
                    VerificarIDCiudad(ciudadSeleccionada!, idIngresado),
                  );
            } else {
              _mostrarError('Por favor ingresa un número válido.');
            }
          } else {
            _mostrarError('Selecciona una ciudad y completa el ID.');
          }
        },
        child: const Text('Continuar'),
      ),
    );
  }

  void _mostrarError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: Colors.red,
      ),
    );
  }
}
