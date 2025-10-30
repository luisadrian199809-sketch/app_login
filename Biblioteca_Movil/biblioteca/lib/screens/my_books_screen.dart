import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/book.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:open_filex/open_filex.dart';
import 'dart:io';

class MyBooksScreen extends StatefulWidget {
  @override
  _MyBooksScreenState createState() => _MyBooksScreenState();
}

class _MyBooksScreenState extends State<MyBooksScreen> {
  List<Book> purchasedBooks = [];

  @override
  void initState() {
    super.initState();
    loadPurchasedBooks();
  }

  Future<void> loadPurchasedBooks() async {
    purchasedBooks = await DatabaseHelper.instance.getPurchasedBooks();
    setState(() {});
  }

  // Función para descargar y abrir PDF localmente
  Future<void> downloadAndOpenPDF(String url, String fileName) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/$fileName.pdf';
      final file = File(filePath);

      // Si el PDF no existe, lo descarga
      if (!await file.exists()) {
        await Dio().download(url, filePath);
      }

      // Abre el PDF con la app predeterminada del dispositivo
      OpenFilex.open(filePath);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('No se pudo abrir el PDF')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mis Libros')),
      body: purchasedBooks.isEmpty
          ? Center(
              child: Text(
                'No ha comprado ningún libro',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: purchasedBooks.length,
              itemBuilder: (context, index) {
                final book = purchasedBooks[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Image.asset(
                      book.image,
                      width: 50,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                    title: Text(book.title),
                    subtitle: Text('\$${book.price.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: Icon(Icons.download, color: Colors.blueAccent),
                      onPressed: () => downloadAndOpenPDF(book.url, book.title),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
