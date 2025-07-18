import 'package:flutter/cupertino.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const AuthButton({
    super.key,
    required this.onPressed,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      color: CupertinoColors.systemBlue,
      sizeStyle: CupertinoButtonSize.medium,
      borderRadius: BorderRadius.circular(10),
      onPressed: onPressed,
      child: child,
    );
  }
}
