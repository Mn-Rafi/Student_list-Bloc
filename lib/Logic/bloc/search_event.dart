part of 'search_bloc.dart';

abstract class SearchEvent {
  const SearchEvent();
}

class EnterValues extends SearchEvent {
  final String input;
  const EnterValues({
    required this.input,
  });
}

class ClearValues extends SearchEvent {}
