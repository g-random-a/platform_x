import 'package:flutter/material.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final Function onDeleteConfirmed;

  const ConfirmDeleteDialog({super.key, required this.onDeleteConfirmed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Delete'),
      content: const Text('Are you sure you want to delete this item?'),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text(
            'Delete',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            onDeleteConfirmed();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
