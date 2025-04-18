import 'package:flutter/material.dart';
import '../widgets/item_list.dart';
import '../widgets/emergency_footer.dart';
import '../widgets/code_dialog.dart';
import '../widgets/join_group_dialog.dart';
import '../../../../core/utils/code_generator.dart';
import '../../../../core/services/group_service.dart';
import 'emergency_state_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GroupService _groupService = GroupService();
  String? _groupCode;
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _createGroup() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final code = await _groupService.createGroup();
      setState(() {
        _groupCode = code;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _joinGroup(String code) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      await _groupService.joinGroup(code);
      setState(() {
        _groupCode = code;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
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
              onPressed: () {
                // Show code dialog
                if (_groupCode != null) {
                  showDialog(
                    context: context,
                    builder: (context) => CodeDialog(code: _groupCode!),
                  );
                }
              },
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
              onPressed: () {
                // Show join group dialog
                showDialog<String>(
                  context: context,
                  builder: (context) => const JoinGroupDialog(),
                ).then((enteredCode) {
                  if (enteredCode != null) {
                    _joinGroup(enteredCode);
                  }
                });
              },
            ),
          ),
        ],
      ),
      body: Center(
        child:
            _isLoading
                ? const CircularProgressIndicator()
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_groupCode != null) ...[
                      Text(
                        'Group Code: $_groupCode',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 20),
                    ] else ...[
                      ElevatedButton(
                        onPressed: _createGroup,
                        child: const Text('Create New Group'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Show dialog to enter group code
                          showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: const Text('Join Group'),
                                  content: TextField(
                                    onSubmitted: (value) {
                                      Navigator.pop(context);
                                      _joinGroup(value);
                                    },
                                    decoration: const InputDecoration(
                                      hintText: 'Enter group code',
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancel'),
                                    ),
                                  ],
                                ),
                          );
                        },
                        child: const Text('Join Existing Group'),
                      ),
                    ],
                    if (_errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          _errorMessage,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
      ),
    );
  }
}
