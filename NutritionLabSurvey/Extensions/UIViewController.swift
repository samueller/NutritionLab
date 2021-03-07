import UIKit

extension UIViewController {
	static var current: UIViewController? {
		UIApplication.shared.windows.last?.rootViewController
	}
}
