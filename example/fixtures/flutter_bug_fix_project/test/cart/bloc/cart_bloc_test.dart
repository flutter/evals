import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cart_app/cart/bloc/cart_bloc.dart';
import 'package:cart_app/cart/bloc/cart_event.dart';
import 'package:cart_app/cart/bloc/cart_state.dart';
import 'package:cart_app/cart/models/cart_item.dart';

void main() {
  group('CartBloc', () {
    late CartBloc cartBloc;

    const tShirt = CartItem(id: '1', name: 'T-Shirt', price: 19.99);
    const jeans = CartItem(id: '2', name: 'Jeans', price: 49.99);

    setUp(() {
      cartBloc = CartBloc();
    });

    tearDown(() {
      cartBloc.close();
    });

    test('initial state is empty cart', () {
      expect(cartBloc.state, const CartState());
      expect(cartBloc.state.items, isEmpty);
      expect(cartBloc.state.total, 0.0);
    });

    blocTest<CartBloc, CartState>(
      'cart total updates when items are added',
      build: () => CartBloc(),
      act: (bloc) => bloc.add(const AddToCartEvent(item: tShirt)),
      expect: () => [
        predicate<CartState>(
          (state) => state.total == 19.99 && state.items.length == 1,
          'state has total 19.99 and 1 item',
        ),
      ],
    );

    blocTest<CartBloc, CartState>(
      'cart shows correct total after adding multiple items',
      build: () => CartBloc(),
      act: (bloc) {
        bloc.add(const AddToCartEvent(item: tShirt));
        bloc.add(const AddToCartEvent(item: jeans));
      },
      expect: () => [
        predicate<CartState>(
          (state) => state.total == 19.99 && state.items.length == 1,
          'first add: total 19.99, 1 item',
        ),
        predicate<CartState>(
          (state) => state.total == 69.98 && state.items.length == 2,
          'second add: total 69.98, 2 items',
        ),
      ],
    );

    blocTest<CartBloc, CartState>(
      'removing item updates total correctly',
      build: () => CartBloc(),
      seed: () => const CartState(items: [tShirt, jeans], total: 69.98),
      act: (bloc) => bloc.add(const RemoveFromCartEvent(itemId: '1')),
      expect: () => [
        predicate<CartState>(
          (state) => state.total == 49.99 && state.items.length == 1,
          'after remove: total 49.99, 1 item',
        ),
      ],
    );

    blocTest<CartBloc, CartState>(
      'clearing cart resets to empty state',
      build: () => CartBloc(),
      seed: () => const CartState(items: [tShirt, jeans], total: 69.98),
      act: (bloc) => bloc.add(const ClearCartEvent()),
      expect: () => [
        predicate<CartState>(
          (state) => state.total == 0.0 && state.items.isEmpty,
          'after clear: total 0, no items',
        ),
      ],
    );
  });
}
