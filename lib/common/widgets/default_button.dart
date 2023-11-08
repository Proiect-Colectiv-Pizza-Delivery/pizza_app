import 'package:pizza_app/common/theme/colors.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatefulWidget {
  final String text;
  final Function? onPressed;
  final bool isLoading;
  final Color? color;
  final TextStyle? textStyle;

  const DefaultButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.color,
    this.textStyle,
  }) : super(key: key);

  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = widget.isLoading;
  }

  @override
  void didUpdateWidget(DefaultButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      isLoading = widget.isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed != null ? _onPressed(context) : null,
      style: widget.color != null
          ? Theme.of(context).elevatedButtonTheme.style?.copyWith(
        backgroundColor: MaterialStatePropertyAll(widget.color),
      )
          : null,
      child: _setUpButtonChild(),
    );
  }

  /// return the text label for the button or
  /// a progress indicator when the onPressed operation is in progress.
  Widget _setUpButtonChild() {
    if (isLoading) {
      return const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ));
    }
    TextStyle? style;
    if (widget.textStyle != null) {
      style = widget.textStyle;
    } else {
      style = widget.color == AppColors.white
          ? Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(color: AppColors.black)
          : null;
    }
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Text(
        widget.text.toUpperCase(),
        style: style,
      ),
    );
  }

  VoidCallback? _onPressed(BuildContext context) {
    return () {
      if (!isLoading) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        widget.onPressed?.call();
      }
    };
  }
}
