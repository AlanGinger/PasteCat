import 'package:flutter/services.dart';

class PasteObserver {

  static const EventChannel _observer = EventChannel('com.pastecat/paste');

  PasteObserver._sharedInstance() {
    _observer.receiveBroadcastStream().listen(onUpdate, onError: onError);
  }
  static final PasteObserver _shared = PasteObserver._sharedInstance();
  factory PasteObserver() {
    return _shared;
  }
  

  onUpdate(dynamic event) {
    print("test on Update: $event");
  }

  onError(dynamic error) {
    print("test on Error: $error");
  }

  

}