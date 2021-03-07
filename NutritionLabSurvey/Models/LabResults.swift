import Foundation

extension Float {
	var clean: String {
		let formatter = NumberFormatter()
		formatter.minimumFractionDigits = 0
		formatter.maximumFractionDigits = 3
		formatter.numberStyle = .decimal
		return formatter.string(from: self as NSNumber) ?? "N/A"
	}
}

struct Biomarker {
	let name: String
	let refRange: ClosedRange<Float>
	let units: String
	
	init(_ name: String, _ refRange: ClosedRange<Float>, _ units: String) {
		self.name = name
		self.refRange = refRange
		self.units = units
	}
}

let biomarkers: [String: Biomarker] = [
	"HS CRP": .init("High-sensitivity C-reactive Protein", 0.0...3.1, "mg/L"),
	"GLUCOSE": .init("Glucose", 65...99, "mg/dL"),
	"UREA NITROGEN (BUN)": .init("Blood Urea Nitrogen (BUN)", 7...25, "mg/dL"),
	"CREATININE": .init("Creatinine", 0.5...1.1, "mg/dL"),
	"eGFR NON-AFR. AMERICAN": .init("Estimated Glomerular Filtration Rate Non-African American", 0...60, "mL/min per 1.73 m²"),
	"eGFR AFRICAN AMERICAN": .init("Estimated Glomerular Filtration Rate African American", 0...60, "mL/min per 1.73 m²"),
	"BUN/CREATININE RATIO": .init("BUN/Creatinine Ratio", 6...22, ""),
	"SODIUM": .init("Sodium", 135...146, "mmol/L"),
	"POTASSIUM": .init("Potassium", 3.5...5.3, "mmol/L"),
	"CHLORIDE": .init("Chloride", 98...110, "mmol/L"),
	"CARBON DIOXIDE": .init("Carbon Dioxide", 20...32, "mmol/L"),
	"CALCIUM": .init("Calcium", 8.6...10.2, "mg/dL"),
	"PROTEIN, TOTAL": .init("Total Protein", 6.1...8.1, "g/dL"),
	"ALBUMIN": .init("Albumin", 3.6...5.1, "g/dL"),
	"GLOBULIN": .init("Globulin", 1.9...3.7, "g/dL"),
	"ALBUMIN/GLOBULIN RATIO": .init("Albumin/Globulin Ratio", 1.0...2.5, ""),
	"BILIRUBIN, TOTAL": .init("Total Bilirubin", 0.2...1.2, "mg/dL"),
	"ALKALINE PHOSPHATASE": .init("Alkaline Phosphatase", 31...125, "U/L"),
	"AST": .init("Aspartate Transaminase", 10...30, "U/L"),
	"ALT": .init("Alanine Transaminase", 6...29, "U/L"),
	"HEMOGLOBIN A1c": .init("Hemoglobin A1c", 4...6, "%"),
	"eAG": .init("Estimated Average Glucose", 70...126, "mg/dL"),
	"VITAMIN D,25-OH,TOTAL,IA": .init("25-hydroxyvitamin D AKA Calcidiol", 30...100, "ng/mL"),
	"HOMOCYSTEINE": .init("Homocysteine", 0...10.4, "umol/L"),
	"T3, FREE": .init("Free Triiodothyronine", 2.3...4.2, "pg/mL"),
	"FERRITIN": .init("Ferritin", 16...232, "ng/mL"),
	"FIBRINOGEN ACTIVITY, CLAUSS": .init("Fibrinogen Activity (Clauss)", 175...425, "mg/dL"),
	"GGT": .init("Gamma-Glutamyl Transferase (GGT)", 3...55, "U/L"),
	"INSULIN": .init("Insulin", 0...19.6, "uIU/mL"),
	"LD": .init("Lactate Dehydrogenase (LDH)", 100...200, "U/L"),
	"MAGNESIUM": .init("Magnesium", 1.5...2.5, "mg/dL"),
	"WHITE BLOOD CELL COUNT": .init("White Blood Cell Count", 3.8...10.8, "Thousand/uL"),
	"RED BLOOD CELL COUNT": .init("Red Blood Cell Count", 3.8...5.1, "Million/uL"),
	"HEMOGLOBIN": .init("Hemoglobin", 11.7...15.5, "g/dL"),
	"HEMATOCRIT": .init("Hematocrit (% of Red Blood Cells)", 35...45, "%"),
	"MCV": .init("Mean Corpuscular Volume (MCV)", 80...100, "fL"),
	"MCH": .init("Mean Corpuscular Hemoglobin (MCH)", 27...33, "pg"),
	"MCHC": .init("Mean Corpuscular Hemoglobin Concentration (MCHC)", 32...36, "g/dL"),
	"RDW": .init("Red Cell Distribution Width (RDW)", 11...15, "%"),
	"PLATELET COUNT": .init("Platelet Count", 140...400, "Thousand/uL"),
	"MPV": .init("Mean Platelet Volume (MPV)", 7.5...12.5, "fL"),
	"ABSOLUTE NEUTROPHILS": .init("Absolute Neutrophil Count (ANC)", 1500...7800, "cells/uL"),
//	"ABSOLUTE BAND NEUTROPHILS": .init("Absolute Immature Neutrophil Count", 0...750, "cells/uL"),
	
	"CHOLESTEROL, TOTAL": .init("Total Cholesterol", 40...200, "mg/dL"),
	"HDL CHOLESTEROL": .init("High-density lipoprotein (HDL) Cholesterol", 50...200, "mg/dL"),
	"LDL CHOLESTEROL": .init("Low-density lipoprotein (LDL) Cholesterol", 0...100, "mg/dL"),
	"TRIGLYCERIDES": .init("Triglycerides", 0...150, "mg/dL")
]

let biomarkerKeys = [
	"HS CRP",
	"GLUCOSE",
	"UREA NITROGEN (BUN)",
	"CREATININE",
	"eGFR NON-AFR. AMERICAN",
	"eGFR AFRICAN AMERICAN",
	"BUN/CREATININE RATIO",
	"SODIUM",
	"POTASSIUM",
	"CHLORIDE",
	"CARBON DIOXIDE",
	"CALCIUM",
	"PROTEIN, TOTAL",
	"ALBUMIN",
	"GLOBULIN",
	"ALBUMIN/GLOBULIN RATIO",
	"BILIRUBIN, TOTAL",
	"ALKALINE PHOSPHATASE",
	"AST",
	"ALT",
	"HEMOGLOBIN A1c",
	"eAG",
	"VITAMIN D,25-OH,TOTAL,IA",
	"HOMOCYSTEINE",
	"T3, FREE",
	"FERRITIN",
	"FIBRINOGEN ACTIVITY, CLAUSS",
	"GGT",
	"INSULIN",
	"LD",
	"MAGNESIUM",
	"WHITE BLOOD CELL COUNT",
	"RED BLOOD CELL COUNT",
	"HEMOGLOBIN",
	"HEMATOCRIT",
	"MCV",
	"MCH",
	"MCHC",
	"RDW",
	"PLATELET COUNT",
	"MPV",
	"ABSOLUTE NEUTROPHILS",
//	"ABSOLUTE BAND NEUTROPHILS",
	
	"CHOLESTEROL, TOTAL",
	"HDL CHOLESTEROL",
	"LDL CHOLESTEROL",
	"TRIGLYCERIDES"
]
