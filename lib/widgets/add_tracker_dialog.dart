import 'package:flutter/material.dart';
import '../theme.dart';

class AddTrackerDialog extends StatefulWidget {
  final Function(String) onAdd;

  const AddTrackerDialog({super.key, required this.onAdd});

  @override
  State<AddTrackerDialog> createState() => _AddTrackerDialogState();
}

class _AddTrackerDialogState extends State<AddTrackerDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "New Tracker",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: TextField(
        controller: _controller,
        autofocus: true,
        style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
        decoration: InputDecoration(
          hintText: "e.g No Tiktok,No Smoking,No Betting etc.",
          hintStyle: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.5)),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppTheme.accentBlue),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppTheme.primaryGreen),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Cancel",
            style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7)),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            final title = _controller.text.trim();
            if (title.isNotEmpty) {
              widget.onAdd(title);
              Navigator.pop(context);
            }
          },
          child: const Text(
            "Add",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
