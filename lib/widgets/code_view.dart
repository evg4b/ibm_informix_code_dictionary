import 'package:flutter/material.dart';

class CodeViewWidget extends StatelessWidget {
  final String label;
  final String title;
  final String description;

  CodeViewWidget({this.label, this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: Text("${this.label}: ${this.title}",
              style: Theme.of(context)
                  .textTheme
                  .display1
                  .apply(color: Colors.black)),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
          child: Text(
            this.description,
            style: Theme.of(context).textTheme.body1,
          ),
        ),
      ],
    );
  }
}
