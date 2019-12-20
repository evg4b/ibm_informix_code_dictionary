import 'package:flutter/material.dart';

import 'models/status_code.dart';

final controller = PageController(initialPage: 1);

class CodeViewPage extends StatelessWidget {
  StatusCode statusCode;
  CodeViewPage({this.statusCode});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(this.statusCode.descriptionRus),
          bottom: TabBar(
            tabs: [
              Tab(text: "Русский"),
              Tab(text: "Англйский"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Icon(Icons.directions_transit),
            Icon(Icons.directions_transit),
          ],
        ),
      ),
    );
  }
}
