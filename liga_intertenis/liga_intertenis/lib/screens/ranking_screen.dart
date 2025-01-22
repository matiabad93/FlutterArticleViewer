import 'package:flutter/material.dart';

class RankingScreen extends StatefulWidget {
  @override
  _RankingScreenState createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  String? _selectedCategory;
  bool _showGeneralRanking = false;

  final List<String> categories = [
    'Categoría 1', 'Categoría 2', 'Categoría 3', 'Categoría 4',
    'Categoría 5', 'Categoría 6', 'Categoría 7', 'Categoría 8',
    'Categoría 9', 'Categoría 10', 'Categoría 11'
  ];

  final Map<String, List<Map<String, dynamic>>> rankingsByCategory = {
    'Categoría 1': [
      {'position': 1, 'name': 'Carlos Memmo', 'matchesWon': 7, 'matchesLost': 1, 'setsDiff': 15, 'gamesDiff': 89, 'points': 16, 'average': 2.00, 'bonus': 2},
      {'position': 2, 'name': 'Samuel Carim', 'matchesWon': 11, 'matchesLost': 3, 'setsDiff': 12, 'gamesDiff': 90, 'points': 22, 'average': 1.75, 'bonus': 3},
      {'position': 3, 'name': 'Gianina Giarratana', 'matchesWon': 6, 'matchesLost': 2, 'setsDiff': 10, 'gamesDiff': 80, 'points': 15, 'average': 1.75, 'bonus': 1},
    ],
    'Categoría 4': [
      {'position': 1, 'name': 'Matias Abad', 'matchesWon': 7, 'matchesLost': 1, 'setsDiff': 15, 'gamesDiff': 89, 'points': 16, 'average': 2.00, 'bonus': 2},
      {'position': 2, 'name': 'Matias Perotti', 'matchesWon': 11, 'matchesLost': 3, 'setsDiff': 12, 'gamesDiff': 90, 'points': 22, 'average': 1.75, 'bonus': 3},
      {'position': 3, 'name': 'Martin Mune', 'matchesWon': 6, 'matchesLost': 2, 'setsDiff': 10, 'gamesDiff': 80, 'points': 15, 'average': 1.75, 'bonus': 1},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabla de posiciones'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Mostrar el botón "Ranking General" solo si estamos en el ranking por categorías
            if (!_showGeneralRanking) ...[
              DropdownButton<String>( 
                value: _selectedCategory,
                hint: Text('Seleccione una categoría'),
                onChanged: (newCategory) {
                  setState(() {
                    _selectedCategory = newCategory;
                  });
                },
                items: categories.map<DropdownMenuItem<String>>((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showGeneralRanking = true;
                    _selectedCategory = null; // Limpiar selección de categoría
                  });
                },
                child: Text('RANKING GENERAL'),
              ),
            ],
            // Mostrar el botón "Ranking por Categorías" solo si estamos en el ranking general
            if (_showGeneralRanking) ...[
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showGeneralRanking = false; // Volver al ranking por categorías
                  });
                },
                child: Text('RANKING POR CATERGORIAS'),
              ),
              _buildGeneralRankingTable(),
            ],
            // Mostrar el ranking por categoría cuando esté seleccionada una categoría
            if (!_showGeneralRanking && _selectedCategory != null && rankingsByCategory[_selectedCategory] != null)
              _buildCategoryTable(_selectedCategory!)
            else if (!_showGeneralRanking)
              Center(child: Text('Por favor, seleccione una categoría.')),
          ],
        ),
      ),
    );
  }

  /// Construye la tabla de posiciones por categoría seleccionada
  Widget _buildCategoryTable(String category) {
    return Expanded(
      child: SingleChildScrollView(
        child: DataTable(
          columnSpacing: 25.0,
          columns: _buildTableHeaders(),
          rows: rankingsByCategory[category]!
              .map((player) => _buildPlayerRow(player))
              .toList(),
        ),
      ),
    );
  }

  /// Construye la tabla de posiciones general
  Widget _buildGeneralRankingTable() {
    final List<Map<String, dynamic>> generalRanking = [];
    rankingsByCategory.forEach((category, players) {
      generalRanking.addAll(players);
    });

    generalRanking.sort((a, b) => a['points'].compareTo(b['points']) * -1);

    return Expanded(
      child: SingleChildScrollView(
        child: DataTable(
          columnSpacing: 25.0,
          columns: _buildTableHeaders(),
          rows: generalRanking.asMap().entries.map((entry) {
            final index = entry.key + 1;
            final player = entry.value;
            return _buildPlayerRow(player, index);
          }).toList(),
        ),
      ),
    );
  }

  /// Define las cabeceras de la tabla
  List<DataColumn> _buildTableHeaders() {
    return [
      DataColumn(label: Text('#', style: _headerStyle())),
      DataColumn(label: Text('Jugador', style: _headerStyle())),
      DataColumn(label: Text('G', style: _headerStyle())),
      DataColumn(label: Text('P', style: _headerStyle())),
      DataColumn(label: Text('DS', style: _headerStyle())),
      DataColumn(label: Text('DG', style: _headerStyle())),
      DataColumn(label: Text('PTS', style: _headerStyle())),
      DataColumn(label: Text('PROM', style: _headerStyle())),
      DataColumn(label: Text('BON.', style: _headerStyle())),
    ];
  }

  /// Define una fila de jugador para la tabla
  DataRow _buildPlayerRow(Map<String, dynamic> player, [int? positionOverride]) {
    final position = positionOverride ?? player['position'];
    return DataRow(
      cells: [
        DataCell(Center(child: Text(position.toString(), style: _cellStyle()))),
        DataCell(SizedBox(
          width: 100,
          child: Text(player['name'], style: _cellStyle(), overflow: TextOverflow.ellipsis),
        )),
        DataCell(Center(child: Text(player['matchesWon'].toString(), style: _cellStyle()))),
        DataCell(Center(child: Text(player['matchesLost']?.toString() ?? '0', style: _cellStyle()))),
        DataCell(Center(child: Text(player['setsDiff'].toString(), style: _cellStyle()))),
        DataCell(Center(child: Text(player['gamesDiff'].toString(), style: _cellStyle()))),
        DataCell(Center(child: Text(player['points'].toString(), style: _highlightStyle()))),
        DataCell(Center(child: Text(player['average']?.toStringAsFixed(2) ?? '0.00', style: _highlightStyle()))),
        DataCell(Center(child: Text(player['bonus']?.toString() ?? '0', style: _bonusStyle()))),
      ],
    );
  }

  /// Estilos
  TextStyle _headerStyle() => TextStyle(fontSize: 10, color: Colors.amber, fontWeight: FontWeight.bold);
  TextStyle _cellStyle() => TextStyle(color: Colors.white, fontSize: 10);
  TextStyle _highlightStyle() => TextStyle(color: Colors.amber[800], fontSize: 10, fontWeight: FontWeight.bold);
  TextStyle _bonusStyle() => TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold);
}
