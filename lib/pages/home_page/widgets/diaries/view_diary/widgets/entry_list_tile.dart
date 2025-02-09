import 'package:cryptjournal/models/entry.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EntryListTile extends StatelessWidget {
  final Entry entry;
  const EntryListTile({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: Icon(PhosphorIcons.note()),
      title: Text(entry.title),
      trailing: DropdownButton(
        items: [
          DropdownMenuItem(
            child: Text('Edit'),
            value: 0,
          ),
          DropdownMenuItem(
            child: Text('Delete'),
            value: 0,
          ),
        ],
        onChanged: (value) {},
      ),
    );
  }
}
