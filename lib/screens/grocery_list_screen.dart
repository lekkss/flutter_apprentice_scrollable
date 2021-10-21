import 'package:flutter/material.dart';
import '../components/grocery_tile.dart';
import '../models/models.dart';
import 'grocery_item_screen.dart';

class GroceryListScreen extends StatelessWidget {
  final GroceryManager manager;

  const GroceryListScreen({
    Key? key,
    required this.manager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Replace with ListView
    final groceryItems = manager.groceryItems;
    return Padding(
        padding: EdgeInsets.all(16),
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16.0);
          },
          itemCount: groceryItems.length,
          itemBuilder: (context, index) {
            final item = groceryItems[index];
            // Wrap in a Dismissable
            //Wrap in an InkWell
            // 5
            return Dismissible(
              key: Key(item.id),
              direction: DismissDirection.endToStart,
              background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  child: const Icon(Icons.delete_forever,
                      color: Colors.white, size: 50.0)),
              // 9
              onDismissed: (direction) {
                // 10
                manager.deleteItem(index);
                // 11
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${item.name} dismissed')));
              },
              child: InkWell(
                child: GroceryTile(
                  key: Key(item.id),
                  item: item,
                  onComplete: (change) {
                    if (change != null) {
                      manager.completeItem(index, change);
                    }
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GroceryItemScreen(
                        originalItem: item,
                        // 3
                        onUpdate: (item) {
                          // 4
                          manager.updateItem(item, index);
                          // 5
                          Navigator.pop(context);
                        },
                        // 6
                        onCreate: (item) {},
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ));
  }
}
