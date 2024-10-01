import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/MyProvider.dart';
import 'screens/Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final provider = MyProvider();
        provider.fetchShoppingList();
        provider.fetchHistoryList(); // Ensure history is fetched
        return provider;
      },
      child: MaterialApp(
        title: 'Shopping List',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Screen(),
      ),
    );
  }
}
