import 'package:flutter/material.dart';

class CounterButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const CounterButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 20),
      label: Text(text, style: Theme.of(context).textTheme.labelMedium),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(minimumSize: const Size(180, 45)),
    );
  }
}
