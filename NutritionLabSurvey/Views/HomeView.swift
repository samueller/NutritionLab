import SwiftUI
import SafariServices
import ResearchKit
import HealthKit
import CareKitUI
//import GameKit

struct HomeView: View {
	static let task: ORKTask = {
        func stringsToTextChoices(_ strings: [String]) -> [ORKTextChoice] {
            var result: [ORKTextChoice] = []
            for (i, string) in strings.enumerated() {
                result.append(ORKTextChoice(text: string, value: NSNumber(value: i+1)))
            }
            return result
        }
        
//        let tree = GKDecisionTree(attribute: "Muscle cramps" as NSObjectProtocol)
//        let root = tree.rootNode
//        root?.createBranch(value: true, attribute: "Vegetables" as NSObjectProtocol)
//        let highLdl = root?.createBranch(value: false, attribute: "LDL > 200" as NSObjectProtocol)
//        highLdl?.createBranch(value: true, attribute: "Eat less saturated and trans fats" as NSObjectProtocol)
//        highLdl?.createBranch(value: false, attribute: "Good" as NSObjectProtocol)
//        let answers = ["Muscle cramps" : true]
//        let decisionAction = tree.findAction(forAnswers: answers as [AnyHashable : NSObjectProtocol])
//        print("Answer: \(String(describing: decisionAction!))")

		let frequencyChoices = [
			ORKTextChoice(text: "Less than once per month", value: NSNumber(1)),
			ORKTextChoice(text: "Once per month to once per week", value: NSNumber(2)),
			ORKTextChoice(text: "More than 1 up to 2 times per week", value: NSNumber(3)),
			ORKTextChoice(text: "More than 2 up to 6 times per week", value: NSNumber(4)),
			ORKTextChoice(text: "Once or twice per day", value: NSNumber(5)),
			ORKTextChoice(text: "More than 2 up to 6 times per day", value: NSNumber(6)),
			ORKTextChoice(text: "More than 6 times per day", value: NSNumber(7))
		]
		let yearsChoices = [
			ORKTextChoice(text: "No, or yes for up to 1 year", value: NSNumber(1)),
			ORKTextChoice(text: "Yes, for over 1 and up to 5 years", value: NSNumber(2)),
			ORKTextChoice(text: "Yes, for over 5 and up to 10 years", value: NSNumber(3)),
			ORKTextChoice(text: "Yes, for over 10 years", value: NSNumber(4)),
		]
		let pointScale = [
			ORKTextChoice(text: "Never", value: NSNumber(0)),
			ORKTextChoice(text: "Rarely", value: NSNumber(1)),
			ORKTextChoice(text: "Occasionally", value: NSNumber(2)),
			ORKTextChoice(text: "Frequently", value: NSNumber(3)),
			]
        let foodChoices = stringsToTextChoices([
            "Candy",
            "Fast food",
            "Milk, dairy, cheese, or ice cream",
            "Sodas with sugar",
            "Fake sugar products",
            "Cheese",
            "Sugary treats or desserts",
            "Bread",
            "Pizza",
            "Chips, pretzels, or salty snacks",
            "Diet sodas",
            "Wine, beer, or liquor"
        ])

		var steps = [ORKStep]()
		
		func titleToId(_ string: String) -> String {
			let words: [String] = string.components(separatedBy: " ")
			return ([words[0].lowercased()] + words.dropFirst()).joined(separator: "")
		}
		
		func createStep(_ title: String, _ question: String, _ textChoices: [ORKTextChoice]?) -> ORKQuestionStep {
			let titleWords: [String] = title.components(separatedBy: " ")
			let identifier: String = ([titleWords[0].lowercased()] + titleWords.dropFirst()).joined(separator: "")
			let step = ORKQuestionStep(identifier: identifier, title: title, question: question, answer: .choiceAnswerFormat(with: .singleChoice, textChoices: textChoices ?? yearsChoices))
			step.isOptional = false
			steps.append(step)
			return step
		}
		
		func createFrequencyStep(_ title: String, _ question: String) -> ORKQuestionStep {
			return createStep(title, question, frequencyChoices)
		}

		func createYearsStep(_ title: String, _ question: String) -> ORKQuestionStep {
			let titleWords: [String] = title.components(separatedBy: " ")
			let identifier: String = ([titleWords[0].lowercased()] + titleWords.dropFirst()).joined(separator: "")
			let step = ORKQuestionStep(identifier: identifier, title: title, question: question, answer: .choiceAnswerFormat(with: .singleChoice, textChoices: yearsChoices))
			step.isOptional = false
			steps.append(step)
			return step
		}
		
        func createPointScaleGroup(_ title: String, _ optional: Bool, _ questions: [String]) -> ORKFormStep {
			let formStep = ORKFormStep(identifier: titleToId(title), title: title, text: nil)
			formStep.isOptional = optional
			var formItems = [ORKFormItem(sectionTitle: "Select frequency")]
			for question in questions {
				let item = ORKFormItem(identifier: titleToId(question), text: "\(question) ", detailText: nil, learnMoreItem: nil, showsProgress: true, answerFormat: .valuePickerAnswerFormat(with: pointScale), tagText: nil, optional: false)
				formItems.append(item)
			}
			formStep.formItems = formItems
			steps.append(formStep)
			return formStep
		}

        func createYesNoGroup(_ title: String, _ optional: Bool, _ questions: [String]) -> ORKFormStep {
            let formStep = ORKFormStep(identifier: titleToId(title), title: title, text: nil)
            formStep.isOptional = optional
            var formItems = [ORKFormItem(sectionTitle: "Select Yes or No")]
            for question in questions {
                let item = ORKFormItem(identifier: titleToId(question), text: "\(question) ", detailText: nil, learnMoreItem: nil, showsProgress: true, answerFormat: .booleanAnswerFormat(), tagText: nil, optional: false)
                formItems.append(item)
            }
            formStep.formItems = formItems
            steps.append(formStep)
            return formStep
        }

        func createScaleGroup(_ title: String, _ optional: Bool, _ maxDesc: String, _ minDesc: String, _ questions: [String]) -> ORKFormStep {
            let formStep = ORKFormStep(identifier: titleToId(title), title: title, text: nil)
            formStep.isOptional = optional
            var formItems = [ORKFormItem(sectionTitle: "Select ratings")]
            for question in questions {
                let item = ORKFormItem(identifier: titleToId(question), text: "\(question) ", detailText: nil, learnMoreItem: nil, showsProgress: true, answerFormat: .scale(withMaximumValue: 10, minimumValue: 0, defaultValue: 5, step: 1, vertical: false, maximumValueDescription: maxDesc, minimumValueDescription: minDesc), tagText: nil, optional: false)
                formItems.append(item)
            }
            formStep.formItems = formItems
            steps.append(formStep)
            return formStep
        }
        
        func createMultSelectionGroup(_ title: String, _ optional: Bool, _ questions: [String:[ORKTextChoice]]) -> ORKFormStep {
            let formStep = ORKFormStep(identifier: titleToId(title), title: title, text: nil)
            formStep.isOptional = optional
            var formItems = [ORKFormItem(sectionTitle: "Select all that apply")]
            for (question, choices) in questions {
                let item = ORKFormItem(identifier: titleToId(question), text: "\(question) ", detailText: nil, learnMoreItem: nil, showsProgress: true, answerFormat: .choiceAnswerFormat(with: .multipleChoice, textChoices: choices), tagText: nil, optional: false)
                formItems.append(item)
            }
            formStep.formItems = formItems
            steps.append(formStep)
            return formStep
        }

		let basicInfo = ORKFormStep(identifier: "basic", title: "Basic Information", text: nil)
		basicInfo.isOptional = false
		let personal = ORKFormItem(sectionTitle: "Personal")
		let name = ORKFormItem(identifier: "name", text: "Name ", detailText: nil, learnMoreItem: nil, showsProgress: true, answerFormat: .textAnswerFormat(), tagText: nil, optional: true)//false)
		name.placeholder = "Enter full name"
		let birthDate = ORKFormItem(identifier: "birth", text: "Birth date ", detailText: nil, learnMoreItem: nil, showsProgress: true, answerFormat: .dateAnswerFormat(), tagText: nil, optional: false)
		birthDate.placeholder = "DOB"
		let email = ORKFormItem(identifier: "email", text: "Email ", detailText: nil, learnMoreItem: nil, showsProgress: true, answerFormat: .emailAnswerFormat(), tagText: nil, optional: true)//false)
		email.placeholder = "Enter email address"
		let height = ORKFormItem(identifier: "height", text: "Height ", detailText: nil, learnMoreItem: nil, showsProgress: true, answerFormat: .heightAnswerFormat(), tagText: nil, optional: false)
		height.placeholder = "Enter height"
		let weight = ORKFormItem(identifier: "weight", text: "Weight ", detailText: nil, learnMoreItem: nil, showsProgress: true, answerFormat: .weightAnswerFormat(), tagText: nil, optional: false)
		weight.placeholder = "Enter weight"
		let gender = ORKFormItem(identifier: "gender", text: "Biological gender", detailText: nil, learnMoreItem: nil, showsProgress: true, answerFormat: ORKHealthKitCharacteristicTypeAnswerFormat(characteristicType: HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.biologicalSex)!), tagText: nil, optional: false)
		
