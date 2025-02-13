import 'package:cryptjournal/models/diary.dart';
import 'package:cryptjournal/models/entry.dart';
import 'package:cryptjournal/providers/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModifyEntry extends StatefulWidget {
  final Diary diary;
  final Entry? entry;
  const ModifyEntry({
    super.key,
    required this.diary,
    this.entry,
  });

  @override
  State<ModifyEntry> createState() => _ModifyEntryState();
}

class _ModifyEntryState extends State<ModifyEntry> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.entry?.title ?? '';
    bodyController.text = widget.entry?.body ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final DbProvider dbProvider = context.read<DbProvider>();
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.entry == null ? 'New entry' : 'Edit \'${widget.entry!.title}\''} on \'${widget.diary.name}\'',
        ),
      ),
      body: SizedBox(
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Entry Title',
                        ),
                        controller: titleController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        maxLines: 10,
                        decoration: InputDecoration(hintText: 'Entry Body'),
                        controller: bodyController,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 200,
                child: Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final result = Entry(
                          diaryId: widget.diary.id!,
                          title: titleController.text,
                          body: bodyController.text,
                          createdAt: widget.entry == null
                              ? DateTime.now()
                              : widget.entry!.createdAt,
                          updatedAt: DateTime.now(),
                        );
                        if (widget.entry == null) {
                          await dbProvider.entryTable
                              .create(object: result.toJson());
                        } else {
                          await dbProvider.entryTable.update(
                            object: result.toJson(),
                            where: 'id=${widget.entry!.id!}',
                          );
                        }
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                      child: Text('Create Entry'),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
