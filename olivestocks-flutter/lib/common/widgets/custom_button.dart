import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool hasIcon;
  final IconData? icon;
  final double textSize;
  final double borderRadius;
  final double verticalPadding;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    this.hasIcon = false,
    this.icon,
    this.textSize = 18,
    this.borderRadius = 8,
    this.verticalPadding = 16,
    required this.onPressed,
  }) : assert(!hasIcon || icon != null, 'Icon must be provided if hasIcon is true');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: EdgeInsets.symmetric(vertical: verticalPadding),
          ),
          onPressed: onPressed,
          child: hasIcon
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: textSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              : Text(
                  text,
                  style: TextStyle(
                    fontSize: textSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
