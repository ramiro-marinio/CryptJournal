import 'package:cryptjournal/models/diary.dart';
import 'package:cryptjournal/providers/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModifyDiary extends StatefulWidget {
  final Diary? diary;
  const ModifyDiary({
    super.key,
    this.diary,
  });

  @override
  State<ModifyDiary> createState() => _ModifyDiaryState();
}

class _ModifyDiaryState extends State<ModifyDiary> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.diary?.name ?? '';
    descriptionController.text = widget.diary?.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final DbProvider dbProvider = context.read<DbProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.diary == null
            ? 'New Diary'
            : 'Edit Diary \'${widget.diary!.name}\''),
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
                      final result = Diary(
                        id: null,
                        name: nameController.text,
                        createdAt: widget.diary == null
                            ? DateTime.now()
                            : widget.diary!.createdAt,
                        updatedAt: DateTime.now(),
                      ).toJson();
                      if (widget.diary == null) {
                        await dbProvider.diaryTable.create(object: result);
                      } else {
                        await dbProvider.diaryTable.update(
                          object: result,
                          where: 'id=${widget.diary!.id!}',
                        );
                      }
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
