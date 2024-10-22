import 'package:flutter/material.dart';

class FoodDetailScreen extends StatelessWidget {
  final Map<String, dynamic> food;

  FoodDetailScreen({required this.food});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Food Details')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(food['description'],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text('FDC ID: ${food['fdcId']}'),
          SizedBox(height: 20),
          Text('Nutrients:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Column(
            children: (food['foodNutrients'] as List<dynamic>).map((nutrient) {
              return ListTile(
                title: Text(nutrient['nutrientName']),
                subtitle: Text('${nutrient['value']} ${nutrient['unitName']}'),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
