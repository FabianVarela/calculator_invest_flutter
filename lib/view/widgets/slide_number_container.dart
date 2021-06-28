import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SlideNumberContainer extends StatefulWidget {
  const SlideNumberContainer({
    Key? key,
    this.value = 0,
    this.maxSliderValue = 100,
    this.isRounded = false,
    this.isEnabledText = true,
    this.leadingText,
    this.onChangeValue,
  }) : super(key: key);

  final double value;
  final double maxSliderValue;
  final bool isRounded;
  final bool isEnabledText;
  final String? leadingText;
  final Function(double)? onChangeValue;

  @override
  _SlideNumberContainerState createState() => _SlideNumberContainerState();
}

class _SlideNumberContainerState extends State<SlideNumberContainer> {
  final TextEditingController _controller = TextEditingController();

  double get _currentValue => widget.value;

  @override
  void initState() {
    super.initState();
    _controller.text = _roundedValue(widget.value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
          margin: const EdgeInsets.only(bottom: 25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (widget.leadingText != null)
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Text(
                    widget.leadingText!,
                    style: const TextStyle(fontSize: 25, color: Colors.grey),
                  ),
                ),
              Flexible(
                child: TextField(
                  enabled: widget.isEnabledText,
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  inputFormatters: widget.isRounded
                      ? [FilteringTextInputFormatter.digitsOnly]
                      : null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: 25,
                    color: Theme.of(context).primaryColor,
                  ),
                  onChanged: (value) {
                    final num = double.parse(value.isNotEmpty ? value : '0');
                    _onSendText(_roundedValue(num));
                  },
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: -2,
          left: 0,
          right: 0,
          child: Slider(
            min: 0,
            max: widget.maxSliderValue,
            value: _currentValue,
            onChanged: (value) => _onSendText(_roundedValue(value)),
          ),
        ),
      ],
    );
  }

  String _roundedValue(double value) =>
      widget.isRounded ? '${value.round()}' : value.toStringAsFixed(1);

  void _onSendText(String text) {
    _controller
      ..text = text
      ..selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );

    widget.onChangeValue!(double.parse(_controller.text));
  }
}
