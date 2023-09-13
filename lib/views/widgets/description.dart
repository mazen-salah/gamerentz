import 'package:flutter/material.dart';

class TextWithNewlines extends StatelessWidget {
  final String text;

  const TextWithNewlines({super.key, required this.text});

  List<Widget> _generateTextWidgets() {
    final lines = text.split('\\n');
    List<Widget> widgets = [];

    for (int i = 0; i < lines.length; i++) {
      widgets.add(Text(lines[i]));
      if (i < lines.length - 1) {
        widgets.add(const SizedBox(height: 10.0)); 
      }
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _generateTextWidgets(),
    );
  }
}
