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
      backgroundColor: AppTheme.surfaceGrey,
      title: const Text(
        "New Tracker",
        style: TextStyle(
          color: AppTheme.textWhite,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: TextField(
        controller: _controller,
        autofocus: true,
        style: const TextStyle(color: AppTheme.textWhite),
        decoration: InputDecoration(
          hintText: "e.g No Tiktok,No Smoking,No Betting etc.",
          hintStyle: TextStyle(color: AppTheme.textWhite.withOpacity(0.5)),
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
            style: TextStyle(color: AppTheme.textWhite.withOpacity(0.7)),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryGreen,
          ),
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
              color: AppTheme.backgroundBlack,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
