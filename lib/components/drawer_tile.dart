import 'package:flutter/material.dart';

class DrawerTile extends StatefulWidget {
  const DrawerTile({
    super.key,
    required this.leading,
    required this.onTap,
    required this.title,
  });

  final String title;
  final Widget leading;
  final void Function()? onTap;

  @override
  State<DrawerTile> createState() => _DrawerTileState();
}

class _DrawerTileState extends State<DrawerTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.title,
        style: const TextStyle(fontFamily: 'Poppins'),
      ),
      leading: widget.leading,
      onTap: widget.onTap,
    );
  }
}
