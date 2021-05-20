import 'package:alisveris_listesi/http/item_service.dart';
import 'package:alisveris_listesi/model/overview.dart';
import 'package:flutter/material.dart';

class ShoppingListMain extends StatefulWidget {
  @override
  _ShoppingListMainState createState() => _ShoppingListMainState();
}

class _ShoppingListMainState extends State<ShoppingListMain> {
  ItemService _itemService;

  @override
  void initState() {
    _itemService = ItemService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Text('Overview'),
        ),
        FutureBuilder(
          future: _itemService.overview(),
          builder: (BuildContext context, AsyncSnapshot<Overview> snapshot) {
            if (!snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: CircularProgressIndicator(
                  backgroundColor: Colors.pinkAccent,
                ),
              );
            }
            return Expanded(
              child: RefreshIndicator(
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: [
                      GridItem(
                        icon: Icons.shopping_bag,
                        title: 'Total Items',
                        total: snapshot.data.total,
                      ),
                      GridItem(
                        icon: Icons.add_shopping_cart,
                        title: 'Current Items',
                        total: snapshot.data.current,
                      ),
                      GridItem(
                        icon: Icons.history,
                        title: 'Completed Items',
                        total: snapshot.data.completed,
                      ),
                      GridItem(
                        icon: Icons.remove_shopping_cart,
                        title: 'Deleted Items',
                        total: snapshot.data.deleted,
                      ),
                    ],
                  ),
                  onRefresh: () async {
                    setState(() {});
                  }),
            );
          },
        ),
      ],
    );
  }
}

class GridItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final int total;

  const GridItem({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 15,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 60, color: Colors.lightBlue),
              SizedBox(
                height: 10,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                total.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
