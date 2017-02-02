import XCTest

class CommandTests: XCTestCase {
  func testDefaults() {
    let command = UnicornCommand([])

    XCTAssertFalse(command.needsHelp)
    XCTAssertFalse(command.isNotValid)
    XCTAssertFalse(command.verboseOutput)
    XCTAssertEqual(command.seconds, 2.0)
    XCTAssertEqual(command.number, 1)
    XCTAssertEqual(command.imageFile, "unicorn.png")
    XCTAssertEqual(command.sparkleFile, "sparkle.png")
  }

  func testNeedsHelp() {
    for flag in ["-h", "--help"] {
      let command = UnicornCommand([flag])
      XCTAssertFalse(command.isNotValid, "for flag: '\(flag)'")
      XCTAssertTrue(command.needsHelp, "for flag: '\(flag)'")
    }
  }

  func testWantsVerboseOutput() {
    for flag in ["-v", "--verbose"] {
      let command = UnicornCommand([flag])
      XCTAssertFalse(command.isNotValid, "for flag: '\(flag)'")
      XCTAssertTrue(command.verboseOutput, "for flag: '\(flag)'")
    }
  }

  func testHasInvalidFlags() {
    for flag in ["-u", "--invalid"] {
      let command = UnicornCommand([flag])
      XCTAssertTrue(command.isNotValid, "for flag: '\(flag)'")
      XCTAssertEqual(command.invalidFlags, [flag], "for flag: '\(flag)'")
    }
  }

  func testProvidingSeconds() {
    for flag in ["-s", "--seconds"] {
      let command = UnicornCommand([flag, "5"])
      XCTAssertFalse(command.isNotValid, "for flag: '\(flag)'")
      XCTAssertEqual(command.seconds, 5.0, "for flag: '\(flag)'")
    }
  }

  func testProvidingSecondsWithoutAValue() {
    for flag in ["-s", "--seconds"] {
      let command = UnicornCommand([flag])
      XCTAssertTrue(command.isNotValid, "for flag: '\(flag)'")
      XCTAssertNil(command.seconds, "for flag: '\(flag)'")
    }
  }

  func testProvidingSecondsWithBadValue() {
    for flag in ["-s", "--seconds"] {
      let command = UnicornCommand([flag, "four"])
      XCTAssertTrue(command.isNotValid, "for flag: '\(flag)'")
      XCTAssertNil(command.seconds, "for flag: '\(flag)'")
    }
  }

  func testProvidingShortAndLongSeconds() {
    let command = UnicornCommand(["-s", "5", "--seconds", "6"])
    XCTAssertFalse(command.isNotValid)
    XCTAssertEqual(command.seconds, 5)
  }

  func testProvidingNumber() {
    for flag in ["-n", "--number"] {
      let command = UnicornCommand([flag, "5"])
      XCTAssertFalse(command.isNotValid, "for flag: '\(flag)'")
      XCTAssertEqual(command.number, 5, "for flag: '\(flag)'")
    }
  }

  func testProvidingNumberWithoutAValue() {
    for flag in ["-n", "--number"] {
      let command = UnicornCommand([flag])
      XCTAssertTrue(command.isNotValid, "for flag: '\(flag)'")
      XCTAssertNil(command.number, "for flag: '\(flag)'")
    }
  }

  func testProvidingNumberWithBadValue() {
    for flag in ["-n", "--number"] {
      let command = UnicornCommand([flag, "four"])
      XCTAssertTrue(command.isNotValid, "for flag: '\(flag)'")
      XCTAssertNil(command.number, "for flag: '\(flag)'")
    }
  }

  func testProvidingShortAndLongNumber() {
    let command = UnicornCommand(["-n", "5", "--number", "6"])
    XCTAssertFalse(command.isNotValid)
    XCTAssertEqual(command.number, 5)
  }

  func testProvidingUnicornFile() {
    for flag in ["-i", "--image"] {
      let command = UnicornCommand([flag, "hippo.png"])
      XCTAssertFalse(command.isNotValid, "for flag: '\(flag)'")
      XCTAssertEqual(command.imageFile, "hippo.png", "for flag: '\(flag)'")
    }
  }

  func testProvidingUnicornFileWithoutAValue() {
    for flag in ["-i", "--image"] {
      let command = UnicornCommand([flag])
      XCTAssertTrue(command.isNotValid, "for flag: '\(flag)'")
      XCTAssertNil(command.imageFile, "for flag: '\(flag)'")
    }
  }

  func testProvidingShortAndLongUnicornFile() {
    let command = UnicornCommand(["-i", "hippo.png", "--image", "bat.png"])
    XCTAssertFalse(command.isNotValid)
    XCTAssertEqual(command.imageFile, "hippo.png")
  }

  func testProvidingSparkleFile() {
    for flag in ["-k", "--sparkle"] {
      let command = UnicornCommand([flag, "poof.png"])
      XCTAssertFalse(command.isNotValid, "for flag: '\(flag)'")
      XCTAssertEqual(command.sparkleFile, "poof.png", "for flag: '\(flag)'")
    }
  }

  func testProvidingSparkleFileWithoutAValue() {
    for flag in ["-k", "--sparkle"] {
      let command = UnicornCommand([flag])
      XCTAssertTrue(command.isNotValid, "for flag: '\(flag)'")
      XCTAssertNil(command.sparkleFile, "for flag: '\(flag)'")
    }
  }

  func testProvidingShortAndLongSparkleFile() {
    let command = UnicornCommand(["-k", "poof.png", "--sparkle", "blood.png"])
    XCTAssertFalse(command.isNotValid)
    XCTAssertEqual(command.sparkleFile, "poof.png")
  }
}
