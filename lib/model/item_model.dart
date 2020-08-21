import 'package:flutter/material.dart';

class ItemModel {
  int id;
  String name;
  int price;
  Color color;
  int count;

  ItemModel({this.id, this.name, this.price, this.color, this.count});
}

List<ItemModel> listItem = [
  ItemModel(
      id: 1, name: 'product1', price: 100, color: Colors.yellow, count: 0),
  ItemModel(id: 2, name: 'product2', price: 200, color: Colors.red, count: 0),
  ItemModel(id: 3, name: 'product3', price: 300, color: Colors.green, count: 0),
  ItemModel(id: 4, name: 'product4', price: 400, color: Colors.blue, count: 0),
  ItemModel(id: 5, name: 'product5', price: 500, color: Colors.pink, count: 0),
  ItemModel(
      id: 6, name: 'product6', price: 600, color: Colors.redAccent, count: 0),
  ItemModel(
      id: 7, name: 'product7', price: 700, color: Colors.tealAccent, count: 0),
  ItemModel(
    id: 8,
    name: 'product8',
    price: 800,
    color: Colors.purpleAccent,
  ),
  ItemModel(id: 9, name: 'product9', price: 900, color: Colors.teal),
];
