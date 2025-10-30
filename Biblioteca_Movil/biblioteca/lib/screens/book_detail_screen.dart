import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/cart_provider.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;

  BookDetailScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset(book.image, height: 200, fit: BoxFit.cover),
            SizedBox(height: 10),
            Text(book.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(book.author, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
            SizedBox(height: 10),
            Text('\$${book.price.toStringAsFixed(2)}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text(book.description),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                cartProvider.addToCart(book);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Libro agregado al carrito')),
                );
              },
              child: Text('Agregar al carrito'),
            ),
          ],
        ),
      ),
    );
  }
}
