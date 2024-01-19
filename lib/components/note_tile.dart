import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:notes_app/components/note_setting.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
        title: Text(text),
        tileColor: Theme.of(context).colorScheme.secondary,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20)),
        trailing: Builder(
          builder: (context) => Animate(
            effects: const [
              SlideEffect(),
            ],
            child: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => showPopover(
                backgroundColor: Theme.of(context).focusColor,
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
      ),
    );
  }
}
