import Flutter
import UIKit

final class NativeBlurViewFactory: NSObject, FlutterPlatformViewFactory {
  override init() { super.init() }

  func create(
    withFrame frame: CGRect,
    viewIdentifier viewId: Int64,
    arguments args: Any?
  ) -> FlutterPlatformView {
    NativeBlurPlatformView(frame: frame, viewId: viewId, args: args)
  }

  func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
    FlutterStandardMessageCodec.sharedInstance()
  }
}

final class NativeBlurPlatformView: NSObject, FlutterPlatformView {
  private let container: UIView

  init(
    frame: CGRect,
    viewId: Int64,
    args: Any?
  ) {
    let params = args as? [String: Any]
    let cornerRadius = params?["cornerRadius"] as? Double ?? 24
    let styleName = params?["style"] as? String ?? "systemMaterial"
    let blurStyle = NativeBlurPlatformView.resolveStyle(styleName)

    container = UIView(frame: frame)
    super.init()

    container.backgroundColor = .clear
    container.layer.cornerRadius = CGFloat(cornerRadius)
    container.clipsToBounds = true

    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
    blurView.frame = container.bounds
    blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    container.addSubview(blurView)
  }

  func view() -> UIView {
    container
  }

  private static func resolveStyle(_ style: String) -> UIBlurEffect.Style {
    switch style {
    case "systemUltraThinMaterial":
      return .systemUltraThinMaterial
    case "systemThinMaterial":
      return .systemThinMaterial
    case "systemThickMaterial":
      return .systemThickMaterial
    case "systemChromeMaterial":
      return .systemChromeMaterial
    default:
      return .systemMaterial
    }
  }
}
