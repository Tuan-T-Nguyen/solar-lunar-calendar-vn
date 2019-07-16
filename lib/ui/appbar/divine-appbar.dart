import 'package:flutter/material.dart';

class DivineAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text("Divine"),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
