class History {
  int? id;
  String name;
  int quantity;
  String date;

  History(
      {this.id,
      required this.name,
      required this.quantity,
      required this.date});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'quantity': quantity,
      'date': date,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  History.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        quantity = map['quantity'],
        date = map['date'];
}
