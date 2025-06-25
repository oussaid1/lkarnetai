part of 'date_filter_bloc.dart';

class DateFilterState extends Equatable {
  final DateFilter dateFilter;
  const DateFilterState({required this.dateFilter});

  @override
  List<Object> get props => [dateFilter];
}
