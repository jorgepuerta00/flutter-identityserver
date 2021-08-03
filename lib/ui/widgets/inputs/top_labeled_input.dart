import 'package:flutter/material.dart';

class TopLabeledInput extends StatelessWidget {
  const TopLabeledInput({
    Key? key,
    required this.label,
    required this.widget,
  }) : super(key: key);

  final String label;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: Theme.of(context).textTheme.caption,
        ),
        SizedBox(
          height: 7,
        ),
        widget,
      ],
    );
  }
}