		basicInfo.formItems = [personal, name, email, birthDate, height, weight, gender]
		
		steps += [basicInfo]
		
        let digestion = createPointScaleGroup("Digestion", true, [
			"Does eating greasy foods upset  \nyour system? ",
			"Do you get gastrointestinal issues  \nfrom eating fatty or greasy  \nfoods like fries or donuts? ",
			"Do you get gastrointestinal issues  \nfrom eating healthy fatty foods  \nlike avocados or nut butters? ",
			"Do you get nauseous when eating  \nfatty or greasy foods? ",
			"Do you get a headache over your  \neyes from eating greasy foods? ",
			"Do you feel dizzy within a few  \nhours after meals? ",
			"Do you have itchy skin and feet?",
			"Do you feel queasy or get a  \nheadache over your eyes after  \neating greasy foods? ",
			"Are your stools very light colored  \nbrown or yellow? ",
			"Do you have a bitter metallic taste  \nin your mouth when you wake up? ",
			"Have you had gallbladder attacks?",
			"Have you had gallstones?"
		])

		let cholesterol = createPointScaleGroup("Cholesterol", true, [
			"Has cholesterol been high?",
			"Have triglycerides been high?",
			"Are you concerned about cholesterol?",
			"Do you eat to avoid cholesterol?",
			"Has LDL cholesterol been high?",
			"Has HDL cholesterol been high?",
			"Is your doctor concerned \nabout cholesterol?"
		])
		
