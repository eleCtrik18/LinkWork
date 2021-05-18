import 'package:checkbox_formfield/checkbox_icon_formfield.dart';
import 'package:checkbox_formfield/checkbox_list_tile_formfield.dart';
import 'package:flutter/material.dart';

class TaskEditPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sample',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  CheckboxListTileFormField(
                    title: Text('Check!'),
                    onSaved: (bool value) {},
                    validator: (bool value) {
                      if (value) {
                        return null;
                      } else {
                        return 'False!';
                      }
                    },
                  ),
                  CheckboxIconFormField(
                    iconSize: 32,
                    onSaved: (bool value) {},
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
