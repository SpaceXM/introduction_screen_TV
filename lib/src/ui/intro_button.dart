import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IntroButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final String? semanticLabel;

  const IntroButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.style,
    this.semanticLabel,
  }) : super(key: key);

  @override
  State<IntroButton> createState() => _IntroButtonState();
}

class _IntroButtonState extends State<IntroButton> {
  bool is_on_focus = false;
  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Semantics(
          label: widget.semanticLabel,
          button: true,
          child: Focus(
            onFocusChange: (value) => {
              setState(() {
                is_on_focus = value;
              })
            },
            onKey: (node, event) {
              if (event is RawKeyDownEvent) {
                if (event.logicalKey.keyLabel == 'Select' || event.logicalKey.keyLabel == 'Game Button A' || event.logicalKey == LogicalKeyboardKey.select) {
                  widget.onPressed!();
                  return KeyEventResult.handled;
                }
                return KeyEventResult.ignored;
              }
              return KeyEventResult.ignored;
            },
            child: TextButton(
              onPressed: widget.onPressed,
              child: widget.child,
              style: TextButton.styleFrom(
                backgroundColor: is_on_focus ? Colors.red : Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ).merge(widget.style),
            ),
          )),
    );
  }
}
