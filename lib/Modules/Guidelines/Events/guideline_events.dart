abstract class GuidelineScreenEvent {}

class TranslateEvent extends GuidelineScreenEvent {
  String to;
  var content;

  TranslateEvent({this.to = "", this.content});
}
