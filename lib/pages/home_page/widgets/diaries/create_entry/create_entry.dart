import 'package:cryptjournal/models/diary.dart';
import 'package:cryptjournal/models/entry.dart';
import 'package:cryptjournal/providers/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateEntry extends StatefulWidget {
  final Diary diary;
  const CreateEntry({
    super.key,
    required this.diary,
  });

  @override
  State<CreateEntry> createState() => _CreateEntryState();
}

class _CreateEntryState extends State<CreateEntry> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final DbProvider dbProvider = context.read<DbProvider>();
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New entry on \'${widget.diary.name}\'',
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
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        );
                        await dbProvider.entryTable
                            .create(object: result.toJson());
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
