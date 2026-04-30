import 'package:flutter/material.dart';
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.trailing});
   final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: 40,
              height: 3,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
        trailing ?? const Text('🔥', style: TextStyle(fontSize: 22)),
      ],
    );
  }
}