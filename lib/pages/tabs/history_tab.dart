import 'package:flutter/material.dart';
import '../../models/rental_model.dart';
import '../../helpers/database_helper.dart';
import '../rental_detail_page.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  List<Rental> rentals = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRentals();
  }

  Future<void> _loadRentals() async {
    final data = await DatabaseHelper.instance.getAllRentals();
    setState(() {
      rentals = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.black,
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
          child: Row(
            children: [
              Container(width: 3, height: 30, color: Colors.white),
              const SizedBox(width: 12),
              const Text(
                'RENTAL HISTORY',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.black),
                )
              : rentals.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.history, size: 64, color: Colors.grey[300]),
                      const SizedBox(height: 16),
                      Text(
                        'NO RENTAL HISTORY',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadRentals,
                  color: Colors.black,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: rentals.length,
                    itemBuilder: (context, index) {
                      final rental = rentals[index];
                      return _buildRentalCard(rental);
                    },
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildRentalCard(Rental rental) {
    Color statusColor;
    String statusText;

    switch (rental.status.toLowerCase()) {
      case 'active':
        statusColor = Colors.black;
        statusText = 'ACTIVE';
        break;
      case 'completed':
        statusColor = Colors.grey;
        statusText = 'COMPLETED';
        break;
      case 'cancelled':
        statusColor = Colors.grey[600]!;
        statusText = 'CANCELLED';
        break;
      default:
        statusColor = Colors.grey;
        statusText = rental.status.toUpperCase();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: InkWell(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RentalDetailPage(rentalId: rental.id!),
            ),
          );
          _loadRentals();
        },
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey[100],
                  child: Image.asset(
                    rental.carImageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.directions_car, size: 40),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          rental.carType.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 9,
                            letterSpacing: 1,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          rental.carName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          rental.renterName,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${rental.rentalDays} days • ${rental.startDate}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              color: statusColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    statusText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    'Rp ${_formatPrice(rental.totalCost)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatPrice(double price) {
    return price
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}
