import 'package:flutter/material.dart';
import '../dbhelper.dart';
import '../model/History.dart';
import '../model/ShoppingList.dart';

class MyProvider with ChangeNotifier {
  List<ShoppingList> _shoppingList = [];
  List<History> _historyList = [];
  final DbHelper _dbHelper = DbHelper();

  List<ShoppingList> get shoppingList => _shoppingList;
  List<History> get historyList => _historyList;

  Future<void> fetchShoppingList() async {
    _shoppingList = await _dbHelper.getShoppingLists();
    notifyListeners();
  }

  Future<void> fetchHistoryList() async {
    _historyList = await _dbHelper.getHistory();
    notifyListeners();
  }

  Future<void> addShoppingList(ShoppingList shoppingList) async {
    await _dbHelper.insertShoppingList(shoppingList);
    fetchShoppingList();
  }

  Future<void> deleteShoppingList(int id, String name, int quantity) async {
    String date = DateTime.now().toString(); // Get current date and time
    await _dbHelper.deleteShoppingList(id);
    await _dbHelper
        .insertHistory(History(name: name, quantity: quantity, date: date));
    fetchShoppingList();
    fetchHistoryList();
  }

  Future<void> deleteAll() async {
    for (var item in _shoppingList) {
      String date = DateTime.now().toString();
      await _dbHelper.insertHistory(
          History(name: item.name, quantity: item.quantity, date: date));
    }
    await _dbHelper.deleteAll();
    fetchShoppingList();
    fetchHistoryList();
  }
}
