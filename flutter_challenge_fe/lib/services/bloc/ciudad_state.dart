abstract class CiudadEstado {}

class EstadoInicial extends CiudadEstado {}

class EstadoExito extends CiudadEstado {
  final int intentos;

  EstadoExito(this.intentos);
}

class EstadoError extends CiudadEstado {
  final String mensaje;
  final int intentos;

  EstadoError(this.mensaje, this.intentos);
}

class EstadoPantallaExito extends CiudadEstado {
  final String ciudad;
  final int intentos;
  

  EstadoPantallaExito(this.ciudad, this.intentos);
}
