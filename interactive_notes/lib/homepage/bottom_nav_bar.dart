import 'package:flutter/material.dart';

class MyBottomNavBar extends StatelessWidget {
  final List<Widget> components;

  const MyBottomNavBar({super.key, required this.components});

  @override
  Widget build(BuildContext context) {
    // return nothing if list is empty
    if (components.isEmpty) return const SizedBox.shrink();

    return Container(
      height: 70,
      color: Theme.of(context).colorScheme.primary,
      alignment: Alignment.center,
      child: Row(                         // ← Row goes inside child:
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (var widget in components)  // ← correct for loop
            widget,
        ],
      ),
    );
  }
}
