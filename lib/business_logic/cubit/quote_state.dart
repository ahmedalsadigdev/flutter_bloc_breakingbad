part of 'quote_cubit.dart';

sealed class QuoteState extends Equatable {
  const QuoteState();

  @override
  List<Object> get props => [];
}

final class QuoteInitial extends QuoteState {}

final class QuoteLoading extends QuoteState {}

final class QuoteLoaded extends QuoteState {
  final Quote quote;

  const QuoteLoaded({required this.quote});

  @override
  List<Object> get props => [quote];
}

final class QuoteError extends QuoteState {
  final String message;

  const QuoteError({required this.message});

  @override
  List<Object> get props => [message];
}
