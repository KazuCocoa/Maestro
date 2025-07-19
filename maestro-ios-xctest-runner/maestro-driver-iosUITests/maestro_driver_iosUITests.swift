import XCTest
import FlyingFox
import os

class FailureResistantTestCase: XCTestCase {
  override func setUp() {
    super.setUp()
    continueAfterFailure = true
  }

  override func record(_ issue: XCTIssue) {
    print("Issue recorded: \(issue)")
    // Ignore issue or log as needed
  }
}

final class maestro_driver_iosUITests: FailureResistantTestCase {
    private static let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: "maestro_driver_iosUITests"
    )

    private static var swizzledOutIdle = false

    override func setUpWithError() throws {
        // XCTest internals sometimes use XCTAssert* instead of exceptions.
        // Setting `continueAfterFailure` so that the xctest runner does not stop
        // when an XCTest internal error happes (eg: when using .allElementsBoundByIndex
        // on a ReactNative app)
        continueAfterFailure = true
    }

    override class func setUp() {
        logger.error("====== setUp")
    }

    func testHttpServer() async throws {
        maestro_driver_iosUITests.logger.error("====== testHttpServer was called");

        let server = XCTestHTTPServer()
        maestro_driver_iosUITests.logger.error("Will start HTTP server")
        try await server.start()
    }

    override class func tearDown() {
        logger.error("tearDown")
    }
}
