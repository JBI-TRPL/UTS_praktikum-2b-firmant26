// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:pos_app/database/database_helper.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _resetApp(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Reset'),
        content: const Text(
          'Apakah kamu yakin ingin menghapus semua data aplikasi? '
          'Tindakan ini tidak bisa dibatalkan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Reset'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await DatabaseHelper.instance.clearDatabase();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Seluruh data berhasil dihapus.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () => _resetApp(context),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          icon: const Icon(Icons.restore),
          label: const Text('Reset App'),
        ),
      ),
    );
  }
}
