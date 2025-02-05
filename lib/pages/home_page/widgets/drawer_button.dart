import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DrawerButton extends StatelessWidget {
  const DrawerButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        PhosphorIcons.list(),
      ),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }
}
