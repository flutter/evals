import 'package:equatable/equatable.dart';

/// Represents an item in the shopping cart.
class CartItem extends Equatable {
  const CartItem({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  final String id;
  final String name;
  final double price;
  final int quantity;

  /// Total price for this item (price × quantity)
  double get totalPrice => price * quantity;

  CartItem copyWith({String? id, String? name, double? price, int? quantity}) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [id, name, price, quantity];
}
