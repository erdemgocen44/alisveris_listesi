import 'dart:async';

import 'package:alisveris_listesi/http/item_service.dart';
import 'package:alisveris_listesi/model/item.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  StreamController<List<Item>> _streamController = StreamController();
  ItemService _itemService;
  final ScrollController _controller = ScrollController();
  int _currentPage = 0;
  List<Item> _items = [];

  @override
  void initState() {
    _itemService = ItemService();

    _fetchArchive(_currentPage);

    _controller.addListener(_onScrolled);

    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  Future<void> _fetchArchive(int page) async {
    int take = 20;

    var items = await _itemService.fetchArchive(20, take * page);

    _items.addAll(items);

    _streamController.add(_items);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          title: Text("Shopping List History"),
        ),
        Expanded(
          child: StreamBuilder<List<Item>>(
              stream: _streamController.stream,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Center(child: CircularProgressIndicator());
                    break;
                  case ConnectionState.active:
                  case ConnectionState.done:
                    if (snapshot.data.length != 0)
                      return Center(
                        child: Container(
                          child: Text(
                            "Archive is Empty!",
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    return ListView.builder(
                      controller: _controller,
                      padding: EdgeInsets.all(0),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item = snapshot.data[index];

                        return ListTile(title: Text(item.name));
                      },
                    );
                    break;
                  default:
                    return Container();
                    break;
                }
              }),
        )
      ],
    );
  }

  void _onScrolled() {
    if (_controller.position.maxScrollExtent == _controller.position.pixels) {
      _currentPage += 1;

      _fetchArchive(_currentPage);
    }
  }
}
