import 'package:authapp/core/errors/failure.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrWidget extends StatelessWidget {
  final Failure failure;

  const ErrWidget({super.key, required this.failure});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            failure.message,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: CupertinoColors.destructiveRed
            )
        )
      ],
    );
  }
}
