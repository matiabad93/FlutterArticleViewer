import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liga_intertenis/themes/theme.dart';  // Asegúrate de importar tu tema

class MatchesScreen extends StatefulWidget {
  @override
  _MatchesScreenState createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  // Lista de partidos
  final List<Map<String, String>> matches = [
    {
      'category': 'Categoría 1',
      'player1': 'Carlos Memmo',
      'player2': 'Samuel Carim',
      'time': '10:00 AM',
      'court': 'Cancha 1',
      'location': 'Funes',
      'day': 'LUNES 26',
    },
    {
      'category': 'Categoría 2',
      'player1': 'Mauro Lucero',
      'player2': 'Martin Bonel',
      'time': '11:30 AM',
      'court': 'Cancha 2',
      'location': 'Rosario',
      'day': 'LUNES 26',
    },
    {
      'category': 'Categoría 3',
      'player1': 'Matias Abad',
      'player2': 'Matias Perotti',
      'time': '01:00 PM',
      'court': 'Cancha 3',
      'location': 'Funes',
      'day': 'MARTES 27',
    },
    {
      'category': 'Categoría 4',
      'player1': 'Mario Nunziati',
      'player2': 'Martin Mune',
      'time': '02:30 PM',
      'court': 'Cancha 4',
      'location': 'Funes',
      'day': 'MARTES 27',
    },
  ];

  // Filtros disponibles
  final List<String> categories = [
    'Todas',
    for (int i = 1; i <= 11; i++) 'Categoría $i'
  ];
  final List<String> locations = ['Todas', 'Funes', 'Rosario'];
  final List<String> days = [
    'Todos',
    'LUNES 26',
    'MARTES 27',
    'MIÉRCOLES 28',
  ];

  // Valores seleccionados
  String selectedCategory = 'Todas';
  String selectedLocation = 'Todas';
  String selectedDay = 'Todos';

  // Función para formatear la fecha
  String formatDate(String date) {
    if (date == 'Todos') {
      return 'Todos'; // Devolver 'Todos' si no es una fecha
    }

    try {
      // Convertir la fecha en un objeto DateTime
      final DateTime dateTime = DateTime.parse(date);

      // Obtener el formato "Día de la semana, número de día de mes de mes"
      return DateFormat('EEEE d \'de\' MMMM', 'es_ES').format(dateTime).toUpperCase();
    } catch (e) {
      return 'Fecha inválida'; // En caso de un error de formato
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filtrar partidos
    final filteredMatches = matches.where((match) {
      final matchesCategory =
          selectedCategory == 'Todas' || match['category'] == selectedCategory;
      final matchesLocation =
          selectedLocation == 'Todas' || match['location'] == selectedLocation;
      final matchesDay =
          selectedDay == 'Todos' || match['day'] == selectedDay;
      return matchesCategory && matchesLocation && matchesDay;
    }).toList();

    // Agrupar partidos por sede y luego por día
    Map<String, Map<String, List<Map<String, String>>>> groupedByLocationAndDay = {};
    for (var match in filteredMatches) {
      if (!groupedByLocationAndDay.containsKey(match['location'])) {
        groupedByLocationAndDay[match['location'] ?? ''] = {};
      }

      if (!groupedByLocationAndDay[match['location']]!.containsKey(match['day'])) {
        groupedByLocationAndDay[match['location']]![match['day'] ?? ''] = [];
      }

      groupedByLocationAndDay[match['location']]![match['day']]?.add(match);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Partidos'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Filtros con labels
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Filtro por categoría
                Column(
                  children: [
                    Text('Categoría', style: TextStyle(color: AppColors.textColor)),
                    DropdownButton<String>(
                      value: selectedCategory,
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value!;
                        });
                      },
                      items: categories.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      dropdownColor: AppColors.backgroundColor,
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                  ],
                ),
                // Filtro por sede
                Column(
                  children: [
                    Text('Sede', style: TextStyle(color: AppColors.textColor)),
                    DropdownButton<String>(
                      value: selectedLocation,
                      onChanged: (value) {
                        setState(() {
                          selectedLocation = value!;
                        });
                      },
                      items: locations.map((location) {
                        return DropdownMenuItem(
                          value: location,
                          child: Text(location),
                        );
                      }).toList(),
                      dropdownColor: AppColors.backgroundColor,
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                  ],
                ),
                // Filtro por día
                Column(
                  children: [
                    Text('Día', style: TextStyle(color: AppColors.textColor)),
                    DropdownButton<String>(
                      value: selectedDay,
                      onChanged: (value) {
                        setState(() {
                          selectedDay = value!;
                        });
                      },
                      items: days.map((day) {
                        return DropdownMenuItem(
                          value: day,
                          child: Text(day),
                        );
                      }).toList(),
                      dropdownColor: AppColors.backgroundColor,
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Lista de partidos filtrados
          Expanded(
            child: groupedByLocationAndDay.isNotEmpty
                ? ListView.builder(
                    itemCount: groupedByLocationAndDay.length,
                    itemBuilder: (context, index) {
                      String currentLocation = groupedByLocationAndDay.keys.elementAt(index);
                      Map<String, List<Map<String, String>>> locationMatches = groupedByLocationAndDay[currentLocation]!;

                      return Column(
                        children: locationMatches.keys.map((currentDay) {
                          List<Map<String, String>> dayMatches = locationMatches[currentDay]!;

                          return Column(
                            children: [
                              // Resaltado del día con la sede antes de la fecha
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '$currentLocation - $currentDay DE DICIEMBRE',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.highlightedTextColor,
                                    ),
                                  ),
                                ),
                              ),
                              // Lista de partidos para el día
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: dayMatches.length,
                                itemBuilder: (context, index) {
                                  final match = dayMatches[index];
                                  return Card(
                                    color: AppColors.backgroundColor,
                                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                                    child: ListTile(
                                      leading: Icon(Icons.sports_tennis, color: AppColors.primaryColor),
                                      title: Text(
                                        '${match['player1']} vs ${match['player2']}',
                                        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textColor),
                                      ),
                                      subtitle: Text(
                                        '${match['location']} - ${match['day']} - Horario: ${match['time']} | ${match['court']}',
                                        style: TextStyle(color: AppColors.secondaryColorLight),
                                      ),
                                      trailing: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            color: AppColors.primaryColor,
                                            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                            child: Text(
                                              match['category']!,
                                              style: TextStyle(color: AppColors.highlightedTextColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        }).toList(),
                      );
                    },
                  )
                : Center(child: Text('No hay partidos para mostrar', style: TextStyle(color: AppColors.textColor))),
          ),
        ],
      ),
    );
  }
}
