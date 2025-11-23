import '../models/car_model.dart';

class CarData {
  static List<Car> getCars() {
    return [
      Car(
        id: 1,
        name: 'Toyota Avanza',
        type: 'MPV',
        imageUrl: 'images/Toyota Avanza.jpg',
        pricePerDay: 350000,
      ),
      Car(
        id: 2,
        name: 'Daihatsu Xenia',
        type: 'MPV',
        imageUrl: 'images/Daihatsu Xenia.jpg',
        pricePerDay: 300000,
      ),
      Car(
        id: 3,
        name: 'Toyota Innova',
        type: 'MPV',
        imageUrl: 'images/Toyota Innova.jpg',
        pricePerDay: 450000,
      ),
      Car(
        id: 4,
        name: 'Mitsubishi Xpander',
        type: 'MPV',
        imageUrl: 'images/Mitsubishi Xpander.jpg',
        pricePerDay: 400000,
      ),
      Car(
        id: 5,
        name: 'Honda Brio',
        type: 'Hatchback',
        imageUrl: 'images/Honda Brio.jpeg',
        pricePerDay: 280000,
      ),
      Car(
        id: 6,
        name: 'Suzuki Ertiga',
        type: 'MPV',
        imageUrl: 'images/Suzuki Ertiga.jpg',
        pricePerDay: 320000,
      ),
      Car(
        id: 7,
        name: 'Toyota Fortuner',
        type: 'SUV',
        imageUrl: 'images/Toyota Fortuner.jpg',
        pricePerDay: 750000,
      ),
      Car(
        id: 8,
        name: 'Daihatsu Terios',
        type: 'SUV',
        imageUrl: 'images/Daihatsu Terios.jpeg',
        pricePerDay: 400000,
      ),
    ];
  }
}
