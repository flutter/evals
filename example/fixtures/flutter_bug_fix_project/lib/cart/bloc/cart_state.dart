import 'package:equatable/equatable.dart';

import '../models/cart_item.dart';

/// Represents the state of the shopping cart.
class CartState extends Equatable {
  const CartState({this.items = const [], this.total = 0.0});

  final List<CartItem> items;
  final double total;

  /// Number of items in the cart
  int get itemCount => items.length;

  /// Whether the cart is empty
  bool get isEmpty => items.isEmpty;

  CartState copyWith({List<CartItem>? items, double? total}) {
    return CartState(items: items ?? this.items, total: total ?? this.total);
  }

  @override
  List<Object?> get props => [items, total];
}
