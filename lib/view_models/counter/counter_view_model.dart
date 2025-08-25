import 'package:counter_app/view_models/counter/counter_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterViewModel extends StateNotifier<CounterState> {
  CounterViewModel() : super(CounterState(0));

  void increment() => state = state.copyWith(value: state.value! + 1);

  void decrement() => state = state.copyWith(value: state.value! - 1);

  void reset() => state = state.copyWith(value: 0);
}

final counterViewModelProvider = StateNotifierProvider<CounterViewModel,CounterState>((ref) {
  return CounterViewModel();
});
