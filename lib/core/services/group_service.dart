import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class GroupService {
  static const String _baseUrl = 'http://localhost:3000/api';
  final _uuid = const Uuid();

  // In-memory storage for groups (replace with actual backend later)
  final Map<String, Map<String, bool>> _groups = {};

  // Create a new group
  Future<String> createGroup() async {
    try {
      // Generate a unique code
      final code = _generateCode();

      // Create group in memory
      _groups[code] = {};

      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      return code;
    } catch (e) {
      throw Exception('Failed to create group: $e');
    }
  }

  // Join an existing group
  Future<void> joinGroup(String code) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      if (!_groups.containsKey(code)) {
        throw Exception('Group not found');
      }

      // Add member to group
      final memberId = _uuid.v4();
      _groups[code]![memberId] = false;
    } catch (e) {
      throw Exception('Failed to join group: $e');
    }
  }

  // Update member status
  Future<void> updateStatus(String code, bool isEmergency) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      if (!_groups.containsKey(code)) {
        throw Exception('Group not found');
      }

      // Update status for all members (in real app, this would be per member)
      for (var memberId in _groups[code]!.keys) {
        _groups[code]![memberId] = isEmergency;
      }
    } catch (e) {
      throw Exception('Failed to update status: $e');
    }
  }

  // Get group members and their statuses
  Future<Map<String, bool>> getGroupMembers(String code) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      if (!_groups.containsKey(code)) {
        throw Exception('Group not found');
      }

      return Map<String, bool>.from(_groups[code]!);
    } catch (e) {
      throw Exception('Failed to get group members: $e');
    }
  }

  // Helper method to generate a unique code
  String _generateCode() {
    const charset = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = _uuid.v4().replaceAll('-', '');
    return random.substring(0, 6).toUpperCase();
  }
}
