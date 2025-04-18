import 'package:flutter/material.dart';

class ItemList extends StatelessWidget {
  const ItemList({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample list of items
    final List<String> items = ['Maxi', 'Dagmara', 'Marek', 'Jennifer'];

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Text('${index + 1}'),
            ),
            title: Text(items[index]),
            subtitle: Text('Description for ${items[index]}'),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                // Handle item menu press
              },
            ),
          ),
        );
      },
    );
  }
}
