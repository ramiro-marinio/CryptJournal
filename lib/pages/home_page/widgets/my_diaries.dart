import 'dart:convert';
import 'package:cryptjournal/providers/db_provider.dart';
import 'package:flutter/material.dart';
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
          Text(
            'My Diaries',
            style: Theme.of(context).textTheme.headlineSmall,
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
