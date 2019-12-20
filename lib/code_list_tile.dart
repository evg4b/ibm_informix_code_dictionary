import 'package:flutter/material.dart';
import 'package:ibm_informix_code_dictionary/status_code.dart';

class CodeListTile extends StatelessWidget {
  StatusCode statusCode;

  CodeListTile(this.statusCode);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "Код ошбки: ${this.statusCode.codes}",
        style: Theme.of(context).textTheme.headline,
      ),
      subtitle: Text(this.statusCode.description),
      onTap: () {},
    );
  }
}
