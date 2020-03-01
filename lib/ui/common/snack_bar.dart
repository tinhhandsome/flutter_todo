import 'package:flutter/material.dart';

void showUndoSnackBar(BuildContext context,
    {String label, VoidCallback onUndo}) {
  final snackBar = SnackBar(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    content: Text(label),
    duration: const Duration(seconds: 2),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: onUndo,
    ),
  );
  Scaffold.of(context).hideCurrentSnackBar();
  Scaffold.of(context).showSnackBar(
    snackBar,
  );
}
