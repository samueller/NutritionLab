import SwiftUI

struct BulletGraph: View {
	static let SEGMENTS = 3
	
	static let HEIGHT: CGFloat = 4
	static let RADIUS: CGFloat = 10
	
	let width: CGFloat
	
	let range: ClosedRange<Float>
	let value: Float
	
	let units: String
	
	var ok: Bool {
		value >= range.upperBound * 1 / 3 &&
		value <= range.upperBound * 2 / 3
	}
	
	var position: CGFloat {
		width * .init(value / range.upperBound)
	}
	
	var scale: some View {
		HStack(spacing: 0) {
			Rectangle()
				.foregroundColor(.orange)
			Rectangle()
				.foregroundColor(.green)
			Rectangle()
				.foregroundColor(.orange)
		}
		.opacity(0.7)
		.frame(height: Self.HEIGHT)
		.cornerRadius(Self.HEIGHT / 2)
	}
	
	var numbers: some View {
		HStack {
			ForEach(0..<Self.SEGMENTS + 1) { position in
				Text(String(range.upperBound * .init(position) / .init(Self.SEGMENTS)))
				if position < Self.SEGMENTS { Spacer() }
			}
		}
	}
	
	var overlay: some View {
		ZStack(alignment: .topLeading) {
			HStack {
				Text(String(value))
					.font(.title)
					.bold()
					.foregroundColor(ok ? .green : .red)
				Text(units)
					.foregroundColor(.gray)
			}
			.padding(.horizontal, 12)
			.padding(.vertical, 8)
			.background(Color(ok ? #colorLiteral(red: 0.862745098, green: 0.9529411765, blue: 0.8784313725, alpha: 1) : #colorLiteral(red: 0.968627451, green: 0.8078431373, blue: 0.8039215686, alpha: 1)))
			.cornerRadius(100)
			.offset(x: -20, y: -70)
			.zIndex(1)
			Rectangle()
				.foregroundColor(ok ? .green : .red)
				.frame(width: 2, height: 40)
				.offset(x: Self.RADIUS - 1, y: Self.RADIUS - 40)
			Circle()
				.foregroundColor(ok ? .green : .red)
				.padding(3)
				.overlay(
					Circle()
						.stroke(ok ? Color.green : Color.red, lineWidth: 1)
				)
				.frame(width: Self.RADIUS * 2, height: Self.RADIUS * 2)
		}
		.offset(x: position - Self.RADIUS, y: Self.HEIGHT / 2 - Self.RADIUS)
	}
	
	var body: some View {
		ZStack(alignment: .topLeading) {
			VStack {
				scale
				numbers
			}
			overlay
		}
		.frame(width: width)
	}
}

struct BulletGraph_Previews: PreviewProvider {
	static var previews: some View {
		BulletGraph(
			width: UIScreen.main.bounds.size.width - 20 * 2,
			range: 0...150,
			value: 100,
			units: "mg/dL"
		)
	}
}
