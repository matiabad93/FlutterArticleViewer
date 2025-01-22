import 'package:flutter/material.dart';

import '../themes/theme.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _viewingMatches = false; // Estado para alternar entre "Datos" e "Historial"

  // Datos de ejemplo que luego serán cargados dinámicamente
  String name = "Matias";
  String lastName = "Abad";
  DateTime birthDate = DateTime(1993, 1, 02); // Fecha de nacimiento
  String gender = "M";
  String profileImage =
      "https://via.placeholder.com/150"; // Placeholder para la foto de perfil
  int ranking = 25;
  String category = "Avanzado";
  int matchesWon = 15;
  int matchesLost = 10;
  int sets = 35;
  int games = 105;
  int bonusPoints = 10;
  int championships = 3;
  int runnersUp = 2;

  int get age => DateTime.now().year - birthDate.year;

  // Datos de ejemplo para historial de partidos
  List<Map<String, String>> matchHistory = [
    {"date": "15/12/2024", "result": "Perdido", "rival": "Gonzalo Perez Fariña"},
    {"date": "18/11/2024", "result": "Ganado", "rival": "Mario Nunziati"},
    {"date": "05/10/2024", "result": "Ganado", "rival": "Diego Pelicciotti"},
        {"date": "04/10/2024", "result": "Perdido", "rival": "Rodrigo Merlat"},

  ];

  void _toggleView() {
    setState(() {
      _viewingMatches = !_viewingMatches;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final textColor = theme.textTheme.bodySmall?.color ?? Colors.black;
    final secondaryTextColor = Colors.grey;

    return Scaffold(
      appBar: AppBar(
        title: Text("Mi Perfil"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: _viewingMatches ? _buildMatchHistory(primaryColor, textColor) : _buildProfileView(primaryColor, textColor, secondaryTextColor),
    );
  }

  Widget _buildProfileView(Color primaryColor, Color textColor, Color secondaryTextColor) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Foto de perfil
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(profileImage),
          ),
          SizedBox(height: 16),
          Text(
            "$name $lastName",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
          ),
          Text(
            "Edad: $age",
            style: TextStyle(fontSize: 16, color: secondaryTextColor),
          ),
          Text(
            "Sexo: ${gender == "M" ? "Masculino" : "Femenino"}",
            style: TextStyle(fontSize: 16, color: secondaryTextColor),
          ),
          SizedBox(height: 16),

          // Información adicional
          _buildInfoRow("Ranking", "$ranking", textColor, secondaryTextColor),
          _buildInfoRow("Categoría", category, textColor, secondaryTextColor),
          _buildInfoRow("Partidos ganados", "$matchesWon", textColor, secondaryTextColor),
          _buildInfoRow("Partidos perdidos", "$matchesLost", textColor, secondaryTextColor),
          _buildInfoRow("Sets", "$sets", textColor, secondaryTextColor),
          _buildInfoRow("Games", "$games", textColor, secondaryTextColor),
          _buildInfoRow("Puntos bonus", "$bonusPoints", textColor, secondaryTextColor),
          _buildInfoRow("Campeonatos", "$championships", textColor, secondaryTextColor),
          _buildInfoRow("Subcampeonatos", "$runnersUp", textColor, secondaryTextColor),

          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _toggleView,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.buttonTextColor
            ),
            child: Text("Mis Partidos"),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchHistory(Color primaryColor, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Historial de Partidos",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: matchHistory.length,
            itemBuilder: (context, index) {
              final match = matchHistory[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ListTile(
                  leading: Icon(
                    match["result"] == "Ganado"
                        ? Icons.check_circle
                        : Icons.cancel,
                    color: match["result"] == "Ganado"
                        ? Colors.green
                        : Colors.red,
                  ),
                  title: Text("Resultado: ${match["result"]}", style: TextStyle(color: textColor)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Fecha: ${match["date"]}", style: TextStyle(color: textColor)),
                      Text("Rival: ${match["rival"]}", style: TextStyle(color: textColor)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: _toggleView,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.buttonTextColor,
            ),
            child: Text("Volver a Mi Perfil"),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, Color textColor, Color secondaryTextColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
          Text(value, style: TextStyle(color: secondaryTextColor)),
        ],
      ),
    );
  }
}
