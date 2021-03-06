import Cocoa

let command = UnicornCommand(CommandLine.arguments)

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
