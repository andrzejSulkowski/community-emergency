import 'package:flutter/material.dart';
import '../widgets/item_list.dart';
import '../widgets/emergency_footer.dart';

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
        title: const Text('Emergency Group'),
        actions: [
          Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: IconButton(
              icon: const Icon(Icons.add),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                // Add new item functionality
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [Expanded(child: const ItemList()), const EmergencyFooter()],
      ),
    );
  }
}
