import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/ShoppingList.dart';
import '../providers/MyProvider.dart';
import './HistoryScreen.dart';
import '../widgets/shopping_list_dialog.dart';

class Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => HistoryScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Provider.of<MyProvider>(context, listen: false).deleteAll();
            },
          ),
        ],
      ),
      body: Consumer<MyProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.shoppingList.length,
            itemBuilder: (context, index) {
              final item = provider.shoppingList[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(item.id.toString()),
                ),
                title: Text(item.name),
                subtitle: Text('Quantity: ${item.quantity}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    provider.deleteShoppingList(
                        item.id!, item.name, item.quantity);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) =>
                  ShoppingListDialog(onAdd: (String name, int quantity) {
                    Provider.of<MyProvider>(context, listen: false)
                        .addShoppingList(
                            ShoppingList(name: name, quantity: quantity));
                  }));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
