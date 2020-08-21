import 'package:equatable/equatable.dart';

import '../../model/item_model.dart';

abstract class CartState extends Equatable {
  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {}

class CartError extends CartState {}

class CartLoaded extends CartState {
  final List<ItemModel> listReception;
  CartLoaded({this.listReception});

  int get totalPrice =>
      listReception.fold(0, (total, current) => total + current.price);
  int get totalCount =>
      listReception.fold(0, (total, current) => total + current.count);
  @override
  List<Object> get props => [listReception];
}
