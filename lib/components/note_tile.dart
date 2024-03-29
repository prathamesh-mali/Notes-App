import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:notes_app/components/note_setting.dart';

class NoteTile extends StatelessWidget {
  final String text;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;
  const NoteTile({
    super.key,
    required this.text,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 0, left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          text,
          style: const TextStyle(fontFamily: 'Poppins'),
        ),
        tileColor: Theme.of(context).colorScheme.primary,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20)),
        trailing: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => showPopover(
              shadow: [
                BoxShadow(color: Theme.of(context).colorScheme.background)
              ],
              backgroundColor: Theme.of(context).colorScheme.background,
              height: 100,
              width: 100,
              context: context,
              bodyBuilder: (context) => NoteSetting(
                onEditTap: onEditPressed,
                onDeleteTap: onDeletePressed,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
