import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart/bloc/cart_bloc.dart';
import 'cart/bloc/cart_event.dart';
import 'cart/models/cart_item.dart';
import 'cart/view/cart_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartBloc(),
      child: MaterialApp(
        title: 'Shopping Cart',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}

/// Home page with product list and cart button.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const CartScreen()));
            },
          ),
        ],
      ),
      body: ListView(
        children: const [
          _ProductTile(
            item: CartItem(id: '1', name: 'T-Shirt', price: 19.99),
          ),
          _ProductTile(
            item: CartItem(id: '2', name: 'Jeans', price: 49.99),
          ),
          _ProductTile(
            item: CartItem(id: '3', name: 'Sneakers', price: 89.99),
          ),
        ],
      ),
    );
  }
}

class _ProductTile extends StatelessWidget {
  const _ProductTile({required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name),
      subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
      trailing: ElevatedButton(
        onPressed: () {
          context.read<CartBloc>().add(AddToCartEvent(item: item));
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('${item.name} added to cart')));
        },
        child: const Text('Add to Cart'),
      ),
    );
  }
}
