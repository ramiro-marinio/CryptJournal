import 'package:cryptjournal/models/diary.dart';
import 'package:cryptjournal/pages/home_page/widgets/diaries/modify_diary/modify_diary.dart';
import 'package:cryptjournal/pages/home_page/widgets/diaries/widgets/diary_list_tile.dart';
import 'package:cryptjournal/providers/functionality_provider.dart';
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
    final FunctionalityProvider dbProvider =
        context.watch<FunctionalityProvider>();
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
                      builder: (context) => const ModifyDiary(),
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
            future: dbProvider.diaryTable.list(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    ...ListTile.divideTiles(
                      color: Colors.white,
                      tiles: snapshot.data!.map((element) {
                        return DiaryListTile(
                          diary: Diary.fromJson(element),
                        );
                      }),
                    )
                  ],
                );
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
