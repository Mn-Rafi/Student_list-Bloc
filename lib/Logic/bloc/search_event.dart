part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class EnterValues extends SearchEvent {
  final String input;
  const EnterValues({
    required this.input,
  });
}

class ClearValues extends SearchEvent {}
