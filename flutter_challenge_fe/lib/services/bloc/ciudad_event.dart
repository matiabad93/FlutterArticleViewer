abstract class CiudadEvento {}

class VerificarIDCiudad extends CiudadEvento {
  final String ciudad;
  final int idIngresado;

  VerificarIDCiudad(this.ciudad, this.idIngresado);
}
