import 'package:flutter/material.dart';
import 'package:ibm_informix_code_dictionary/models/status_code.dart';
import 'package:ibm_informix_code_dictionary/services/translation_service.dart';


class CodeViewWidget extends StatefulWidget {
  final StatusCode code;

  CodeViewWidget(this.code);
  
  @override
  _CodeViewWidgetState createState() => _CodeViewWidgetState(this.code);
}

class _CodeViewWidgetState extends State<CodeViewWidget> {
  final StatusCode code;
  bool _translate = false;

  _CodeViewWidgetState(this.code);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildHeaderRow(),
        ... _translate
          ? _buildTranslatedView()
          : _buildOriginalView()
        ,
      ],
    );
  }

  List<Widget> _buildOriginalView() {
    return <Widget>[
      _boldText(this.code.shortDescription),
      _regularText(this.code.description)
    ];
  }

  List<Widget> _buildTranslatedView() {
    return <Widget>[
      FutureBuilder<String> (
        future: TranslationService.engine.translate(this.code.shortDescription),
        initialData: "Loading..",
        builder: (context, snapshot) => snapshot.hasError
          ? _boldText("Translation error")
          : _boldText(snapshot.data),
      ),
      FutureBuilder<String> (
        future: TranslationService.engine.translate(this.code.description),
        initialData: "Loading..",
        builder: (context, snapshot) => snapshot.hasError
          ? _regularText("Translation error")
          : _regularText(snapshot.data),
      )
    ];
  }

  Widget _boldText(String text) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: Text(text,
        style: Theme.of(context)
            .textTheme
            .headline
      )
    );
  }

  Widget _regularText(String text) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
      child: Text(text,
        style: Theme.of(context).textTheme.body1,
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: Text("Code: ${this.code.code}",
          style: Theme.of(context)
            .textTheme
            .display1
            .apply(color: Colors.black)),
        ),
        IconButton(
          tooltip: "Change language",
          icon: Icon(
            Icons.translate,
            color: Colors.orangeAccent,
          ),
          onPressed: () {
            setState(() {
              _translate = !_translate;
            });
          }
        )
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}