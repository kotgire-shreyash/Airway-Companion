import 'package:airwaycompanion/Modules/Home/Events/home_screen_events.dart';
import 'package:airwaycompanion/Modules/Home/Screens/home_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenState()) {
    on<SearchIconPressed>(_onSearchIconPressedEvent);
    on<SearchBoxTextFieldPressed>(_onSearchBoxTextFieldPressedEvent);
    on<CheckListTilePressed>(_onCheckListTilePressedEvent);
    on<NavigationTilePressed>(_onNavigationTilePressedEvent);
  }

  void _onSearchIconPressedEvent(
      SearchIconPressed event, Emitter<HomeScreenState> emit) {
    emit(state.copyWith(isSearchIconPressed: event.isSearchIconPressed));
  }

  void _onSearchBoxTextFieldPressedEvent(
      SearchBoxTextFieldPressed event, Emitter<HomeScreenState> emit) {
    emit(state.copyWith(
        isSearchBoxTextFieldEnabled: event.isSearchBoxTextFieldEnabled));
  }

  void _onCheckListTilePressedEvent(
      CheckListTilePressed event, Emitter<HomeScreenState> emit) {
    emit(state.copyWith(isChecklistTilePressed: event.isChecklistTilePressed));
  }

  void _onNavigationTilePressedEvent(
      NavigationTilePressed event, Emitter<HomeScreenState> emit) {
    emit(
        state.copyWith(isNavigationTilePressed: event.isNavigationTilePressed));
  }
}
