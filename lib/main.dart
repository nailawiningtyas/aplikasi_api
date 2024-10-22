import 'package:flutter/material.dart';
import 'food_detail.dart';
import 'api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Nutrients API App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<dynamic> _searchResults = [];
  bool _isLoading = false;
  String? _statusMessage;

  Future<void> _searchFoods(String query) async {
    if (query.isEmpty) {
      setState(() {
        _statusMessage = 'No results found';
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _statusMessage = null;
    });

    final results = await ApiService.searchFoods(query);

    setState(() {
      _isLoading = false;
      if (results == null || results.isEmpty) {
        _statusMessage = 'No results found';
        _searchResults = [];
      } else {
        _searchResults = results;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Food Nutrients')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Search Food',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => _searchFoods(_controller.text),
                ),
              ),
              onSubmitted: _searchFoods,
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _searchResults.isEmpty
                    ? Center(child: Text(_statusMessage ?? 'No results found'))
                    : ListView.builder(
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final food = _searchResults[index];
                          return ListTile(
                            title: Text(food['description']),
                            subtitle: Text('FDC ID: ${food['fdcId']}'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FoodDetailScreen(food: food),
                                ),
                              );
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
