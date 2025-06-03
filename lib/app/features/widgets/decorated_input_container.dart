import 'package:flutter/material.dart';
import 'package:vox_todo/app/settings/colors.dart';

class DecoratedInputContainer extends StatelessWidget {
  const DecoratedInputContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.inputsActiveBackground,
      ),
      constraints: const BoxConstraints(
        maxWidth: double.infinity,
      ),
      child: child,
    );
  }
}
