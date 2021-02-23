import Foundation

struct Lab {
    let name: String
    let url: URL
    
    init(name: String, url: String) {
        self.name = name
        self.url = URL(string: url)!
    }
}

let labs = [
    Lab(
        name: "Baseline Biomarkers",
        url: "https://www.ultalabtests.com/julikeenelabs/Shop/Items/Item/baseline-biomarkers-basic"
    ),
    Lab(
        name: "Baseline Biomarkers Plus",
        url: "https://www.ultalabtests.com/julikeenelabs/Shop/Items/Item/baseline-biomarkers-basic-plus"
    ),
    Lab(
        name: "Baseline Biomarkers Advanced",
        url: "https://www.ultalabtests.com/julikeenelabs/Shop/Items/Item/baseline-biomarkers-advanced"
    ),
    Lab(
        name: "Baseline Biomarkers Comprehensive",
        url: "https://www.ultalabtests.com/julikeenelabs/Shop/Items/Item/baseline-biomarkers-comprehensive"
    )
]
