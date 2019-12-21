import 'package:flutter/material.dart';
import 'package:ibm_informix_code_dictionary/services/db_provider.dart';
import 'package:ibm_informix_code_dictionary/widgets/code_view.dart';

import 'models/status_code.dart';

final controller = PageController(initialPage: 1);

class CodeViewPage extends StatelessWidget {
  final int id;
  CodeViewPage(this.id);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StatusCode>(
      future: DBProvider.db.getClient(id),
      builder: (BuildContext context, AsyncSnapshot<StatusCode> snapshot) {
        if (snapshot.hasData) {
          return _buildTabs(snapshot);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  DefaultTabController _buildTabs(AsyncSnapshot<StatusCode> snapshot) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(snapshot.data.descriptionEng),
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
              title: snapshot.data.code,
              description: snapshot.data.descriptionRus,
            ),
            CodeViewWidget(
              label: "Code",
              title: snapshot.data.code,
              description: snapshot.data.descriptionEng,
            ),
          ],
        ),
      ),
    );
  }
}
