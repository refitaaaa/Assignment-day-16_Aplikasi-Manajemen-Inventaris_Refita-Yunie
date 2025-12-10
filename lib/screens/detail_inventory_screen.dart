import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/inventory_item.dart';

class DetailInventoryScreen extends StatelessWidget {
  final InventoryItem item;

  const DetailInventoryScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
    final dateFormat = DateFormat('dd MMM yyyy, HH:mm');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              child: Center(
                child: Icon(
                  Icons.inventory_2,
                  size: 100,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      item.category,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildDetailRow(
                    context,
                    icon: Icons.shopping_cart,
                    label: 'Quantity',
                    value: '${item.quantity} items',
                  ),
                  const Divider(height: 32),
                  _buildDetailRow(
                    context,
                    icon: Icons.attach_money,
                    label: 'Price',
                    value: currencyFormat.format(item.price),
                  ),
                  const Divider(height: 32),
                  _buildDetailRow(
                    context,
                    icon: Icons.calculate,
                    label: 'Total Value',
                    value: currencyFormat.format(item.price * item.quantity),
                    valueColor: Colors.green,
                  ),
                  const Divider(height: 32),
                  _buildDetailRow(
                    context,
                    icon: Icons.calendar_today,
                    label: 'Added On',
                    value: dateFormat.format(item.createdAt),
                  ),
                  if (item.description.isNotEmpty) ...[
                    const Divider(height: 32),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.description,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.description,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600]),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: valueColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
