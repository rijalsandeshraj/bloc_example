part of 'counter_cubit.dart';

class CounterState extends Equatable {
  final int counterValue;
  final bool? isIncremented;

  const CounterState({
    required this.counterValue,
    this.isIncremented,
  });

  @override
  List<Object?> get props => [counterValue, isIncremented];
}
