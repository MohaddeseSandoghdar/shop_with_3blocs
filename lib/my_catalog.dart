import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bloc_test/cart/bloc/cart_bloc.dart';
import 'package:shop_bloc_test/cart/bloc/cart_event.dart';
import 'package:shop_bloc_test/catalog/bloc/catalog_bloc.dart';
import 'package:shop_bloc_test/catalog/bloc/catalog_state.dart';
import 'package:shop_bloc_test/item/bloc/item_bloc_state.dart';

import 'item/bloc/item_bloc.dart';

class MyCatalog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyCatalogState();
}

class MyCatalogState extends State<MyCatalog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.shopping_basket),
                onPressed: () => Navigator.pushNamed(context, '/cart'))
          ],
        ),
        body: Container(child: BlocBuilder<CatalogBloc, CatalogState>(
          builder: (context, state) {
            if (state is CatalogLoading)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (state is CatalogLoaded)
              return ListView.builder(
                itemCount: state.catolog.length,
                itemBuilder: (BuildContext context, int index) {
                  return BlocProvider(
                      create: (context) => ItemBloc(state.catolog[index]),
                      child: CatalogItem());
                  // CatalogItem(state.catolog[index]);
                },
              );
            return Text('محصولی وجود ندارد.');
          },
        )));
  }
}

class CatalogItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CatalogItemState();
}

class CatalogItemState extends State<CatalogItem> {
  TextEditingController countCtr = TextEditingController();
  CartBloc _cartBloc;
  ItemBloc _itemBloc;
  @override
  void initState() {
    _cartBloc = BlocProvider.of<CartBloc>(context);
    _itemBloc = BlocProvider.of<ItemBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(40),
      color: _itemBloc.itemCartModel.color,
      child: Column(
        children: <Widget>[
          Text(_itemBloc.itemCartModel.name),
          SizedBox(height: 20),
          Text(_itemBloc.itemCartModel.price.toString()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 55,
                height: 55,
                child: OutlineButton(
                  onPressed: () {
                     _itemBloc.add(CounterEvent.decrement);
                  },
                  child: Icon(Icons.remove),
                ),
              ),
              Container(
                  width: 50,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: BlocBuilder<ItemBloc, ItemBlocState>(
                    builder: (context, state) {
                      if (state is ItemBlocLoading) {
                        return CircularProgressIndicator();
                      }
                      if (state is ItemBlocSuccess) {
                        return Text(
                          '${state.itemModel.count}',
                          textAlign: TextAlign.center,
                        );
                      }
                      return Text('');
                    },
                  )),
              Container(
                width: 55,
                height: 55,
                child: OutlineButton(
                  onPressed: () {
                    _itemBloc.add(CounterEvent.increment);
                    var index = _cartBloc.listReception
                        .indexWhere((x) => x.id == _itemBloc.itemCartModel.id);
                    if (index < 0) {
                      _cartBloc.add(AddItem(_itemBloc.itemCartModel));
                    }
                  },
                  child: Icon(Icons.add),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
