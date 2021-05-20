import 'package:alisveris_listesi/model/item.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final Item item;

  const ConfirmDialog({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(item.name),
      content: Text('Confirm to delete ${item.name}'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.white),
          ),
          style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).accentColor),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(
            'Delete',
            style: TextStyle(color: Colors.white),
          ),
          style: TextButton.styleFrom(backgroundColor: Colors.redAccent),
        ),
      ],
    );
  }
}
