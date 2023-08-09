#if os(iOS)

import UIKit
typealias PlatformViewController = UIViewController

#else

import AppKit
typealias PlatformViewController = NSViewController

extension NSViewController {

	fileprivate func loadViewIfNeeded() {
		assert(Thread.isMainThread)
		if isViewLoaded == false {
			_ = self.view  // Invokes loadView(), but only ever once.
		}
	}

}

#endif

@propertyWrapper
struct MagicViewLoading<WrappedValue> {

	private var stored: WrappedValue? = nil

	public init() {
		self.stored = nil
	}

	public init(wrappedValue: WrappedValue) {
		self.stored = wrappedValue
	}

	/// Undocumented but widespread subscript method for accessing the wrapped object. This
	/// technique is alluded to in the original property wrappers Swift Evolution proposal,
	/// and has remained consistently available. Since the technique informs static generation
	/// of property wrapper "sugar", I think it's safe to rely upon it even for shipping code.
	/// https://github.com/apple/swift-evolution/blob/main/proposals/0258-property-wrappers.md#referencing-the-enclosing-self-in-a-wrapper-type
	static subscript<T: PlatformViewController>(
		_enclosingInstance instance: T,
		wrapped wrappedKeyPath: ReferenceWritableKeyPath<T, WrappedValue>,
		storage storageKeyPath: ReferenceWritableKeyPath<T, Self>
	) -> WrappedValue {
		get {
			instance.loadViewIfNeeded()
			return instance[keyPath: storageKeyPath].stored!
		}
		set {
			instance[keyPath: storageKeyPath].stored = newValue
		}
	}

	/// Compatibility guard against attempted use on non-reference types
	@available(*, unavailable,
		message: "This property wrapper is only available on classes because it accesses its container using reference semantics"
	)
	var wrappedValue: WrappedValue {
		get { fatalError() }
		set { fatalError() }
	}

}
