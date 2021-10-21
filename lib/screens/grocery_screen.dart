import 'package:flutter/material.dart';
import 'empty_grocery_screen.dart';
import 'grocery_list_screen.dart';

import 'package:provider/provider.dart';
import '../models/models.dart';
import 'grocery_item_screen.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //empty grocery screen
    return Scaffold(
      body: buildGroceryScreen(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Present GroceryItemScreen
          final manager = Provider.of<GroceryManager>(context, listen: false);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GroceryItemScreen(
                onCreate: (item) {
                  manager.addItem(item);
                  Navigator.pop(context);
                },
                onUpdate: (item) {},
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildGroceryScreen() {
  // 1
  return Consumer<GroceryManager>(
    // 2
    builder: (context, manager, child) {
      // 3
      if (manager.groceryItems.isNotEmpty) {
        //Add GroceryListScreen
        return GroceryListScreen(manager: manager);
      } else {
        // 4
        return const EmptyGroceryScreen();
      }
    },
  );
}
