import Foundation

extension Float {
	static let formatter: NumberFormatter = {
		let formatter = NumberFormatter()
		
		formatter.minimumFractionDigits = 0
		formatter.maximumFractionDigits = 3
		formatter.numberStyle = .decimal
		
		return formatter
	}()
	
	var formatted: String {
		Self.formatter.string(from: self as NSNumber) ?? "N/A"
	}
}
