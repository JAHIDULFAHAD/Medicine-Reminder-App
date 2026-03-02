import Flutter
import UIKit
import flutter_local_notifications

@main
@objc class AppDelegate: FlutterAppDelegate {

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // Required for flutter_local_notifications background isolate
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
        GeneratedPluginRegistrant.register(with: registry)
    }

    GeneratedPluginRegistrant.register(with: self)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // Needed for background action handling (iOS)
  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
      FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
          GeneratedPluginRegistrant.register(with: registry)
      }
      GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }

  // Handle notification settings tap (optional but recommended)
  @available(iOS 12.0, *)
  override func userNotificationCenter(
      _ center: UNUserNotificationCenter,
      openSettingsFor notification: UNNotification?
  ) {
      guard let controller = window?.rootViewController as? FlutterViewController else {
          return
      }

      let channel = FlutterMethodChannel(
          name: "com.jhf.medicine_reminder_app/settings",
          binaryMessenger: controller.binaryMessenger
      )

      channel.invokeMethod("showNotificationSettings", arguments: nil)
  }
}