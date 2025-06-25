import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lkarnet/models/kitchen/kitchen_element.dart';
import 'package:lkarnet/repository/database_operations.dart';

part 'kitchen_element_event.dart';
part 'kitchen_element_state.dart';

class KitchenElementBloc
    extends Bloc<KitchenElementEvent, KitchenElementState> {
  late final DatabaseOperations databaseOperations;
  StreamSubscription? _kitchenElementSubscription;
  KitchenElementBloc(DatabaseOperations databaseOperations)
      : super(KitchenElementState(
          status: KitchenElementStatus.initial,
          kitchenElements: [],
          error: '',
        )) {
    this.databaseOperations = databaseOperations;
    on<GetKitchenElementsEvent>(_onGetAllKitchenElements);
    on<LoadKitchenElementsEvent>(_onLoadKitchenElements);
    on<AddKitchenElementEvent>(_onAddKitchenElement);
    on<UpdateKitchenElementEvent>(_onUpdateKitchenElement);
    on<DeleteKitchenElementEvent>(_onDeleteKitchenElement);
  }

  //////////////////////////////////////////////////////
  _onGetAllKitchenElements(
      GetKitchenElementsEvent event, Emitter<KitchenElementState> emit) async {
    _kitchenElementSubscription = databaseOperations
        .kitchenElementsStream()
        .listen((kitchenElements) =>
            add(LoadKitchenElementsEvent(kitchenElements: kitchenElements)));
  }

//////////////////////////////////////////////////////
  _onLoadKitchenElements(
      LoadKitchenElementsEvent event, Emitter<KitchenElementState> emit) async {
    emit(state.copyWith(
        status: KitchenElementStatus.loaded,
        kitchenElements: event.kitchenElements));
  }

//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
  ///Crud operations for kitchen elements ///////////////
  _onAddKitchenElement(
      AddKitchenElementEvent event, Emitter<KitchenElementState> emit) async {
    try {
      await databaseOperations.addKitchenElement(event.kitchenElement);
      emit(state.copyWith(status: KitchenElementStatus.added));
    } catch (error) {
      emit(state.copyWith(status: KitchenElementStatus.error, error: '$error'));
    }
  }

  _onUpdateKitchenElement(UpdateKitchenElementEvent event,
      Emitter<KitchenElementState> emit) async {
    try {
      await databaseOperations.updateKitchenElement(event.kitchenElement);
      emit(state.copyWith(status: KitchenElementStatus.updated));
    } catch (error) {
      emit(state.copyWith(status: KitchenElementStatus.error, error: '$error'));
    }
  }

  _onDeleteKitchenElement(DeleteKitchenElementEvent event,
      Emitter<KitchenElementState> emit) async {
    try {
      await databaseOperations.deleteKitchenElement(event.kitchenElement);
      emit(state.copyWith(status: KitchenElementStatus.deleted));
    } catch (error) {
      emit(state.copyWith(status: KitchenElementStatus.error, error: '$error'));
    }
  }

  @override
  close() {
    _kitchenElementSubscription?.cancel();
    return super.close();
  }
}
