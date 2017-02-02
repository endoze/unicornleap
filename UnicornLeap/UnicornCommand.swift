import Foundation

class UnicornCommand: Commandable {
  var name = "unicornleap"
  var imageName = "unicorn.png"
  var sparkleName = "sparkle.png"

  var arguments: [String] = [String]()
  var helpText: [String] = [
    "Usage: unicornleap [options]\n",
    "  -h  --help           Display usage information.\n",
    "  -s  --seconds n      Animate for n seconds. (default: 2.0)\n",
    "  -n  --number i       Display i unicorns. (default: 1)\n",
    "  -i  --image file     Filename for unicorn image.\n",
    "  -k  --sparkle file   Filename for sparkle image.\n",
    "  -v  --verbose        Print verbose messages."
  ]

  required init(_ arguments: [String]) {
    self.arguments = arguments
  }
}
