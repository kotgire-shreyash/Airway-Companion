import 'package:airwaycompanion/Modules/Guidelines/Events/guideline_events.dart';
import 'package:airwaycompanion/Modules/Guidelines/Screens/guideline_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuidelineScreenBloc
    extends Bloc<GuidelineScreenEvent, GuidelineScreenState> {
  GuidelineScreenBloc() : super(GuidelineScreenState()) {}
}
