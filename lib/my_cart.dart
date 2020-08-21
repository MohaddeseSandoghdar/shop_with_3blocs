import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bloc_test/cart/bloc/cart_bloc.dart';
import 'package:shop_bloc_test/cart/bloc/cart_state.dart';
import 'package:shop_bloc_test/model/item_model.dart';

import 'item/bloc/item_bloc.dart';
import 'item/bloc/item_bloc_state.dart';

class MyCart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyCartState();
}

class MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Container(
        color: Colors.yellow,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: CartList(),
              ),
            ),
            Divider(height: 4, color: Colors.black),
            _CartTotal()
          ],
        ),
      ),
    );
  }
}

class CartList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CartListState();
}

class CartListState extends State<CartList> {
  CartBloc _cartBloc;
  ItemModel itemModel = ItemModel();

  @override
  void initState() {
    _cartBloc = BlocProvider.of<CartBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return CircularProgressIndicator();
        }
        if (state is CartLoaded) {
          return ListView.builder(
              itemCount: state.listReception.length,
              itemBuilder: (context, index) {
                return BlocProvider(
                  create: (context) => ItemBloc(state.listReception[index]),
                  child: ItemCart(),
                );
              });
        }
        return Text('Something went wrong!');
      },
    );
  }
}

class ItemCart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ItemCartState();
}

class ItemCartState extends State<ItemCart> {
  ItemBloc itemBloc;
  @override
  void initState() {
    itemBloc = BlocProvider.of<ItemBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final itemNameStyle = Theme.of(context).textTheme.headline6;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 150,
            child: Text(
              itemBloc.itemCartModel.name,
              style: itemNameStyle,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                child: OutlineButton(
                  onPressed: () {
                    itemBloc.add(CounterEvent.decrement);
                  },
                  child: Icon(Icons.remove),
                ),
              ),
              Container(
                width: 30,
                child: BlocBuilder<ItemBloc, ItemBlocState>(
                  builder: (context, state) {
                    if (state is ItemBlocLoading) {
                      return CircularProgressIndicator();
                    }
                    if (state is ItemBlocSuccess) {
                      return Text(
                        '${itemBloc.itemCartModel.count.toInt()},',
                        textAlign: TextAlign.center,
                      );
                    }
                    return Text('1');
                  },
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: OutlineButton(
                  onPressed: () {
                    itemBloc.add(CounterEvent.increment);
                  },
                  child: Icon(Icons.add),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<CartBloc, CartState>(builder: (context, state) {
              if (state is CartLoading) {
                return CircularProgressIndicator();
              }
              if (state is CartLoaded) {
                return Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          '${state.totalPrice}',
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '${state.totalCount}',
                        )
                      ],
                    )
                  ],
                );
              }
              return Text('Something went wrong!');
            }),
            SizedBox(width: 24),
            FlatButton(
              onPressed: () {
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('Buying not supported yet.')));
              },
              color: Colors.white,
              child: Text('BUY'),
            ),
          ],
        ),
      ),
    );
  }
}
