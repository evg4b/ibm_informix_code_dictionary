import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ibm_informix_code_dictionary/code_view_page.dart';
import 'package:ibm_informix_code_dictionary/models/status_code.dart';

import 'models/status_code.dart';
import 'widgets/code_list_tile.dart';
import 'models/status_code_list_item.dart';

class DictionaryHomePage extends StatefulWidget {
  DictionaryHomePage({Key key, this.title}) : super(key: key);

  final String title;
  bool _isSearching;

  @override
  _DictionaryHomePageState createState() => _DictionaryHomePageState();
}

class _DictionaryHomePageState extends State<DictionaryHomePage> {

  TextEditingController _searchQuery;
  bool _isSearching = false;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _searchQuery = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _isSearching ? const BackButton() : null,
        title: _isSearching ? _buildSearchField() : Text(widget.title),
        actions: _buildActions(),
      ),
      body: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              var statusCode = StatusCodeListItem(
                  codes: "$index",
                  description: "Descriptio nof $index"
              );
              return CodeListTile(
                  statusCode: statusCode,
                  onPress:  _selectCode(statusCode),
              );
            }
          ),
      );
  }

  Function _selectCode(StatusCodeListItem statusCode) {
    return () async {
      await Navigator.push(
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
      _stopSearching();
    };
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
    print("search query " + newQuery);
  }

  void _stopSearching() {
    print("close search box");
    setState(() {
      _isSearching = false;
    });
    _clearSearchQuery();
  }

  Widget _buildSearchField() {
    return new TextField(
      controller: _searchQuery,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Поиск...',
        border: InputBorder.none,
        hintStyle: const TextStyle(color: Colors.white54),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: updateSearchQuery,
      onSubmitted: (data) {
        print(data);
      },
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        new IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQuery == null || _searchQuery.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      new IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  void _clearSearchQuery() {
    print("close search box");
    setState(() {
      _searchQuery.clear();
      updateSearchQuery("Search query");
    });
  }

  void _startSearch() {
    print("open search box");
    ModalRoute
        .of(context)
        .addLocalHistoryEntry(new LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }
}
