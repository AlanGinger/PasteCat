import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    private var sender: PasteboardEventChannel?
    private var observer: PasteboardObserver?
    
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      let rootVC = self.window.rootViewController as? FlutterViewController
      if rootVC != nil {
          sender = PasteboardEventChannel.init(messenger: rootVC!.binaryMessenger)
          observer = PasteboardObserver.init()
          observer?.onPasteboardUpdate = { [weak self] content in
              let _ = self?.sender?.sendData(content: content)
          }
      }
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
