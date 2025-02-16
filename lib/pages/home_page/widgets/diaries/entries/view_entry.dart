import 'package:cryptjournal/models/diary.dart';
import 'package:cryptjournal/models/entry.dart';
import 'package:cryptjournal/pages/home_page/widgets/decoration/image_background.dart';
import 'package:cryptjournal/pages/home_page/widgets/diaries/modify_entry/modify_entry.dart';
import 'package:cryptjournal/providers/functionality_provider.dart';
import 'package:cryptjournal/utils/functions/format_date.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class ViewEntry extends StatefulWidget {
  final Entry providedEntry;
  final Diary diary;
  const ViewEntry({
    super.key,
    required this.providedEntry,
    required this.diary,
  });

  @override
  State<ViewEntry> createState() => _ViewEntryState();
}

class _ViewEntryState extends State<ViewEntry> {
  Entry? newEntry;

  @override
  Widget build(BuildContext context) {
    final FunctionalityProvider dbProvider =
        context.watch<FunctionalityProvider>();
    final Future<Entry> updateEntry = (() async {
      final entries = await dbProvider.entryTable.list(
        where: 'id=${widget.providedEntry.id!}',
      );
      return Entry.fromJson(entries[0]);
    })()
      ..then((e) {
        newEntry = null;
        setState(() {});
        newEntry = e;
        setState(() {});
      });
    return Scaffold(
      appBar: AppBar(
        title: newEntry != null
            ? Text('View \'${newEntry!.title}\'')
            : Center(
                child: CircularProgressIndicator.adaptive(),
              ),
        actions: [
          Builder(builder: (context) {
            if (newEntry == null) {
              return CircularProgressIndicator.adaptive();
            }
            return IconButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ModifyEntry(
                        diary: widget.diary,
                        entry: newEntry!,
                      );
                    },
                  ),
                );
              },
              icon: Icon(
                PhosphorIcons.pen(),
              ),
            );
          })
        ],
      ),
      body: GradientBackground(
        child: FutureBuilder(
            future: updateEntry,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Created ${formatDate(snapshot.data!.createdAt)}\nLast Updated ${formatDate(snapshot.data!.updatedAt)}',
                        style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.fontSize,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Divider(),
                      Expanded(
                        child: ListView(
                          children: [
                            Text(
                              snapshot.data!.body,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
            }),
      ),
    );
  }
}