		let nose = createPointScaleGroup("Nose", true, [
            "Stuffy nose",
            "Sinus problems",
            "Hay fever",
            "Sneezing attacks",
            "Excessive mucus formation",
            "Lost sense of smell",
            "Snoring"
        ])
        
		let nutrients = createPointScaleGroup("Nutrients", true, [
            "Acid foods upset",
            "Wound up & difficult to relax",
            "Dry mouth, eyes, or nose",
            "Strong light irritates you",
            "Unable to relax & easily startled",
            "Slow healing of cuts & wounds",
            "Heart pounds after eating",
            "Joint stiffness",
            "Leg or toe muscle cramps at night",
            "Eyes blink too often",
            "Indigestion after meals",
            "Bruise easily",
            "Anemia",
            "Low iron",
            "Energy lower than it should be",
            "Nose bleeds with unknown cause",
            "Drowsy at random times",
            "Bone spurs",
            "Kidney stones",
            "Muscle cramps in legs",
            "Muscle cramps in general"
        ])
		let nails = createPointScaleGroup("Nails", true, [
            "Spoon shaped",
            "Brittle and cracking",
            "Discolored",
            "White spots",
            "Lines or stripes",
            "Peeling",
            "Nails don't grow",
            "Weak nails"
        ])
		let bloodSugar = createPointScaleGroup("Blood Sugar", true, [
            "Eat when nervous",
            "Still hungry right after meals",
            "Excessive appetite",
            "Irritable before meals",
            "Often hungry between meals",
            "Shaky when hungry",
            "Hungry most of the time",
            "Hangry when need to eat",
            "Eating helps feel less tired",
            "Eating helps feel more tired",
            "Lightheaded or dizzy when meals  \ndelayed ",
            "Heart palpitates with late or  \nmissed meals ",
            "Headaches in the morning",
            "Headaches in the afternoon",
            "Overeating sweets feels bad",
            "Nausea with sugary foods",
            "Wake after 2-4 hours of sleep",
            "Hard to go back to sleep when  \nwoken too early ",
            "Mood swings",
            "Anxiety or heart palpitations  \nwith too much sugar",
            "Depressed",
            "Crave sugary foods",
            "Need to snack",
            "Prefer to snack",
            "Eating breakfast increases hunger  \nall day ",
            "Must eat breakfast or will feel bad",
            "Yawn in afternoons",
            "Yawn frequently at all times",
            "Need a nap after lunch"
        ])
		let hair = createPointScaleGroup("Hair", true, [
            "Hair thinning",
            "Hair loss",
            "Loss of outer eyebrow hair",
            "Premature graying",
            "Hair breaks or is dry",
            "Poor or slow hair growth",
            "Loss of shine, volume, or body"
        ])
		let thyroid = createPointScaleGroup("Thyroid", true, [
            "Morning headaches then gone",
            "Sluggish in morning",
            "Weight gain",
            "Hard to lose weight",
            "Low appetite with weight gain",
            "Constipation",
            "Less than 1 regular bowel movement  \nper day ",
            "Stools like hard little rocks",
            "Mental sluggishness",
            "Brain fog",
            "Reduced motivation or initiative",
            "Dry scaly skin",
            "Feel cold",
            "Cold hands and feet",
            "Inability to lose weight dieting"
        ])
		let skin = createPointScaleGroup("Skin", true, [
            "Acne",
            "Dry skin",
            "Flushing",
            "Hives or rashes",
            "Bumps on back of arms",
            "Excessive sweating"
        ])
		let immuneSystem = createPointScaleGroup("Immune System", true, [
            "Get colds",
            "Get the flu",
            "Deal with chronic illness",
            "Ear aches or infections",
            "Immune system seems to overreact",
            "Immune system seems to underreact",
            "Get sick",
            "Cough",
            "Allergies"
        ])
		let yeastFungusGut = createPointScaleGroup("Yeast, Fungus, & Gut", true, [
            "Frequent or urgent urination",
            "Genital discharge",
            "Itching in genital or anal areas",
            "Itching all over body",
            "Eat sugary foods",
            "Crave sugary foods",
            "Low blood sugar if too long without  \neating ",
            "Mood swings",
            "White or brownish coating on tongue",
            "Poor memory",
            "Poor concentration",
            "Too much mucus in mouth or throat",
            "Sinus issues",
            "Need to clear throat"
        ])
		let heart = createPointScaleGroup("Heart", true, [
            "Irregular or skipped beats",
            "Chest pain",
            "Symptoms related to cardiac issues",
            "Shortness of breath upon exertion",
            "Open windows in a closed room",
            "Rapid or pounding heartbeat",
            "Concerned about cardiac health",
            "Numbness in hands, legs, or feet",
            "Severe breathlessness"
        ])
		let lungs = createPointScaleGroup("Lungs", true, [
            "Chest congestion",
            "Shortness of breath",
            "Asthma or bronchitis",
            "Difficulty breathing"
        ])
		let energy = createPointScaleGroup("Energy", true, [
            "Fatigue",
            "Lethargy",
            "Hyperactivity",
            "Insomonia",
            "Sleep disruptions",
            "Energy drops after meals",
            "Energy drops in afternoon",
            "Energy swings",
            "Wake up in middle of sleep",
            "Energy seems lower than should be",
            "Concerned aboout low energy",
            "Lack energy to do everything wanted"
        ])
		let digestiveTract = createPointScaleGroup("Digestive Tract", true, [
            "Nausea",
            "Vomiting",
            "Diarrhea",
            "Constipation",
            "Alternating diarrhea & constipation",
            "Bloating",
            "Belching",
            "Gas/flatulence",
            "Heartburn",
            "Upper GI pain",
            "Lower abdominal pain"
        ])
		let jointsMuscleBone = createPointScaleGroup("Joints, Muscle, & Bone", true, [
            "Pain/aches in joints",
            "Arthritis",
            "Stiffness/limited movement",
            "Pain/aches in muscles",
            "Weakness or strength loss",
            "Restless legs",
            "Bone pain",
            "Broken bones",
            "Muscle cramps"
        ])
		let weightLoss = createPointScaleGroup("Weight Loss", true, [
            "Weight gain over 5 lbs",
            "Fluid retention or swollen",
            "Hard to build muscle",
            "Concerned about muscle loss",
            "Concerned about being overweight",
            "On diets or weight loss programs"
        ])
		let moods = createPointScaleGroup("Moods", true, [
            "Anxiety, worry, fear, or nervousness",
            "Anger, irritability, or agitation",
            "Depression",
            "Mood affected by eating",
            "Mood affected by weight",
            "Mood affected by bloating",
            "Weight affected by mood",
            "Sugary foods causes irritability",
            "Diagnosed eating disorder",
            "Suspected eating disorder",
            "Weight or looks can ruin day or mood"
        ])
        
