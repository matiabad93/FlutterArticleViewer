import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/matches_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/ranking_screen.dart';
import 'screens/availability_screen.dart'; // Importa el nuevo screen

void main() => runApp(TennisApp());

class TennisApp extends StatefulWidget {
  @override
  _TennisAppState createState() => _TennisAppState();
}

class _TennisAppState extends State<TennisApp> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    MatchesScreen(),
    RankingScreen(),
    AvailabilityScreen(),
      ProfileScreen(), // Nuevo screen

  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // Eliminar la etiqueta "debug"
      theme: ThemeData.dark(),
      home: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
  currentIndex: _selectedIndex,
  onTap: (index) => setState(() => _selectedIndex = index),
  backgroundColor: Colors.black, // Color de fondo personalizado
  selectedItemColor: Colors.amber, // Color para el ítem seleccionado
  unselectedItemColor: Colors.white, // Color para los ítems no seleccionados
  items: [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
    BottomNavigationBarItem(icon: Icon(Icons.sports_tennis), label: 'Partidos'),
    BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Posiciones'),
    BottomNavigationBarItem(icon: Icon(Icons.access_time), label: 'Disponibilidad'),
    BottomNavigationBarItem(
  icon: Icon(Icons.person),
  label: 'Mi Perfil',
),

  ],
),

      ),
    );
  }
}
