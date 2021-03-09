import Foundation

struct Biomarker: Identifiable {
	let id: String
	let name: String
	let refRange: ClosedRange<Float>
	let units: String
	
	init(_ id: String, _ name: String, _ refRange: ClosedRange<Float>, _ units: String) {
		self.id = id
		self.name = name
		self.refRange = refRange
		self.units = units
	}
}

let biomarkers: [Biomarker] = [
	.init("HS CRP", "High-sensitivity C-reactive Protein", 0.0...3.1, "mg/L"),
	.init("GLUCOSE", "Glucose", 65...99, "mg/dL"),
	.init("UREA NITROGEN (BUN)", "Blood Urea Nitrogen (BUN)", 7...25, "mg/dL"),
	.init("CREATININE", "Creatinine", 0.5...1.1, "mg/dL"),
	.init("eGFR NON-AFR. AMERICAN", "Estimated Glomerular Filtration Rate Non-African American", 0...60, "mL/min per 1.73 m²"),
	.init("eGFR AFRICAN AMERICAN", "Estimated Glomerular Filtration Rate African American", 0...60, "mL/min per 1.73 m²"),
	.init("BUN/CREATININE RATIO", "BUN/Creatinine Ratio", 6...22, ""),
	.init("SODIUM", "Sodium", 135...146, "mmol/L"),
	.init("POTASSIUM", "Potassium", 3.5...5.3, "mmol/L"),
	.init("CHLORIDE", "Chloride", 98...110, "mmol/L"),
	.init("CARBON DIOXIDE", "Carbon Dioxide", 20...32, "mmol/L"),
	.init("CALCIUM", "Calcium", 8.6...10.2, "mg/dL"),
	.init("PROTEIN, TOTAL", "Total Protein", 6.1...8.1, "g/dL"),
	.init("ALBUMIN", "Albumin", 3.6...5.1, "g/dL"),
	.init("GLOBULIN", "Globulin", 1.9...3.7, "g/dL"),
	.init("ALBUMIN/GLOBULIN RATIO", "Albumin/Globulin Ratio", 1.0...2.5, ""),
	.init("BILIRUBIN, TOTAL", "Total Bilirubin", 0.2...1.2, "mg/dL"),
	.init("ALKALINE PHOSPHATASE", "Alkaline Phosphatase", 31...125, "U/L"),
	.init("AST", "Aspartate Transaminase", 10...30, "U/L"),
	.init("ALT", "Alanine Transaminase", 6...29, "U/L"),
	.init("HEMOGLOBIN A1c", "Hemoglobin A1c", 4...6, "%"),
	.init("eAG", "Estimated Average Glucose", 70...126, "mg/dL"),
	.init("VITAMIN D,25-OH,TOTAL,IA", "25-hydroxyvitamin D AKA Calcidiol", 30...100, "ng/mL"),
	.init("HOMOCYSTEINE", "Homocysteine", 0...10.4, "umol/L"),
	.init("T3, FREE", "Free Triiodothyronine", 2.3...4.2, "pg/mL"),
	.init("FERRITIN", "Ferritin", 16...232, "ng/mL"),
	.init("FIBRINOGEN ACTIVITY, CLAUSS", "Fibrinogen Activity (Clauss)", 175...425, "mg/dL"),
	.init("GGT", "Gamma-Glutamyl Transferase (GGT)", 3...55, "U/L"),
	.init("INSULIN", "Insulin", 0...19.6, "uIU/mL"),
	.init("LD", "Lactate Dehydrogenase (LDH)", 100...200, "U/L"),
	.init("MAGNESIUM", "Magnesium", 1.5...2.5, "mg/dL"),
	.init("WHITE BLOOD CELL COUNT", "White Blood Cell Count", 3.8...10.8, "Thousand/uL"),
	.init("RED BLOOD CELL COUNT", "Red Blood Cell Count", 3.8...5.1, "Million/uL"),
	.init("HEMOGLOBIN", "Hemoglobin", 11.7...15.5, "g/dL"),
	.init("HEMATOCRIT", "Hematocrit (% of Red Blood Cells)", 35...45, "%"),
	.init("MCV", "Mean Corpuscular Volume (MCV)", 80...100, "fL"),
	.init("MCH", "Mean Corpuscular Hemoglobin (MCH)", 27...33, "pg"),
	.init("MCHC", "Mean Corpuscular Hemoglobin Concentration (MCHC)", 32...36, "g/dL"),
	.init("RDW", "Red Cell Distribution Width (RDW)", 11...15, "%"),
	.init("PLATELET COUNT", "Platelet Count", 140...400, "Thousand/uL"),
	.init("MPV", "Mean Platelet Volume (MPV)", 7.5...12.5, "fL"),
	.init("ABSOLUTE NEUTROPHILS", "Absolute Neutrophil Count (ANC)", 1500...7800, "cells/uL"),
//	.init("ABSOLUTE BAND NEUTROPHILS", "Absolute Immature Neutrophil Count", 0...750, "cells/uL"),
	.init("CHOLESTEROL, TOTAL", "Total Cholesterol", 40...200, "mg/dL"),
	.init("HDL CHOLESTEROL", "High-density lipoprotein (HDL) Cholesterol", 50...200, "mg/dL"),
	.init("LDL CHOLESTEROL", "Low-density lipoprotein (LDL) Cholesterol", 0...100, "mg/dL"),
	.init("TRIGLYCERIDES", "Triglycerides", 0...150, "mg/dL"),
]
