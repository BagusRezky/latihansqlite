import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/MyProvider.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: Consumer<MyProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.historyList.length,
            itemBuilder: (context, index) {
              final item = provider.historyList[index];
              return ListTile(
                title: Text(item.name),
                subtitle: Text(
                    'Quantity: ${item.quantity}, Deleted on: ${item.date}'),
              );
            },
          );
        },
      ),
    );
  }
}
