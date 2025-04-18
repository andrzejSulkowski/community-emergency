import 'package:flutter/material.dart';
import '../widgets/item_list.dart';
import '../widgets/emergency_footer.dart';
import '../widgets/code_dialog.dart';
import '../widgets/join_group_dialog.dart';
import '../../../../core/utils/code_generator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _groupCode = '';
  bool _hasMembers = false;

  @override
  void initState() {
    super.initState();
    _updateCode();
  }

  void _updateCode() {
    setState(() {
      _groupCode = CodeGenerator.generateCode(_hasMembers);
    });
  }

  void _showCodeDialog() {
    showDialog(
      context: context,
      builder: (context) => CodeDialog(code: _groupCode),
    );
  }

  void _showJoinGroupDialog() {
    showDialog<String>(
      context: context,
      builder: (context) => const JoinGroupDialog(),
    ).then((enteredCode) {
      if (enteredCode != null) {
        // TODO: Handle joining group with the entered code
        setState(() {
          _hasMembers = true;
        });
        _updateCode();
      }
    });
  }

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
              icon: const Icon(Icons.qr_code),
              color: Theme.of(context).colorScheme.primary,
              onPressed: _showCodeDialog,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: IconButton(
              icon: const Icon(Icons.add),
              color: Theme.of(context).colorScheme.primary,
              onPressed: _showJoinGroupDialog,
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
