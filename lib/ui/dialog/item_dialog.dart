import 'package:flutter/material.dart';

class ItemDialog extends StatefulWidget {
  @override
  _ItemDialogState createState() => _ItemDialogState();
}

class _ItemDialogState extends State<ItemDialog> {
  final _formKey = GlobalKey<FormState>();
  String _itemName;
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Add your shop'),
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: TextFormField(
                  autofocus: true,
                  maxLength: 50,
                  onSaved: (value) => _itemName = value,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Validation Error!';
                    }
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).accentColor),
                child: Text(
                  'Add item to shopping list',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: _saveForm,
              )
            ],
          ),
        )
      ],
    );
  }

  void _saveForm() {
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      Navigator.pop(context, _itemName);
    }
  }
}