        let hunger = createScaleGroup("Hunger", false, "So hungry\nit hurts", "Zero\nhunger", [
            "How hungry are you before breakfast?",
            "How hungry are you at breakfast?",
            "How hungry are you at lunch?",
            "How hungry are you at snack time after lunch and before dinner?",
            "How hungry are you at dinner?",
            "How hungry are you after dinner?",
        ])
        
        let yesNo = createYesNoGroup("Simple Questions", true, [
            "Diagnosed with gastrointestinal issues?",
            "Suspected autoimmune issue?",
            "Diagnosed autoimmune issue?",
            "Suspect cardiac or heart issues?",
            "Heart or cardiac issues run in family?",
            "Diagnosed with heart or cardiac issues?",
            "Take medication regularly?",
            "Take medication occasionally or as needed?",
            "Diagnosed with thyroid issue?",
            "Suspected undiagnosed thyroid issue?",
            "Have an eating disorder?",
            "Gallbladder issues?",
            "Gallbladder removed?"
        ])
        
        let foods = createMultSelectionGroup("Foods", true, [
            "Which of the following do you eat less than once a month?": foodChoices,
            "Which of the following do you never eat or do your best to avoid?": foodChoices,
            "Which of the following do you eat more than once a month and less than once a day?": foodChoices,
            "Which of the following do you eat more than once a day?": foodChoices
        ])

//		let hair = createYearsStep("Hair Loss", "Do you suffer from hair loss?")
//		let drySkin = createYearsStep("Dry Skin", "Do you have dry skin?")
//		let itchySkin = createYearsStep("Itchy Skin", "Do you have itchy skin?")
//		let loseWeight = createYearsStep("Lose Weight", "Do you find it impossible to lose weight?")
//		let hardLoseWeight = createYearsStep("Difficulty Losing Weight", "Do you find it hard to lose weight?")
//		let eatReasons = createYearsStep("Eating Reasons", "Do you eat for reasons other than hunger?")
//		let hunger = createYearsStep("Hunger", "Do you feel hungry more often than at mealtimes?")
//		let overeating = createYearsStep("Overeating", "Do you overeat?")
//		let undereating = createYearsStep("Undereating", "Do you undereat?")
//		let energy = createYearsStep("Energy", "Do you have low energy?")
//
//		let fatigue = createFrequencyStep("Fatigue", "Do you have fatigue?")
//		let mood = createFrequencyStep("Mood", "Do you have mood swings?")
//		let sugar = createFrequencyStep("Sugar", "Do you crave sugary foods?")
//		let carbs = createFrequencyStep("Carbohydrates", "Do you crave high carbohydrate foods like bread, crackers, or cereal?")
//		let fat = createFrequencyStep("Fatty Food", "Do you crave high fat foods like avocado, olive oil, bruschetta, or peanut butter?")
//		let grease = createFrequencyStep("Grease", "Do you crave \"greasy foods\" like burgers, french fries, or donuts?")
//		let greasyUpset = createFrequencyStep("Grease Upset", "Do greasy foods upset your stomach?")
//		let pain = createFrequencyStep("Painful Food", "Do certain foods give you pain, bloating, or gassiness?")
//		let bloatedWakeUp = createFrequencyStep("Bloated Wake Up", "Do you wake up bloated?")
//		let bloatedBedtime = createFrequencyStep("Bloated Bedtime", "Do you go to bed bloated?")
//		let anemic = createFrequencyStep("Anemic", "Have you been told you are anemic?")
//		let urinationDay = createFrequencyStep("Urination During Day", "Do you frequently urinate during the day?")
//		let urinationNight = createFrequencyStep("Urination at Night", "Do you frequently urinate during at night or while trying to sleep?")
//		let wakeUp = createFrequencyStep("Wake up at night", "Do you often wake up in the middle of your sleep?")
//		let backToSleep = createFrequencyStep("Back to Sleep", "Do you find it hard tto go back to sleep if you wake up in the middle of your sleep?")
//		let racingMind = createFrequencyStep("Racing Mind", "Do you find it hard to fall asleep at night because of a racing mind?")
//		let bodyAwake = createFrequencyStep("Body Awake", "Do you find it hard to fall asleep at night because of your body feeling too awake?")
//		let tiredAwake = createFrequencyStep("Tired Awake", "Does your body feel tired but your mind feels awake at bedtime?")
//		let afterLunchNap = createFrequencyStep("After Lunch Nap", "Do you have an energy drop or often want to nap after lunch?")
//		let hungryBeforeBed = createFrequencyStep("Hungry Before Bed", "Are you most hungry before bed?")
//		let dessert = createFrequencyStep("Dessert", "Do you feel like eating dessert or snacks most often after breakfast or after dinner?")
//		let snackRegularly = createFrequencyStep("Snack Regularly", "Do you snack more than 3 times per day on most days?")
//		let desireSnacks = createFrequencyStep("Desire Snacks", "Do you want to snack often but are able to stop yourself?")
//		let sighs = createFrequencyStep("Frequent Sighs", "Do you frequently sigh or feel like you need to take a deep breath?")
//		let dizzy = createFrequencyStep("Dizzy", "Do you feel dizzy if you go too long without eating?")
//		let irritated = createFrequencyStep("Irritated", "Do you feel irritated if you go too long without eating?")
//		let skipMeals = createFrequencyStep("Skip Meals", "Can you skip meals without issues?")
//		let intermittentFasting = createFrequencyStep("Intermittent Fasting", "Are you able to intermittent fast?")

