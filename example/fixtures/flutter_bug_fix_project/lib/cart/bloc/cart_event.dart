import 'package:equatable/equatable.dart';

import '../models/cart_item.dart';

/// Base class for all cart events.
sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

/// Event to add an item to the cart.
final class AddToCartEvent extends CartEvent {
  const AddToCartEvent({required this.item});

  final CartItem item;

  @override
  List<Object?> get props => [item];
}

/// Event to remove an item from the cart.
final class RemoveFromCartEvent extends CartEvent {
  const RemoveFromCartEvent({required this.itemId});

  final String itemId;

  @override
  List<Object?> get props => [itemId];
}

/// Event to clear all items from the cart.
final class ClearCartEvent extends CartEvent {
  const ClearCartEvent();
}
