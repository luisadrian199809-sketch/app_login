import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../database/database_helper.dart';
import 'home_screen.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool _isProcessing = true;

  @override
  void initState() {
    super.initState();
    _processPurchase();
  }

  Future<void> _processPurchase() async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    // Guardar los libros comprados en la base de datos
    for (var book in cartProvider.cartItems) {
      await DatabaseHelper.instance.insertPurchasedBook(book);
    }

    // Vaciar el carrito
    cartProvider.clearCart();

    // Pequeña espera para mostrar el check visual
    await Future.delayed(Duration(seconds: 1));

    setState(() => _isProcessing = false);

    // Opcional: regresar automáticamente al Home después de 2 segundos
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Procesando Compra')),
      body: Center(
        child: _isProcessing
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Procesando su compra...'),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 80),
                  SizedBox(height: 20),
                  Text(
                    '¡Compra realizada con éxito!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
      ),
    );
  }
}
