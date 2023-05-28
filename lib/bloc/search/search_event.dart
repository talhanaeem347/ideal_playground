part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}
class LoadUserEvent extends SearchEvent{
  final String userId;

  const LoadUserEvent({required this.userId});
  @override
  List<Object> get props => [userId];
}
