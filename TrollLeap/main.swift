//
//  main.swift
//  TrollLeap
//
//  Created by Endoze on 2/1/17.
//  Copyright © 2017 Endoze. All rights reserved.
//

import Cocoa

let command = TrollCommand(CommandLine.arguments)

if command.needsHelp {
  command.printUsage(0)
} else if command.isNotValid {
  command.printCommandErrors()
  command.printUsage(1)
} else {
  if command.verboseOutput {
    command.printVerboseOutput()
  }

  Leap.animateImage(command)
}
