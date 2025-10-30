import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class DrawerMenu extends StatelessWidget {
  final Function(String) onSelectCategory;
  final Function() onMyBooks;

  DrawerMenu({required this.onSelectCategory, required this.onMyBooks});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.primary,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: AppColors.primary),
              child: Text(
                'Categorías',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            // Categorías con íconos
            ListTile(
              leading: Icon(Icons.list, color: Colors.white),
              title: Text('Todo', style: TextStyle(color: Colors.white)),
              onTap: () => onSelectCategory('Todo'),
            ),
            ListTile(
              leading: Icon(Icons.medical_services, color: Colors.white),
              title: Text('Medicina', style: TextStyle(color: Colors.white)),
              onTap: () => onSelectCategory('Medicina'),
            ),
            ListTile(
              leading: Icon(Icons.computer, color: Colors.white),
              title: Text('Tecnología', style: TextStyle(color: Colors.white)),
              onTap: () => onSelectCategory('Tecnología'),
            ),
            Divider(color: Colors.white),
            ListTile(
              leading: Icon(Icons.book, color: Colors.white),
              title: Text('Mis Libros', style: TextStyle(color: Colors.white)),
              onTap: onMyBooks,
            ),
          ],
        ),
      ),
    );
  }
}
