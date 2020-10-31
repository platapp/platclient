import 'package:bloc/bloc.dart';

/// {@template counter_cubit}
/// A [Cubit] which manages an [int] as its state.
/// {@endtemplate}
class BottomNavCubit extends Cubit<int> {
  /// {@macro counter_cubit}
  BottomNavCubit() : super(0);

  /// Add 1 to the current state.
  void setIndex(int index) => emit(index);
}
