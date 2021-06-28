import 'package:flutter/material.dart';

class CustomSegmentedControl extends StatelessWidget {
  const CustomSegmentedControl({
    Key? key,
    required this.groupText,
    required this.onChange,
    this.currentValue = 0,
  }) : super(key: key);

  final List<String> groupText;
  final Function(int) onChange;
  final int currentValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        for (var i = 0; i < groupText.length; i++)
          _CustomSegmentedControlItem(
            text: groupText[i],
            onTap: () => onChange(i),
            isActive: i == currentValue,
          )
      ],
    );
  }
}

class _CustomSegmentedControlItem extends StatelessWidget {
  const _CustomSegmentedControlItem({
    Key? key,
    required this.text,
    this.onTap,
    this.isActive = false,
  }) : super(key: key);

  final String text;
  final Function()? onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.28,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isActive
              ? Theme.of(context).primaryColor
              : const Color(0xFFEFF1FA),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: isActive
                ? const Color(0xFFEFF1FA)
                : Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
