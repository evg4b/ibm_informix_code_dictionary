import 'package:flutter/material.dart';
import 'package:ibm_informix_code_dictionary/code_view_page.dart';
import 'package:ibm_informix_code_dictionary/models/status_code.dart';

import 'widgets/code_list_tile.dart';
import 'models/status_code_list_item.dart';

class DictionaryHomePage extends StatefulWidget {
  DictionaryHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DictionaryHomePageState createState() => _DictionaryHomePageState();
}

class _DictionaryHomePageState extends State<DictionaryHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView.builder(
        itemCount: 9000,
        itemBuilder: (context, index) {
          var statusCode = StatusCodeListItem(
              codes: "$index",
              description: "Descriptio nof $index"
          );
          return CodeListTile(
              statusCode: statusCode,
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CodeViewPage(
                            statusCode: StatusCode(
                              code: statusCode.codes, 
                              descriptionRus: "dklsfjdsfjlsdfkdklsfjdsfjlsdfkdklsfjdsfjlsdfkdklsfjdsfjlsdfkdklsfjdsfjlsdfkdklsfjdsfjlsdfkdklsfjdsfjlsdfkdklsfjdsfjlsdfkdklsfjdsfjlsdfkdklsfjdsfjlsdfkdklsfjdsfjlsdfkdklsfjdsfjlsdfkdklsfjdsfjlsdfkdklsfjdsfjlsdfkdklsfjdsfjlsdfkdklsfjdsfjlsdfkdklsfjdsfjlsdfkdklsfjdsfjlsdfkdklsfjdsfjlsdfkdklsfjdsfjlsdfkdklsfjdsfjlsdfkdklsfjdsfjlsdfkdklsfjdsfjlsdfkdklsfjdsfjlsdfkdklsfjdsfjlsdfkdklsfjdsfjlsdfkdklsfjdsfjlsdfkdklsfjdsfjlsdfkdklsfjdsfjlsdfkdklsfjdsfjlsdfkdklsfjdsfjlsdfkdklsfjdsfjlsdfk"
                            ),
                        )
                    )
                );
              });
        },
      ),
    );
  }
}
