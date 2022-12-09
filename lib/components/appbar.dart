import 'package:flutter/material.dart';

class ApplicationBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(56);
  const ApplicationBar({
    Key? key,
    this.appBarTitle,
  }) : super(key: key);

  final String? appBarTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 138, 127, 254),
      title: Text(appBarTitle!),
    );
  }
}
