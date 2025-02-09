import 'package:cryptjournal/models/diary.dart';
import 'package:cryptjournal/providers/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateDiary extends StatefulWidget {
  const CreateDiary({super.key});

  @override
  State<CreateDiary> createState() => _CreateDiaryState();
}

class _CreateDiaryState extends State<CreateDiary> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final DbProvider dbProvider = context.read<DbProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('New Diary'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(hintText: 'Name'),
                        controller: nameController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(hintText: 'Description'),
                        controller: descriptionController,
                        maxLines: 6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 150,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await dbProvider.diaryTable.create(
                        object: Diary(
                          id: null,
                          name: nameController.text,
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        ).toJson(),
                      );
                      if (context.mounted) Navigator.pop(context);
                    },
                    child: Text('Create'),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
