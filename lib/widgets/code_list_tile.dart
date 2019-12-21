import 'package:flutter/material.dart';

import '../models/status_code_list_item.dart';

class CodeListTile extends StatelessWidget {
  final StatusCodeListItem statusCode;
  final Function onPress;

  CodeListTile({@required this.statusCode, @required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {},
        child: ListTile(
          title: Text("Status code: ${this.statusCode.code}"),
          subtitle: Text(this.statusCode.description),
        ),
        onTapDown: (details) {
          this.onPress();
        },
      ),
    );
  }
}
