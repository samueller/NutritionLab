import Foundation

struct Lab {
	let name: String
	let url: URL
	
	init(_ name: String, _ url: String) {
		self.name = name
		self.url = URL(string: url)!
	}
}

let labs: [Lab] = [
	.init(
		"Baseline Biomarkers",
		"https://www.ultalabtests.com/julikeenelabs/Shop/Items/Item/baseline-biomarkers-basic"
	),
	.init(
		"Baseline Biomarkers Plus",
		"https://www.ultalabtests.com/julikeenelabs/Shop/Items/Item/baseline-biomarkers-basic-plus"
	),
	.init(
		"Baseline Biomarkers Advanced",
		"https://www.ultalabtests.com/julikeenelabs/Shop/Items/Item/baseline-biomarkers-advanced"
	),
	.init(
		"Baseline Biomarkers Comprehensive",
		"https://www.ultalabtests.com/julikeenelabs/Shop/Items/Item/baseline-biomarkers-comprehensive"
	)
]
