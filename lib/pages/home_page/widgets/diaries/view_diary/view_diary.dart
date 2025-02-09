import 'package:cryptjournal/models/diary.dart';
import 'package:cryptjournal/models/entry.dart';
import 'package:cryptjournal/pages/home_page/widgets/diaries/view_diary/widgets/entry_list_tile.dart';
import 'package:cryptjournal/providers/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewDiary extends StatefulWidget {
  final Diary diary;
  const ViewDiary({
    super.key,
    required this.diary,
  });

  @override
  State<ViewDiary> createState() => _ViewDiaryState();
}

class _ViewDiaryState extends State<ViewDiary> {
  Future<List<Map<String, dynamic>>>? getEntries;
  @override
  Widget build(BuildContext context) {
    final DbProvider dbProvider = context.watch<DbProvider>();
    getEntries ??=
        dbProvider.entryTable.list(where: 'diary_id=${widget.diary.id!}');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.diary.name),
      ),
      body: FutureBuilder(
          future: getEntries!,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            final entries = snapshot.data!.map((entry) {
              return Entry.fromJson(entry);
            });
            return ListView(
              children: ListTile.divideTiles(
                tiles: entries.map(
                  (entry) => EntryListTile(
                    entry: entry,
                  ),
                ),
              ).toList(),
            );
          }),
    );
  }
}
