import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ibm_informix_code_dictionary/code_view_page.dart';
import 'package:ibm_informix_code_dictionary/models/status_code.dart';
import 'package:ibm_informix_code_dictionary/services/db_provider.dart';

import 'models/status_code.dart';
import 'widgets/code_list_tile.dart';
import 'models/status_code_list_item.dart';

class DictionaryHomePage extends StatefulWidget {
  DictionaryHomePage({Key key, this.title}) : super(key: key);

  final String title;
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
        leading: _isSearching
            ? IconButton(
                tooltip: "Назад",
                icon: Icon(Icons.arrow_back),
                onPressed: _stopSearching,
              )
            : null,
        title: _isSearching ? _buildSearchField() : Text(widget.title),
        actions: _buildActions(),
      ),
      body: FutureBuilder<List<StatusCodeListItem>>(
        future: DBProvider.db.getList(searchQuery),
        builder: (BuildContext context,
            AsyncSnapshot<List<StatusCodeListItem>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  var statusCode = snapshot.data[index];
                  print("Build $index item");
                  return CodeListTile(
                    statusCode: statusCode,
                    onPress: _selectCode(statusCode),
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Function _selectCode(StatusCodeListItem statusCode) {
    return () async {
      await Navigator.push(context,
          MaterialPageRoute(builder: (context) => CodeViewPage(statusCode.id)));
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
      _searchQuery.clear();
      searchQuery = "";
    });
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
          tooltip: "Очистить",
          icon: const Icon(Icons.clear),
          onPressed: () {
            setState(() {
              if (this._searchQuery.text.isNotEmpty) {
                _searchQuery.clear();
                searchQuery = "";
              } else {
                _isSearching = false;
              }
            });
          },
        ),
      ];
    }

    return <Widget>[
      new IconButton(
        tooltip: "Поиск",
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  void _startSearch() {
    print("open search box");
    setState(() {
      _isSearching = true;
    });
  }
}
