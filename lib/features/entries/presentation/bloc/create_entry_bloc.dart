import 'package:drift/native.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/usecases/create_entry_usecase.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/bloc/create_entry_event.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/bloc/create_entry_state.dart';

class CreateEntryBloc extends Bloc<CreateEntryEvent, CreateEntryState> {
  CreateEntryBloc(this._createEntryUsecase, this._fieldListId)
    : super(CreateEntryState()) {
    on<CreateEntryRankChanged>(_onRankChanged);
    on<CreateEntryQuestionChanged>(_onQuestionChanged);
    on<CreateEntryAnswerChanged>(_onAnswerChanged);
    on<CreateEntryOrderChanged>(_onOrderChanged);
    on<CreateEntrySubmitted>(_onSubmitted);
    on<CreateEntrySubscriptionRequested>(_onSubscriptionRequested);
  }
  final CreateEntryUsecase _createEntryUsecase;
  final String _fieldListId;

  void _onRankChanged(
    CreateEntryRankChanged event,
    Emitter<CreateEntryState> emit,
  ) {
    emit(state.copyWith(rank: event.rank));
  }

  void _onQuestionChanged(
    CreateEntryQuestionChanged event,
    Emitter<CreateEntryState> emit,
  ) {
    emit(state.copyWith(question: event.question));
  }

  void _onAnswerChanged(
    CreateEntryAnswerChanged event,
    Emitter<CreateEntryState> emit,
  ) {
    emit(state.copyWith(answer: event.answer));
  }

  void _onOrderChanged(
    CreateEntryOrderChanged event,
    Emitter<CreateEntryState> emit,
  ) {
    emit(state.copyWith(order: event.order));
  }

  void _onSubmitted(
    CreateEntrySubmitted event,
    Emitter<CreateEntryState> emit,
  ) async {
    emit(state.copyWith(status: CreateEntryStatus.loading));
    try {
      await _createEntryUsecase.call(
        fieldListId: _fieldListId,
        question: state.question,
        answer: state.answer,
        rank: state.rank,
        order: state.order.isEmpty ? 0 : int.parse(state.order),
      );
      emit(state.copyWith(status: CreateEntryStatus.success));
      emit(
        CreateEntryState(
          fieldList: state.fieldList,
          status: CreateEntryStatus.initial,
        ),
      );
    } catch (e) {
      if (e is SqliteException && e.message.contains('UNIQUE constraint')) {
        emit(state.copyWith(status: CreateEntryStatus.duplicationFailure));
        emit(state.copyWith(status: CreateEntryStatus.initial));
      } else {
        emit(state.copyWith(status: CreateEntryStatus.failure));
        emit(state.copyWith(status: CreateEntryStatus.initial));
      }
    }
  }

  void _onSubscriptionRequested(
    CreateEntrySubscriptionRequested event,
    Emitter<CreateEntryState> emit,
  ) async {
    try {
      await emit.forEach(
        _createEntryUsecase.watchFieldList(event.fieldListId),
        // TODO handle null fieldList case
        onData: (fieldList) {
          return state.copyWith(
            status: CreateEntryStatus.initial,
            fieldList: fieldList,
          );
        },
        onError: (_, _) {
          return CreateEntryState(
            status: CreateEntryStatus.failure,
            question: state.question,
            answer: state.answer,
            order: state.order,
            rank: state.rank,
          );
        },
      );
    } catch (e) {
      emit(
        CreateEntryState(
          status: CreateEntryStatus.failure,
          question: state.question,
          answer: state.answer,
          order: state.order,
          rank: state.rank,
        ),
      );
    }
  }
}
