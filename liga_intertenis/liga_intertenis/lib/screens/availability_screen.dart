import 'package:flutter/material.dart';
import 'package:liga_intertenis/themes/theme.dart'; // Asegúrate de importar el tema

class AvailabilityScreen extends StatefulWidget {
  @override
  _AvailabilityScreenState createState() => _AvailabilityScreenState();
}

class _AvailabilityScreenState extends State<AvailabilityScreen> {
  List<String> _selectedTimes = [];
  bool _isAvailabilityRegistered = false;

  List<String> _getWeekDays() {
    final today = DateTime.now();
    final daysOfWeek = <String>[];

    for (int i = 0; i < 7; i++) {
      final day = today.add(Duration(days: i - today.weekday + 1)); // Ajuste al inicio de la semana (lunes)
      final dayName = _getDayName(day.weekday);
      final formattedDate = '${dayName} ${day.day}/${day.month}/${day.year}';
      daysOfWeek.add(formattedDate);
    }

    return daysOfWeek;
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1: return 'Lunes';
      case 2: return 'Martes';
      case 3: return 'Miércoles';
      case 4: return 'Jueves';
      case 5: return 'Viernes';
      case 6: return 'Sábado';
      case 7: return 'Domingo';
      default: return '';
    }
  }

  void _toggleSelection(String option) {
    setState(() {
      if (_selectedTimes.contains(option)) {
        _selectedTimes.remove(option);
      } else {
        _selectedTimes.add(option);
      }
    });
  }

  void _registerAvailability() {
    setState(() {
      _isAvailabilityRegistered = true;
    });
  }

  void _editAvailability() {
    setState(() {
      _isAvailabilityRegistered = false;
      _selectedTimes.clear();
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Disponibilidad para Partido'),
      centerTitle: true,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          if (!_isAvailabilityRegistered) 
            Text(
              '¿Cuándo puedes jugar?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textColor),
            ),
          SizedBox(height: 20),
          if (_isAvailabilityRegistered) 
            Center( // Centrado del contenido
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Centrado horizontal
                mainAxisAlignment: MainAxisAlignment.center, // Centrado vertical
                children: [
                  Text(
                    'Disponibilidad registrada:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textColor),
                  ),
                  SizedBox(height: 10),
                  // Mostrar los horarios con íconos
                  Column(
                    children: _selectedTimes.map((time) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.access_time, color: AppColors.primaryColor), // Ícono de tiempo
                          SizedBox(width: 8), // Espacio entre el ícono y el texto
                          Text(
                            time,
                            style: TextStyle(fontSize: 16, color: AppColors.textColor),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _editAvailability,
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
                    child: Text('Editar Disponibilidad', style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
                  ),
                ],
              ),
            )
          else 
            Column(
              children: _getWeekDays().map((day) {
                return Column(
                  children: [
                    CheckboxListTile(
                      title: Row(
                        children: [
                          Icon(Icons.access_time, color: AppColors.primaryColor), // Ícono de tiempo
                          SizedBox(width: 8), // Espacio entre el ícono y el texto
                          Text('$day por la mañana', style: TextStyle(color: AppColors.textColor)),
                        ],
                      ),
                      value: _selectedTimes.contains('$day por la mañana'),
                      onChanged: (bool? value) {
                        if (value != null) {
                          _toggleSelection('$day por la mañana');
                        }
                      },
                      activeColor: AppColors.primaryColor,
                    ),
                    CheckboxListTile(
                      title: Row(
                        children: [
                          Icon(Icons.access_time, color: AppColors.primaryColor), // Ícono de tiempo
                          SizedBox(width: 8), // Espacio entre el ícono y el texto
                          Text('$day por la tarde', style: TextStyle(color: AppColors.textColor)),
                        ],
                      ),
                      value: _selectedTimes.contains('$day por la tarde'),
                      onChanged: (bool? value) {
                        if (value != null) {
                          _toggleSelection('$day por la tarde');
                        }
                      },
                      activeColor: AppColors.primaryColor,
                    ),
                  ],
                );
              }).toList(),
            ),
          SizedBox(height: 20),
          if (!_isAvailabilityRegistered)
            ElevatedButton(
              onPressed: _selectedTimes.isNotEmpty
                  ? () {
                      _registerAvailability();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Disponibilidad registrada: ${_selectedTimes.join(", ")}',
                            style: TextStyle(color: AppColors.textColor),
                          ),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
              child: Text('Registrar Disponibilidad', style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
            ),
        ],
      ),
    ),
  );
}
}