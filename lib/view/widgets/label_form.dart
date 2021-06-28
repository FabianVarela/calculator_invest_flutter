import 'package:flutter/material.dart';

class LabelForm extends StatelessWidget {
  const LabelForm({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 12),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
