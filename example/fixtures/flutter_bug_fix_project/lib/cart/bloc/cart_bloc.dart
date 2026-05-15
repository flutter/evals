import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/cart_item.dart';
import 'cart_event.dart';
import 'cart_state.dart';

/// BLoC for managing shopping cart state.
///
/// Handles adding, removing, and clearing items from the cart.
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<ClearCartEvent>(_onClearCart);
  }

  // Internal mutable list - this is the bug pattern
  final List<CartItem> _items = [];
  double _total = 0.0;

  void _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) {
    // BUG: Modifying internal mutable list and emitting state with same list reference
    _items.add(event.item);
    _total += event.item.price;
    emit(CartState(items: _items, total: _total));
  }

  void _onRemoveFromCart(RemoveFromCartEvent event, Emitter<CartState> emit) {
    final itemIndex = _items.indexWhere((item) => item.id == event.itemId);
    if (itemIndex != -1) {
      final removedItem = _items.removeAt(itemIndex);
      _total -= removedItem.price;
      emit(CartState(items: _items, total: _total));
    }
  }

  void _onClearCart(ClearCartEvent event, Emitter<CartState> emit) {
    _items.clear();
    _total = 0.0;
    emit(CartState(items: _items, total: _total));
  }
}
