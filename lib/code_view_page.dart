import 'package:flutter/material.dart';
import 'package:ibm_informix_code_dictionary/widgets/code_view.dart';

import 'models/status_code.dart';

final controller = PageController(initialPage: 1);

class CodeViewPage extends StatelessWidget {
  final StatusCode statusCode;
  CodeViewPage({this.statusCode});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(this.statusCode.shortDescriptionRus),
          bottom: TabBar(
            tabs: [
              Tab(text: "Русский"),
              Tab(text: "Англйский"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CodeViewWidget(
              label: "Код",
              title: this.statusCode.shortDescriptionRus,
              description: this.statusCode.descriptionRus,
            ),
            CodeViewWidget(
              label: "Code",
              title: this.statusCode.shortDescriptionEng,
              description: this.statusCode.descriptionEng,
            ),
          ],
        ),
      ),
    );
  }
}
