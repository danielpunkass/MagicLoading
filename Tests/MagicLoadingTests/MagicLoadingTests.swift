import XCTest
@testable import MagicLoading

#if os(iOS)
class MagicWrappedVC: UIViewController {

	@MagicViewLoading var button: UIButton

	override func loadView() {
		self.button = UIButton()
	}

}

@available(iOS 16.4, *)
class AppleWrappedVC: UIViewController {

	@ViewLoading var button: UIButton

	override func loadView() {
		self.button = UIButton()
	}

}

class UnwrappedVC: UIViewController {

	var button: UIButton! = nil

	override func loadView() {
		self.button = UIButton()
	}

}

final class LoadableWrapperTests: XCTestCase {

	func testViewLoadingWrapper() {
		let myVC = MagicWrappedVC()
		XCTAssertNotNil(myVC.button)

		if #available(iOS 16.4, *) {
			let appleVC = AppleWrappedVC()
			XCTAssertNotNil(appleVC.button)
		}

		let unwrappedVC = UnwrappedVC()
		XCTAssertNil(unwrappedVC.button)
	}

}
#endif
