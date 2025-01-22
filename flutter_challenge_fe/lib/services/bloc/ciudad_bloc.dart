import 'package:flutter_bloc/flutter_bloc.dart';

import 'ciudad_event.dart';
import 'ciudad_state.dart';

class CiudadBloc extends Bloc<CiudadEvento, CiudadEstado> {
  // Lista de ciudades con IDs
  final Map<String, int> _ciudades = {
    'Funes': 7,
    'Rosario': 4,
    'Carcaraña': 1,
    'Pueblo Esther': 2,
    'San Lorenzo': 10,
    'Roldán': 8,
    'Villa Gobernador Gálvez': 9,
    'Arroyo Seco': 6,
    'Capitán Bermúdez': 5,
    'Granadero Baigorria': 3,
  };

  int intentos = 0;

  CiudadBloc() : super(EstadoInicial()) {
    // Registrar el manejador para el evento VerificarIDCiudad
    on<VerificarIDCiudad>((event, emit) {
      intentos++;
      final idCorrecto = _ciudades[event.ciudad];

      if (idCorrecto == event.idIngresado) {
        emit(EstadoExito(intentos));
        emit(EstadoPantallaExito(event.ciudad, intentos)); // Emitir pantalla de éxito
        intentos = 0; // Reiniciamos intentos tras éxito
      } else {
        emit(EstadoError('ID incorrecto.', intentos));
      }
    });
  }

  List<String> obtenerCiudades() {
    return _ciudades.keys.toList();
  }
}
