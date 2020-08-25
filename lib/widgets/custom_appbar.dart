import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget titleText;
  final List<Widget> actionWidgets;

  const CustomAppBar({Key key, this.titleText, this.actionWidgets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: titleText,
      actions: actionWidgets,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
