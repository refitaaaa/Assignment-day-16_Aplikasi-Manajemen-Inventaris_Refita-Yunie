import 'package:cloud_firestore/cloud_firestore.dart';

class InventoryItem {
  final String id;
  final String name;
  final String category;
  final int quantity;
  final double price;
  final String description;
  final DateTime createdAt;
  final String userId;

  InventoryItem({
    required this.id,
    required this.name,
    required this.category,
    required this.quantity,
    required this.price,
    required this.description,
    required this.createdAt,
    required this.userId,
  });

  factory InventoryItem.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return InventoryItem(
      id: doc.id,
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      quantity: data['quantity'] ?? 0,
      price: (data['price'] ?? 0).toDouble(),
      description: data['description'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      userId: data['userId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'quantity': quantity,
      'price': price,
      'description': description,
      'createdAt': Timestamp.fromDate(createdAt),
      'userId': userId,
    };
  }

  // Convenience method to create a copy with updated fields
  InventoryItem copyWith({
    String? id,
    String? name,
    String? category,
    int? quantity,
    double? price,
    String? description,
    DateTime? createdAt,
    String? userId,
  }) {
    return InventoryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
    );
  }
}