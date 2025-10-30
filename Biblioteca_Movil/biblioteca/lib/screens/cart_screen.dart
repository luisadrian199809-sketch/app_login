import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../screens/checkout_screen.dart';
import 'home_screen.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Carrito de Compras')),
      body: cartProvider.cartItems.isEmpty
          ? Center(child: Text('No hay libros en el carrito'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.cartItems.length,
                    itemBuilder: (context, index) {
                      final book = cartProvider.cartItems[index];
                      final quantity = cartProvider.quantities[book] ?? 1;
                      return Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          leading: Image.asset(
                            book.image,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            book.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              '\$${book.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.green[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () =>
                                    cartProvider.decreaseQuantity(book),
                              ),
                              Text(quantity.toString()),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () =>
                                    cartProvider.increaseQuantity(book),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => cartProvider.removeBook(book),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          // Ir al Checkout
                          bool success = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => CheckoutScreen()),
                          );

                          if (success != null && success) {
                            // Mensaje de compra exitosa
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text('Compra Exitosa'),
                                content: Text(
                                  'Su compra se ha realizado con éxito.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(
                                        context,
                                      ).pop(); // Cierra el dialog
                                      cartProvider.clearCart(); // Vacía carrito
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (_) => HomeScreen(),
                                        ),
                                        (route) => false,
                                      );
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: Text('Pagar'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
