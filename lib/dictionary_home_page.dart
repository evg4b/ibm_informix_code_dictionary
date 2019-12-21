import 'package:flutter/material.dart';
import 'package:ibm_informix_code_dictionary/code_view_page.dart';
import 'package:ibm_informix_code_dictionary/services/db_provider.dart';
import 'package:infinite_widgets/infinite_widgets.dart';

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

  List<StatusCodeListItem> _data = [];

  @override
  void initState() {
    super.initState();
    _data = new List<StatusCodeListItem>();
    _searchQuery = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _isSearching
            ? IconButton(
                tooltip: "Back",
                icon: Icon(Icons.arrow_back),
                onPressed: _stopSearching,
              )
            : null,
        title: _isSearching ? _buildSearchField() : Text(widget.title),
        actions: _buildActions(),
      ),
      body: FutureBuilder<int>(
        future: DBProvider.db.count(searchQuery),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == 0) {
              return Center(child: Text("Nothing found", style: Theme.of(context).textTheme.caption));
            }
            return InfiniteListView.separated(
              itemBuilder: (context, index) {
                var statusCode = _data[index];
                return CodeListTile(
                  statusCode: statusCode,
                  onPress: _selectCode(statusCode),
                );
              },
              itemCount: _data.length,
              hasNext: _data.length < snapshot.data,
              nextData: this.loadNextData,
              separatorBuilder: (context, index) => Divider(height: 1),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  loadNextData() {
    DBProvider.db.getList(searchQuery, _data.length)
      .then((newItems) {
        _data.addAll(newItems);
        setState(() {});
      });
  }

  Function _selectCode(StatusCodeListItem statusCode) {
    return () async {
      await Navigator.push(context,
          MaterialPageRoute(builder: (context) => CodeViewPage(statusCode.id)));
    };
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      _data.clear();
      searchQuery = newQuery;
    });
  }

  void _stopSearching() {
    setState(() {
      _isSearching = false;
      _searchQuery.clear();
      _data.clear();
      searchQuery = "";
    });
  }

  Widget _buildSearchField() {
    return new TextField(
      controller: _searchQuery,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Search...',
        border: InputBorder.none,
        hintStyle: const TextStyle(color: Colors.white54),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: updateSearchQuery,
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        new IconButton(
          tooltip: "Clear",
          icon: const Icon(Icons.clear),
          onPressed: () {
            setState(() {
              if (this._searchQuery.text.isNotEmpty) {
                _searchQuery.clear();
                _data.clear();
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
        tooltip: "Search",
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  void _startSearch() {
    setState(() { _isSearching = true; });
  }
}
