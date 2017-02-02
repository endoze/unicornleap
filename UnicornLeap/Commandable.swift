//
//  Command.swift
//  unicornleap
//
//  Created by Endoze on 2/1/17.
//  Copyright © 2017 Endoze. All rights reserved.
//

import Cocoa

public protocol Commandable {
  var arguments: [String] { get set }
  var helpText: [String] { get }
  var imageFile: String? { get }
  var imageName: String { get }
  var invalidFlags: [String] { get }
  var isNotValid: Bool { get }
  var name: String { get }
  var needsHelp: Bool { get }
  var number: Int? { get }
  var seconds: Float? { get }
  var sparkleFile: String? { get }
  var sparkleName: String { get }
  var validFlags: [String] { get }
  var verboseOutput: Bool { get }

  init(_ arguments: [String])
  func flagIndex(_ flags: [String]) -> Int?
  func nextArgument(_ index: Int) -> String?
  func printUsage(_ exitCode: Int32)
  func printCommandErrors()
}

public extension Commandable {
  public var imageFile: String? {
    guard let index = flagIndex(["-i", "--image"]) else {
      return imageName
    }

    return nextArgument(index)
  }

  public var invalidFlags: [String] {
    let flags = Set(arguments.filter({ $0[$0.startIndex] == "-" }))

    return Array(flags.subtracting(validFlags))
  }

  public var isNotValid: Bool {
    return !invalidFlags.isEmpty || seconds == nil || number == nil || imageFile == nil || sparkleFile == nil
  }

  public var needsHelp: Bool {
    return arguments.contains("-h") || arguments.contains("--help")
  }

  public var number: Int? {
    guard let index = flagIndex(["-n", "--number"]) else { return 1 }
    return nextArgument(index)?.asInt
  }

  public var seconds: Float? {
    guard let index = flagIndex(["-s", "--seconds"]) else { return 2.0 }
    return nextArgument(index)?.asFloat
  }

  public var sparkleFile: String? {
    guard let index = flagIndex(["-k", "--sparkle"]) else { return sparkleName }
    return nextArgument(index)
  }

  public var validFlags: [String] {
    return ["-h", "--help", "-s", "--seconds", "-n", "--number", "-i",  "--image", "-k", "--sparkle", "-v", "--verbose"]
  }
  
  public var verboseOutput: Bool {
    return arguments.contains("-v") || arguments.contains("--verbose")
  }

  func flagIndex(_ flags: [String]) -> Int? {
    let indexes = flags.map { arguments.index(of: $0) }
    return indexes.flatMap({$0}).first
  }

  func nextArgument(_ index: Int) -> String? {
    let nextIndex = index.advanced(by: 1)
    guard nextIndex < arguments.count else { return nil }
  
    return arguments[nextIndex]
  }

  public func printUsage(_ exitCode: Int32) {
    print(helpText.joined(separator: ""))

    exit(exitCode)
  }

  public func printCommandErrors() {
    var errors = [String]()

    if !invalidFlags.isEmpty {
      let invalidOptions = invalidFlags.joined(separator: ", ")
      errors.append("\(name) - invalid options: \(invalidOptions)")
    }

    if seconds == nil {
      errors.append("\(name) - the seconds flag requires an argument")
    }

    if number == nil {
      errors.append("\(name) - the number flag requires an argument")
    }

    print("\(errors.joined(separator: "\n"))\n")
  }

  public func printImageError(_ filename: String) {
    print("\(name) - valid PNG not found: ~/.unicornleap/\(filename)")

    exit(127)
  }

  public func printVerboseOutput() {
    print("Seconds: \(seconds)")
    print("Number: \(number)")
  }
}

private extension String {
  var asInt: Int? {
    return Int(self)
  }

  var asFloat: Float? {
    return Float(self)
  }
}
