//
//  TrollCommand.swift
//  unicornleap
//
//  Created by Endoze on 2/1/17.
//  Copyright © 2017 Endoze. All rights reserved.
//

import Foundation

class TrollCommand: Commandable {
  var name = "trollleap"
  var imageName = "troll.png"
  var sparkleName = "sparkle-2.png"

  var arguments: [String] = [String]()
  var helpText: [String] = [
    "Usage: trolleap [options]\n",
    "  -h  --help           Display usage information.\n",
    "  -s  --seconds n      Animate for n seconds. (default: 2.0)\n",
    "  -n  --number i       Display i trolls. (default: 1)\n",
    "  -i  --image file     Filename for troll image.\n",
    "  -k  --sparkle file   Filename for sparkle image.\n",
    "  -v  --verbose        Print verbose messages."
  ]

  required init(_ arguments: [String]) {
    self.arguments = arguments
  }
}

