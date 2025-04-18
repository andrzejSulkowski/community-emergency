import 'package:flutter/material.dart';
import '../widgets/item_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Item List'),
      ),
      body: const ItemList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new item functionality
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
