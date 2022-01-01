abstract class GuidelineScreenEvent {}

class TranslateEvent extends GuidelineScreenEvent {
  String to;
  var content;
  bool isBeingTranslated;
  TranslateEvent({this.to = "", this.content, this.isBeingTranslated = false});
}
