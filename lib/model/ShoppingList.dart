class ShoppingList {
  int? id;
  String name;
  int quantity;

  ShoppingList({this.id, required this.name, required this.quantity});

  // Convert object to map for SQLite storage
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'quantity': quantity,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  // Convert map to object
  ShoppingList.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        quantity = map['quantity'];
}
