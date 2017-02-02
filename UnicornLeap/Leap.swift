import Cocoa

class Leap {
  let command: Commandable

  class func animateImage(_ command: Commandable) {
    Leap(command).animateImage()
  }

  init(_ command: Commandable) {
    self.command = command
  }

  func animateImage() {
    // Makes a connection to the window server so we can animate
    NSApplication.shared()

    guard let unicornImage = UnicornImage(filename: command.imageFile!) else { command.printImageError(command.imageFile!); return }
    guard let sparkleImage = SparkleImage(filename: command.sparkleFile!) else { command.printImageError(command.sparkleFile!); return }

    let floatingWindow = FloatingWindow(rect: NSScreen.main()!.frame)

    floatingWindow.window.makeKeyAndOrderFront(nil)

    let waitFor = Double(command.seconds!/2.5)

    let runLoop = RunLoop.current
    floatingWindow.view.wantsLayer = true

    for _ in (1...command.number!) {
      sparkleImage.configureEmitter(unicornImage.size, seconds: command.seconds!)

      floatingWindow.view.layer?.addSublayer(unicornImage.layer)
      floatingWindow.view.layer?.addSublayer(sparkleImage.emitter)

      unicornImage.addAnimation(Double(command.seconds!))
      sparkleImage.addAnimation(Double(command.seconds!), path: unicornImage.path)

      runLoop.run(until: Date(timeIntervalSinceNow: Double(waitFor)))
    }

    runLoop.run(until: Date(timeIntervalSinceNow: (Double(command.seconds!) - waitFor + 0.2)))
  }
}