		let summary = ORKCompletionStep(identifier: "summary")
		summary.title = "Finished questionnaire!"
		summary.text = "The next step is to order your lab and visit a local Quest Diagnostics center to have your blood drawn. When you receive your lab results, save the PDF on your device and upload on this app. Then you'll see your personalized nutrition plan!"
		steps += [summary]
		
		return ORKOrderedTask(identifier: "task", steps: steps)
	}()
	
	@State var isSurveyShowing = false
	@State var isUploading = false
	@State var isViewingLabPlan = false
	
	@State var lab: Lab? = labs[0]
	@State var results: [String:Float]? = nil

	var body: some View {
		ZStack {
			Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1))
				.edgesIgnoringSafeArea(.all)
			VStack {
				Spacer()
				Action(label: "Start Questionnaire") {
					isSurveyShowing = true
				}
				.sheet(isPresented: $isSurveyShowing) {
					Survey(task: Self.task) { result in
						if let results = result.results, results.count > 5 {
							let answers: [Int] = results[1...4].compactMap { step in
								guard
									let questions = (step as? ORKStepResult)?.results,
									let question = questions.first as? ORKChoiceQuestionResult,
									let answer = (question.answer as? [Int])?.first
								else { return nil }
								
								return answer
							}
							
							if let answer = answers.first {
                                if answer > 0 {
                                    lab = labs[answer - 1]
                                }
							}
						}
						
						isSurveyShowing = false
					}
					.edgesIgnoringSafeArea(.all)
				}
				Spacer()
				if let lab = lab {
					Action(label: "Order \(lab.name) lab") {
						UIViewController.current?.present(
							SFSafariViewController(url: lab.url),
							animated: true
						)
					}
					Spacer()
				}
				Action(label: "Upload Lab Results", disabled: lab == nil) {
					isUploading = true
				}
				.sheet(isPresented: $isUploading, onDismiss: {
					isUploading = false
				}) {
					FilePicker { url in
//							do {
//								let contents = try Data(contentsOf: url)
//								print("contents")
//								print(String(decoding: contents.prefix(1000), as: UTF8.self))
//							} catch {
//								print("Error \(error)")
//							}
//							print(url.absoluteString)
						if let pdf = PDFDocument(url: url) {
							let pageCount = pdf.pageCount
							let documentContent = NSMutableAttributedString()

							for i in 1 ..< pageCount {
								guard let page = pdf.page(at: i) else { continue }
								guard let pageContent = page.attributedString else { continue }
								documentContent.append(pageContent)
							}
							print("Page count: \(pageCount)")
							print("Content: \(documentContent)")
						}
						isUploading = false
						results = [
							"HS CRP": 0.6,
							"GLUCOSE": 63,
							"UREA NITROGEN (BUN)": 16,
							"CREATININE": 0.75,
							"eGFR NON-AFR. AMERICAN": 97,
							"eGFR AFRICAN AMERICAN": 112,
							"BUN/CREATININE RATIO": 21.3,
							"SODIUM": 137,
							"POTASSIUM": 4.1,
							"CHLORIDE": 102,
							"CARBON DIOXIDE": 27,
							"CALCIUM": 9.3,
							"PROTEIN, TOTAL": 6.8,
							"ALBUMIN": 4.5,
							"GLOBULIN": 2.3,
							"ALBUMIN/GLOBULIN RATIO": 2,
							"BILIRUBIN, TOTAL": 0.5,
							"ALKALINE PHOSPHATASE": 61,
							"AST": 19,
							"ALT": 16,
							"HEMOGLOBIN A1c": 5.3,
							"eAG": 105,
							"VITAMIN D,25-OH,TOTAL,IA": 53,
							"HOMOCYSTEINE": 7,
							"T3, FREE": 2.6,
							"FERRITIN": 44,
							"FIBRINOGEN ACTIVITY, CLAUSS": 292,
							"GGT": 9,
							"INSULIN": 2.4,
							"LD": 170,
							"MAGNESIUM": 2.1,
							"WHITE BLOOD CELL COUNT": 5,
							"RED BLOOD CELL COUNT": 4.06,
							"HEMOGLOBIN": 12.9,
							"HEMATOCRIT": 39.2,
							"MCV": 96.6,
							"MCH": 31.8,
							"MCHC": 32.9,
							"RDW": 11.7,
							"PLATELET COUNT": 320,
							"MPV": 10.5,
							"ABSOLUTE NEUTROPHILS": 2960,
//							"ABSOLUTE BAND NEUTROPHILS",
							
							"CHOLESTEROL, TOTAL": 260,
							"HDL CHOLESTEROL": 63,
							"LDL CHOLESTEROL": 181,
							"TRIGLYCERIDES": 61
						]
						isViewingLabPlan = true
					} onDismiss: {
						isUploading = false
					}
				}.edgesIgnoringSafeArea(.all)
				Spacer()
				Action(label: "View Lab and Nutrition Plan", disabled: results == nil) {
					isViewingLabPlan = true
				}
				.sheet(isPresented: $isViewingLabPlan, onDismiss: {
					isViewingLabPlan = false
				}) {
                    ScrollView {
                        VStack(alignment: HorizontalAlignment.leading, spacing: 10) {
                            Section(header: Text("Lab Results").font(.title).foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.75))) {
                                VStack(spacing: 40) {
                                    ForEach(biomarkers) { biomarker in
                                        let result = results![biomarker.id]!
                                        
                                        VStack(alignment: .leading, spacing: 6) {
                                            Text(biomarker.name)
                                                .bold()
                                            BulletGraph(
                                                width: UIScreen.main.bounds.size.width - 20 * 2,
                                                range: biomarker.refRange,
                                                value: result,
                                                units: biomarker.units
                                            )
                                        }
                                    }
                                }
                                .padding(.top, 60)
                            }
                            Divider()
    //						Section(header: Text("Nutrition").font(.title).foregroundColor(Color(red: 0.5, green: 0.25, blue: 0)), content: {
                            Section(header: Text("Nutrition").font(.title).foregroundColor(Color(red: 0.5, green: 0.25, blue: 0))) {
                                Section(header: Text("Blood Sugar").font(.title2)) {
                                    Text("Limit processed carbohydrates and foods with added sugar to support healthy blood sugar response. Eliminate high sugar drinks including soda and fruit juice.")
    //                                Text("Eat macronutrient balanced meals that contain protein healthy fats, non-processed carbohydrates like whole fruit, potato, rice and beans.")
                                    Text("Eat macronutrient balanced meals that contain protein healthy fats, non-processed carbohydrates like:")
                                    VStack(alignment: .leading, spacing: 0) {
                                        HStack(spacing: 0) {
                                            Text("• ")
                                            SearchLink(query: "Whole fruit") {
                                                Text("Whole fruit")
                                            }
                                        }
                                        Text("• Potato")
                                        Text("• Rice and beans")
                                    }
                                    Text("Limit grains and high glycemic foods like candy, cookies, breads, crackers, and dried fruit. Limit alcohol until blood sugar is back in range and only drink alcohol with a macro balanced meal. Plan meals to combine protein, healthy fats, and vegetables with each carbohydrate serving to add fiber and to slow down the effect of carbohydrates in your system. Do not eat carbohydrates like fruit alone. Try to snack on healthy fat and protein instead of sugars. Increase protein, vegetables, and healthy fat amounts in meals in order to eliminate the need to snack or graze all day.")
                                    HStack(spacing: 0) {
                                        Text("Eat ")
                                        Button("macro balanced meals") {}
                                        Text(" and avoid grazing.")
                                    }
                                    Text("Keep non-processed and non-veggie carbohydrates at less than 90 grams per day to avoid weight gain and improve blood sugar.")
                                    Text("Optionally keep non-processed and non-veggie carbohydrates at less than or equal to 60 grams per day to lose weight")
                                }
                                Divider()
                                Section(header: Text("Low Blood Sugar and High Cholesterol").font(.title2)) {
    //							Section(header: Text("Low Blood Sugar and High Cholesterol").font(.title2), content: {
                                    Text("Add healthy fats and consider eating smaller meals more often to avoid blood sugar crashes. You may want to work with a professional to get your blood sugar back in balance if you are crashing too often.")
                                    Text("It's important with blood sugar crashes that you only eat carbohydrates that are lower on the glycemic scale and less processed. You may need 4 to 6 smaller meals with your macro amounts of protein, complex carbs, healthy fats, and vegetables.")
                                    HStack(spacing: 0) {
                                        Text("Optionally add a ")
                                        Button("protein shake") {}
                                    }
                                    Text("or higher protein with vegetable snack at times when your blood sugar usually crashes. Fix meals, like lunch, that precede a crash.")
    //                                Text("You can also add a protein shake or higher protein with vegetable snack at times when your blood sugar usually crashes. Fix meals, like lunch, that precede a crash.")
                                }
                                Divider()
                                Section(header: Text("Vitamins & Supplements").font(.title2)) {
    //								VStack {
                                    Text("Vitamin A: 700 mcg/day")
                                    Text("Vitamin C: 75 mg/day")
                                    Text("Vitamin D: 15 mcg/day (600 IU/day)")
                                    Text("Vitamin E: 15 mg/day (22.4 IU/day)")
                                    Text("Thiamin B1: 1.1 mg/day")
                                    Text("Riboflavin B2: 1.1 mg/day")
                                    Text("Niacin as Niacinamide or Niacin: 14 mg/day")
                                    Text("Vitamin B6: 1.3 mg/day")
                                    Text("Folic Acid (Folate): 400 mcg/day")
                                    Text("Vitamin B12 as Methylcobalamin: 1.8 mcg")
    //								Text("Biotin: ")
    //								Text("Pantothenic Acid: ")
    //								Text("Calcium: ")
    //								Text("Magnesium: ")
    //								Text("Zinc as Zinc Picolinate: ")
    //								Text("Selenium as Selenomethionine: ")
    //								Text("Copper: ")
    //								Text("Manganese: ")
    //								Text("Chromium: ")
    //								Text("Potassium: ")
    //								Text("Vanadium: ")
    //								Text("L-Carnitine: ")
    //								Text("Omega 3 - EPA/DHA: ")
    //								}
                                }
                                Divider()
                                Section(header: Text("Lifestyle").font(.title2)) {
                                    Text("Get movement every day, at least every 3-4 hours if you can.")
                                    Text("If your job is sedentary, a standing desk can help.")
                                    Text("Work with someone to get your blood sugar in balance if you can't do it yourself.")
                                    Text("Once your blood sugar is more balanced you should be able to exercise or at least stretch or walk without eating first.")
                                    HStack(spacing: 0) {
                                        Text("Work on ")
                                        Button("deep breathing") {}
                                        Text(" and ")
                                        Button("stress relief") {}
                                        Text(".")
                                    }
    //								Text("Generally work on deep breathing and stress relief.")
                                    Text("Stress can affect all of your lab results. Try to do some calming meditation before your blood draw, especially if you get stressed out by labs or blood draws.")
                                }
                            }
						}.padding()
					}
				}
				Spacer()
			}
			.padding(.horizontal)
		}
        .navigationBarBackButtonHidden(true)
		.navigationBarTitle("Nutrition Lab")
	}
}

struct HomeView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView()
	}
}
