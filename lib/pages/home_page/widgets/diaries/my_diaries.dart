import 'dart:convert';
import 'package:cryptjournal/pages/home_page/widgets/diaries/create_diary.dart';
import 'package:cryptjournal/providers/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class MyDiaries extends StatefulWidget {
  const MyDiaries({super.key});

  @override
  State<MyDiaries> createState() => _MyDiariesState();
}

class _MyDiariesState extends State<MyDiaries> {
  @override
  Widget build(BuildContext context) {
    final DbProvider dbProvider = context.read<DbProvider>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Diaries',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateDiary(),
                    ),
                  );
                },
                icon: Icon(
                  PhosphorIcons.plus(),
                ),
              )
            ],
          ),
          FutureBuilder(
            future: dbProvider.entryTable.list(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text('Data loaded');
              } else {
                return CircularProgressIndicator();
              }
            },
          )
        ],
      ),
    );
  }
}
