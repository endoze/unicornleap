import Cocoa

class LeapImage {
  let filename: String
  var image: CGImage!
  var animationKeyPath = "position"

  var imagePath: String {
    return "\(NSHomeDirectory())/.unicornleap/\(filename)"
  }

  init?(filename: String) {
    self.filename = filename
    guard let source = CGDataProvider(filename: imagePath),
      let image = CGImage(pngDataProviderSource: source, decode: nil, shouldInterpolate: true, intent: .defaultIntent)
      else { return nil }

    self.image = image
  }

  func addAnimation(_ seconds: Double, path: CGMutablePath, layer: CALayer) {
    let animation = CAKeyframeAnimation()
    animation.keyPath = animationKeyPath
    animation.path = path
    animation.duration = seconds
    animation.calculationMode = kCAAnimationLinear

    layer.add(animation, forKey: animationKeyPath)
  }
}
