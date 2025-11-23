class Rental {
  final int? id;
  final int carId;
  final String carName;
  final String carType;
  final String carImageUrl;
  final double carPricePerDay;
  final String renterName;
  final int rentalDays;
  final String startDate;
  final double totalCost;
  final String status;

  Rental({
    this.id,
    required this.carId,
    required this.carName,
    required this.carType,
    required this.carImageUrl,
    required this.carPricePerDay,
    required this.renterName,
    required this.rentalDays,
    required this.startDate,
    required this.totalCost,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'carId': carId,
      'carName': carName,
      'carType': carType,
      'carImageUrl': carImageUrl,
      'carPricePerDay': carPricePerDay,
      'renterName': renterName,
      'rentalDays': rentalDays,
      'startDate': startDate,
      'totalCost': totalCost,
      'status': status,
    };
  }

  factory Rental.fromMap(Map<String, dynamic> map) {
    return Rental(
      id: map['id'],
      carId: map['carId'],
      carName: map['carName'],
      carType: map['carType'],
      carImageUrl: map['carImageUrl'],
      carPricePerDay: map['carPricePerDay'],
      renterName: map['renterName'],
      rentalDays: map['rentalDays'],
      startDate: map['startDate'],
      totalCost: map['totalCost'],
      status: map['status'],
    );
  }

  Rental copyWith({
    int? id,
    int? carId,
    String? carName,
    String? carType,
    String? carImageUrl,
    double? carPricePerDay,
    String? renterName,
    int? rentalDays,
    String? startDate,
    double? totalCost,
    String? status,
  }) {
    return Rental(
      id: id ?? this.id,
      carId: carId ?? this.carId,
      carName: carName ?? this.carName,
      carType: carType ?? this.carType,
      carImageUrl: carImageUrl ?? this.carImageUrl,
      carPricePerDay: carPricePerDay ?? this.carPricePerDay,
      renterName: renterName ?? this.renterName,
      rentalDays: rentalDays ?? this.rentalDays,
      startDate: startDate ?? this.startDate,
      totalCost: totalCost ?? this.totalCost,
      status: status ?? this.status,
    );
  }
}
