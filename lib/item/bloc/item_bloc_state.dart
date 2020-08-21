import 'package:equatable/equatable.dart';

import '../../model/item_model.dart';

abstract class ItemBlocState extends Equatable {
  @override
  List<Object> get props => [];
}

class ItemBlocLoading extends ItemBlocState {}

class ItemBlocError extends ItemBlocState {}

class ItemBlocSuccess extends ItemBlocState {
  final ItemModel itemModel;
  ItemBlocSuccess({this.itemModel});
}
