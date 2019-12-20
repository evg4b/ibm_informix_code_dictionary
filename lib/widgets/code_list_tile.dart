import 'package:flutter/material.dart';

import '../models/status_code_list_item.dart';

class CodeListTile extends StatelessWidget {
  final StatusCodeListItem statusCode;
  final Function onPress;

  CodeListTile({@required this.statusCode, @required this.onPress});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "Статус код: ${this.statusCode.codes}",
        style: Theme.of(context).textTheme.headline,
      ),
      subtitle: Text(this.statusCode.description),
      onTap: this.onPress,
    );
  }
}
