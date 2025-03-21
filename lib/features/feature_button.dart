import 'package:flutter/material.dart';

class FeatureButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget screen;
  final Function(BuildContext, Widget) navigateTo;

  const FeatureButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.screen,
    required this.navigateTo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        padding: const EdgeInsets.all(4),
      ),
      onPressed: () => navigateTo(context, screen),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 25, color: Colors.blue),
          const SizedBox(height: 2),
          SelectableText(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
