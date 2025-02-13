import 'package:cryptjournal/models/diary.dart';
import 'package:cryptjournal/models/entry.dart';
import 'package:cryptjournal/pages/home_page/widgets/diaries/create_entry/create_entry.dart';
import 'package:cryptjournal/providers/db_provider.dart';
import 'package:cryptjournal/utils/functions/format_date.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class ViewEntry extends StatelessWidget {
  final Entry entry;
  final Diary diary;
  const ViewEntry({
    super.key,
    required this.entry,
    required this.diary,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View \'${entry.title}\''),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ModifyEntry(
                      diary: diary,
                      entry: entry,
                    );
                  },
                ),
              );
            },
            icon: Icon(
              PhosphorIcons.pen(),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Created ${formatDate(entry.createdAt)}\nLast Updated ${formatDate(entry.updatedAt)}',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Divider(),
              Text(
                entry.body,
              )
            ],
          ),
        ),
      ),
    );
  }
}
