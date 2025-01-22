# Flutter Challenge

## Descripción

Este proyecto es una aplicación móvil desarrollada en Flutter, que muestra una lista de artículos obtenidos de una API. El proyecto utiliza la arquitectura BLoC para la gestión de estado y sigue los principios de la arquitectura hexagonal para organizar el código de manera modular y escalable.

## Requisitos

- Flutter SDK: ^3.0.0
- Dart SDK: ^2.17.0
- Android Studio o Xcode (dependiendo de la plataforma de desarrollo)
- Dispositivo físico o emulador para pruebas

## Configuración del Proyecto

1. Clonar el repositorio:

    ```bash
    git clone https://github.com/matiabad93/FlutterArticleViewer
    cd flutter_challenge_fe
    ```

2. Instalar las dependencias:

    ```bash
    flutter pub get
    ```

3. Ejecutar la aplicación:

    ```bash
    flutter run
    ```

## Arquitectura

### 1. Arquitectura BLoC

Se utiliza la arquitectura BLoC (Business Logic Component) para la gestión de estado, lo que permite separar la lógica de negocio de la interfaz de usuario. Esto facilita la mantenibilidad del código y su escalabilidad. Los eventos y estados relacionados con los artículos se gestionan a través de BLoC, permitiendo una respuesta reactiva a las acciones del usuario y cambios en los datos.

### 2. Arquitectura Hexagonal

El proyecto sigue los principios de la arquitectura hexagonal para organizar el código en módulos claros y separados:

- **Domain**: Contiene las entidades del dominio y los casos de uso. Ejemplo: `GetArticles`.
- **Data**: Implementa las interfaces definidas en el dominio y maneja la obtención y almacenamiento de datos. Ejemplo: `ArticleRepository`.
- **Pages**: Contiene la interfaz de usuario y la lógica de presentación. Ejemplo: widgets y blocs.

### 3. Dependencias Utilizadas

- `flutter_bloc`: Para la gestión de estados con BLoC.
- `dio`: Para realizar solicitudes HTTP a la API.
- `get_it`: Para la inyección de dependencias y manejo de instancias de servicios.
- `sqflite`: Para almacenamiento local en la base de datos SQLite.
- `path_provider`: Para obtener rutas del sistema de archivos.

## Desafíos Enfrentados

1. **Manejo de Errores**: Asegurar que los errores de red y base de datos se manejen adecuadamente fue un desafío. Esto se abordó utilizando bloques try-catch y emitiendo estados de error específicos.

2. **Implementación de Caching**: Configurar el almacenamiento en caché de artículos para acceso sin conexión presentó dificultades, especialmente en la sincronización de datos entre la base de datos local y las solicitudes de red.

## Funcionalidades Pendientes

- **Tests**: Aún no se han implementado los tests unitarios y de widget. Estos serán añadidos en futuras versiones para asegurar la calidad del código.

## Contribuciones

Las contribuciones son bienvenidas. Por favor, abre un issue o un pull request para discutir los cambios que te gustaría realizar.
