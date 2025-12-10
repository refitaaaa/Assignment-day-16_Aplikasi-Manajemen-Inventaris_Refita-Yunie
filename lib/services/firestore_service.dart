import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/inventory_item.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String userId;

  FirestoreService(this.userId);

  /// Get all inventory items (real-time)
  Stream<List<InventoryItem>> getInventoryItems() {
    return _db
        .collection('inventory')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => InventoryItem.fromFirestore(doc)).toList());
  }

  /// Add new inventory item (ensure createdAt stored correctly)
  Future<void> addInventoryItem(InventoryItem item) async {
    try {
      final data = item.toMap();
      data['createdAt'] = FieldValue.serverTimestamp(); // FIX

      await _db.collection('inventory').add(data);
    } on FirebaseException catch (e) {
      throw Exception('Failed to add item: ${e.message}');
    }
  }

  /// Update existing inventory item
  Future<void> updateInventoryItem(String id, InventoryItem item) async {
    try {
      final data = item.toMap();
      await _db.collection('inventory').doc(id).update(data);
    } on FirebaseException catch (e) {
      throw Exception('Failed to update item: ${e.message}');
    }
  }

  /// Delete inventory item
  Future<void> deleteInventoryItem(String id) async {
    try {
      await _db.collection('inventory').doc(id).delete();
    } on FirebaseException catch (e) {
      throw Exception('Failed to delete item: ${e.message}');
    }
  }

  /// Get single item by ID
  Future<InventoryItem?> getInventoryItemById(String id) async {
    try {
      final doc = await _db.collection('inventory').doc(id).get();
      if (!doc.exists) return null;
      return InventoryItem.fromFirestore(doc);
    } on FirebaseException catch (e) {
      throw Exception('Failed to get item: ${e.message}');
    }
  }

  /// Inventory statistics (optimized)
  Future<Map<String, dynamic>> getInventoryStats() async {
    try {
      final snapshot = await _db
          .collection('inventory')
          .where('userId', isEqualTo: userId)
          .get();

      int totalItems = snapshot.docs.length;
      int totalQuantity = 0;
      double totalValue = 0;

      for (var doc in snapshot.docs) {
        final item = InventoryItem.fromFirestore(doc);
        totalQuantity += item.quantity;
        totalValue += item.price * item.quantity;
      }

      return {
        'totalItems': totalItems,
        'totalQuantity': totalQuantity,
        'totalValue': totalValue
      };
    } on FirebaseException catch (e) {
      throw Exception('Failed to get statistics: ${e.message}');
    }
  }

  /// Filter by category (real-time)
  Stream<List<InventoryItem>> getInventoryItemsByCategory(String category) {
    return _db
        .collection('inventory')
        .where('userId', isEqualTo: userId)
        .where('category', isEqualTo: category)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => InventoryItem.fromFirestore(doc)).toList());
  }

  /// Search by name (local filter: safer + no extra index)
  Future<List<InventoryItem>> searchInventoryItems(String query) async {
    try {
      final snapshot = await _db
          .collection('inventory')
          .where('userId', isEqualTo: userId)
          .get();

      return snapshot.docs
          .map((doc) => InventoryItem.fromFirestore(doc))
          .where((item) =>
              item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } on FirebaseException catch (e) {
      throw Exception('Failed to search items: ${e.message}');
    }
  }
}
