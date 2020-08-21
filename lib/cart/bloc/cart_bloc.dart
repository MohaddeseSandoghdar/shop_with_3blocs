import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bloc_test/cart/bloc/cart_event.dart';
import 'package:shop_bloc_test/cart/bloc/cart_state.dart';

import '../../model/item_model.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<ItemModel> listReception = [];
  @override
  CartState get initialState => CartLoading();

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is LoadCart) {
      yield CartLoading();
      try {
        yield CartLoaded(listReception: []);
      } catch (_) {
        yield CartError();
      }
    } else if (event is AddItem) {
      final currentState = state;
      if (currentState is CartLoaded) {
        // yield CartLoading();
        try {
          listReception = currentState.listReception..add(event.item);
          yield CartLoaded(listReception: listReception);
        } catch (_) {
          yield CartError();
        }
      }
    } else if (event is DecreaseItem) {
      final currentState = state;
      if (currentState is CartLoaded) {
        // yield CartLoading();
        try {
          var index = currentState.listReception
              .indexWhere((item) => item.id == event.item.id);
          if (index < 0) {
            yield CartLoaded(listReception: currentState.listReception);
          } else {
            currentState.listReception[index].count -= 1;
            yield CartLoaded(listReception: currentState.listReception);
          }
        } catch (_) {
          yield CartError();
        }
      }
    }
  }
}
