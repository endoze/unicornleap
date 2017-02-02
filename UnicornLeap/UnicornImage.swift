import Cocoa

class UnicornImage: LeapImage {
  var size: NSSize!
  let path = CGMutablePath()
  let layer = CALayer()

  override init?(filename: String) {
    super.init(filename: filename)

    guard let size = NSImage(contentsOfFile: imagePath)?.size else { return nil }
    self.size = size

    configurePath()
    configureLayer()
  }

  func addAnimation(_ seconds: Double) {
    super.addAnimation(seconds, path: path, layer: layer)
  }

  fileprivate func configurePath() {
    let screen = NSScreen.main()!.frame
    let origin = CGPoint(x: -size.width, y: -size.height)
    let destination = CGPoint(x: screen.size.width + size.width, y: origin.y)
    let midpoint = (destination.x + origin.x) / 2.0
    let peak = size.height + 50.0

    path.move(to: CGPoint(x: origin.x, y: origin.y))
    path.addCurve(to: CGPoint(x: destination.x, y: destination.y), control1: CGPoint(x: midpoint, y: peak), control2: CGPoint(x: midpoint, y: peak))
  }

  fileprivate func configureLayer() {
    layer.contents = image
    layer.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    layer.position = CGPoint(x: -size.width, y: -size.height)
  }
}
