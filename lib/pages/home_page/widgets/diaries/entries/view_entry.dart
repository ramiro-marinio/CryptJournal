import 'package:cryptjournal/models/entry.dart';
import 'package:cryptjournal/utils/functions/format_date.dart';
import 'package:flutter/material.dart';

class ViewEntry extends StatelessWidget {
  final Entry entry;
  const ViewEntry({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View \'${entry.title}\''),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Created ${formatDate(entry.createdAt)}\nLast Updated ${formatDate(entry.updatedAt)}',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Divider(),
              Text(
                entry.body,
              )
            ],
          ),
        ),
      ),
    );
  }
}
