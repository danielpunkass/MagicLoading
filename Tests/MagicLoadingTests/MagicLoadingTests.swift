import XCTest
@testable import MagicLoading

// Just a placeholder type for illustration - imagine it's an UIButton or NSButton, for example
typealias PlatformButton = NSObject

class MagicWrappedVC: PlatformViewController {

	@MagicViewLoading var button: PlatformButton

	override func loadView() {
		self.button = PlatformButton()
	}

}

@available(iOS 16.4, macOS 13.3, *)
class AppleWrappedVC: PlatformViewController {

	@ViewLoading var button: PlatformButton

	override func loadView() {
		self.button = PlatformButton()
	}

}

class UnwrappedVC: PlatformViewController {

	var button: PlatformButton! = nil

	override func loadView() {
		self.button = PlatformButton()
	}

}

final class LoadableWrapperTests: XCTestCase {

	func testViewLoadingWrapper() {
		let myVC = MagicWrappedVC()
		XCTAssertNotNil(myVC.button)

		if #available(iOS 16.4, macOS 13.3, *) {
			let appleVC = AppleWrappedVC()
			XCTAssertNotNil(appleVC.button)
		}

		let unwrappedVC = UnwrappedVC()
		XCTAssertNil(unwrappedVC.button)
	}

}
