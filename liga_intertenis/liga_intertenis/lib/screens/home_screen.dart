import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  final List<String> imageList = [
    'assets/images/club1.jpg',
    'assets/images/club2.jpg',
    'assets/images/club3.jpg',
  ];

  final List<String> news = [
    'Gran torneo este fin de semana en Funes',
    'InterTenis Club recibirá las finales',
    'Inscripciones abiertas para la copa de verano, 10 categorías',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
                centerTitle: true,

      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          // Carrusel de fotos
          // CarouselSlider(
          //   options: CarouselOptions(
          //     height: 200,
          //     autoPlay: true,
          //     enlargeCenterPage: true,
          //   ),
          //   items: imageList.map((imagePath) {
          //     return Container(
          //       margin: EdgeInsets.all(8.0),
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(10.0),
          //         image: DecorationImage(
          //           image: AssetImage(imagePath),
          //           fit: BoxFit.cover,
          //         ),
          //       ),
          //     );
          //   }).toList(),
          // ),
          SizedBox(height: 20),
          // Noticias del club
          Expanded(
            child: ListView.builder(
              itemCount: news.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.article, color: Colors.amber),
                  title: Text(
                    news[index],
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
