import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lkarnet/models/item/items_filtered.dart';

part 'date_filter_event.dart';
part 'date_filter_state.dart';

class DateFilterBloc extends Bloc<DateFilterEvent, DateFilterState> {
  DateFilterBloc() : super(DateFilterState(dateFilter: DateFilter.all)) {
    on<ChangeDateFilterEvent>(_onChangeDateFilter);
  }

  /// on change date filter event
  void _onChangeDateFilter(
      ChangeDateFilterEvent event, Emitter<DateFilterState> emit) {
    emit(DateFilterState(dateFilter: event.dateFilter));
  }
}
