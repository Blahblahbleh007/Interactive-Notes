import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget
    implements PreferredSizeWidget {   // ← required for AppBar slot

  final String title;
  final VoidCallback? onToggleDisplay;

  const MyAppBar({
    super.key, 
    required this.title,
    this.onToggleDisplay, 
  }); // Parameters 

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // automaticallyImplyLeading: false, // ← removes the back button entirely
      title: Text(
        title,
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      // backgroundColor: Colors.green,
      actions: [
        if (onToggleDisplay != null) 
          IconButton(
            // icon: const Icon(Icons.filter_alt),
            icon: const Icon(Icons.filter_list_outlined),
            onPressed: onToggleDisplay,
          ),
      ],
    );
  }

  @override
  Size get preferredSize =>        // ← tells Scaffold the height
      const Size.fromHeight(kToolbarHeight);
}