import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
     let flutterViewController = FlutterViewController.init()
     let windowFrame = self.frame
     self.contentViewController = flutterViewController
     self.setFrame(windowFrame, display: true)

     RegisterGeneratedPlugins(registry: flutterViewController)
      
     let _observer = PasteboardObserver.init()
     let _sender = PasteboardEventChannel.init(messenger: flutterViewController.engine.binaryMessenger)
     _observer.onPasteboardUpdate = { content in
         let _ = _sender.sendData(content: content)
      }
     _observer.start()

     super.awakeFromNib()
  }
}
