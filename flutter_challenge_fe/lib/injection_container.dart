import 'package:get_it/get_it.dart';
import 'services/bloc/ciudad_bloc.dart';

final GetIt localizador = GetIt.instance;

void configurarLocalizador() {
  localizador.registerLazySingleton(() => CiudadBloc());
}
