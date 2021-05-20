import 'package:alisveris_listesi/ui/shopping_list_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ShoppingList());
}

class ShoppingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        backgroundColor: Colors.white,
      ),
      home: ShoppingListPage(),
    );
  }
}
