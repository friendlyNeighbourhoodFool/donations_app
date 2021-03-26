import 'package:flutter/material.dart';
import './ask_a_question.dart';
import './products_overview_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import './cart_screen.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      // initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Aabhar'),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favorites) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                });
              },
              icon: Icon(
                Icons.more_vert,
              ),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text('Only Favorites'),
                  value: FilterOptions.Favorites,
                ),
                PopupMenuItem(
                  child: Text('Show All'),
                  value: FilterOptions.All,
                ),
              ],
            ),
            Consumer<Cart>(
              builder: (_, cart, ch) => Badge(
                child: ch,
                value: cart.itemCount.toString(),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            ),
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.category,
                ),
                text: 'Main',
              ),
              Tab(
                icon: Icon(
                  Icons.chat_outlined,
                ),
                text: 'Ask A Question',
              ),
            ],
          ),
        ),
        drawer: AppDrawer(),
        body: TabBarView(
          children: <Widget>[
            ProductsOverviewScreen(),
            AskQuestion(),
          ],
        ),
      ),
    );
  }
}
