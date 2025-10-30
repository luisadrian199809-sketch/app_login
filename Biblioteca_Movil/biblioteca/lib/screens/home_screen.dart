import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/books_provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/book_card.dart';
import '../widgets/category_chip.dart';
import '../widgets/drawer_menu.dart';
import 'book_detail_screen.dart';
import 'cart_screen.dart';
import 'my_books_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'Todo';

  @override
  Widget build(BuildContext context) {
    final booksProvider = Provider.of<BooksProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    // Categorías incluyendo Todo, Medicina y Tecnología
    List<String> categories = ['Todo', 'Medicina', 'Tecnología'];

    // Filtrar libros según la categoría seleccionada
    List books = selectedCategory.isEmpty || selectedCategory == 'Todo'
        ? booksProvider.books
        : booksProvider.books
            .where((b) => booksProvider.bookCategories[b.title] == selectedCategory)
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Biblioteca Móvil'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CartScreen()),
              );
            },
          ),
        ],
      ),
      drawer: DrawerMenu(
        onSelectCategory: (category) {
          setState(() => selectedCategory = category);
          Navigator.pop(context);
        },
        onMyBooks: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => MyBooksScreen()),
          );
        },
      ),
      body: Column(
        children: [
          // Barra de categorías
          Container(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: categories
                  .map(
                    (c) => CategoryChip(
                      category: c,
                      isSelected: c == selectedCategory,
                      onTap: () {
                        setState(() {
                          selectedCategory = c;
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
          SizedBox(height: 10),
          // Grid de libros
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              itemCount: books.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.65),
              itemBuilder: (context, index) {
                return BookCard(
                  book: books[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookDetailScreen(book: books[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
