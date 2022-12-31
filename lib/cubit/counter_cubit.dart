import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState(score: 0, questionIndex: 0));

  void incrementScore() => emit(
      CounterState(score: state.score + 1, questionIndex: state.questionIndex));

  void incrementQuestionIndex() => emit(
      CounterState(score: state.score, questionIndex: state.questionIndex + 1));
}
