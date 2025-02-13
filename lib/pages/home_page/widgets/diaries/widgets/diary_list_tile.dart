import 'package:cryptjournal/models/diary.dart';
import 'package:cryptjournal/pages/home_page/widgets/diaries/modify_diary/modify_diary.dart';
import 'package:cryptjournal/pages/home_page/widgets/diaries/view_diary/view_diary.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DiaryListTile extends StatelessWidget {
  final Diary diary;
  const DiaryListTile({
    super.key,
    required this.diary,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ViewDiary(diary: diary);
          },
        ));
      },
      leading: Icon(PhosphorIcons.book()),
      title: Text(diary.name),
      trailing: DropdownButton(
        onChanged: (option) {
          if (option == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ModifyDiary(
                    diary: diary,
                  );
                },
              ),
            );
          }
        },
        items: [
          DropdownMenuItem(
            value: 1,
            child: Text('Edit'),
          ),
          DropdownMenuItem(
            value: 0,
            child: Text('Delete'),
          )
        ],
        icon: Icon(
          PhosphorIcons.dotsThreeVertical(),
        ),
      ),
    );
  }
}
