import 'package:flutter/material.dart';
import 'package:ibm_informix_code_dictionary/services/db_provider.dart';
import 'package:ibm_informix_code_dictionary/widgets/code_view.dart';
import 'package:translator/translator.dart';

import 'models/status_code.dart';

final controller = PageController(initialPage: 1);

class CodeViewPage extends StatelessWidget {
  final int id;
  CodeViewPage(this.id);
  final translator = GoogleTranslator();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StatusCode>(
      future: DBProvider.db.getCode(id),
      builder: (BuildContext context, AsyncSnapshot<StatusCode> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Status code: ${snapshot.data.code}"),
            ),
            body: CodeViewWidget(snapshot.data),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
