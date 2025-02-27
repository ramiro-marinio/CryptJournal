import 'package:cryptjournal/models/diary.dart';
import 'package:cryptjournal/models/entry.dart';
import 'package:cryptjournal/pages/home_page/widgets/diaries/entries/view_entry.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EntryListTile extends StatelessWidget {
  final Entry entry;
  final Diary diary;
  const EntryListTile({
    super.key,
    required this.entry,
    required this.diary,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ViewEntry(
              providedEntry: entry,
              diary: diary,
            );
          },
        ));
      },
      leading: Icon(PhosphorIcons.note()),
      title: Text(entry.title),
      trailing: DropdownButton(
        items: [
          DropdownMenuItem(
            value: 0,
            child: Text('Edit'),
          ),
          DropdownMenuItem(
            value: 0,
            child: Text('Delete'),
          ),
        ],
        onChanged: (value) {},
      ),
    );
  }
}
