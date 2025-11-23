class Car {
  final int id;
  final String name;
  final String type;
  final String imageUrl;
  final double pricePerDay;

  Car({
    required this.id,
    required this.name,
    required this.type,
    required this.imageUrl,
    required this.pricePerDay,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'imageUrl': imageUrl,
      'pricePerDay': pricePerDay,
    };
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      imageUrl: map['imageUrl'],
      pricePerDay: map['pricePerDay'],
    );
  }
}
