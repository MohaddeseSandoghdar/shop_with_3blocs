import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/item_model.dart';
import 'item_bloc_state.dart';

enum CounterEvent {
  /// Notifies bloc to increment state.
  increment,

  /// Notifies bloc to decrement state.
  decrement
}

class ItemBloc extends Bloc<CounterEvent, ItemBlocState> {
  final ItemModel itemCartModel;
  ItemBloc(this.itemCartModel);

  @override
  ItemBlocState get initialState => ItemBlocSuccess(itemModel: itemCartModel);

  @override
  Stream<ItemBlocState> mapEventToState(CounterEvent event) async* {
    if (event == CounterEvent.increment) {
      yield ItemBlocLoading();
      try {
        await Future.delayed(Duration(seconds: 1));
        ++itemCartModel.count;
        yield ItemBlocSuccess(itemModel: itemCartModel);
      } catch (_) {}
    } else if (event == CounterEvent.decrement) {
      yield ItemBlocLoading();
      try {
        await Future.delayed(Duration(seconds: 1));
        --itemCartModel.count;
        yield ItemBlocSuccess(itemModel: itemCartModel);
      } catch (_) {}

  
    }
  }
}
