part of 'date_filter_bloc.dart';

abstract class DateFilterEvent extends Equatable {
  const DateFilterEvent();

  @override
  List<Object> get props => [];
}

/// change date filter event
class ChangeDateFilterEvent extends DateFilterEvent {
  final DateFilter dateFilter;
  const ChangeDateFilterEvent({required this.dateFilter});

  @override
  List<Object> get props => [dateFilter];
}
