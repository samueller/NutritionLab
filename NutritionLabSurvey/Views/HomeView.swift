import SwiftUI
import SafariServices
import ResearchKit
import HealthKit

struct HomeView: View {
    static let task: ORKTask = {
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
        
        var steps = [ORKStep]()
        
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
        
        basicInfo.formItems = [personal, name, birthDate, email, height, weight, gender]
        
        steps += [basicInfo]
        
        let hair = createYearsStep("Hair Loss", "Do you suffer from hair loss?")
        let drySkin = createYearsStep("Dry Skin", "Do you have dry skin?")
        let itchySkin = createYearsStep("Itchy Skin", "Do you have itchy skin?")
        let loseWeight = createYearsStep("Lose Weight", "Do you find it impossible to lose weight?")
        let hardLoseWeight = createYearsStep("Difficulty Losing Weight", "Do you find it hard to lose weight?")
        let eatReasons = createYearsStep("Eating Reasons", "Do you eat for reasons other than hunger?")
        let hunger = createYearsStep("Hunger", "Do you feel hungry more often than at mealtimes?")
        let overeating = createYearsStep("Overeating", "Do you overeat?")
        let undereating = createYearsStep("Undereating", "Do you undereat?")
        let energy = createYearsStep("Energy", "Do you have low energy?")
        
        let fatigue = createFrequencyStep("Fatigue", "Do you have fatigue?")
        let mood = createFrequencyStep("Mood", "Do you have mood swings?")
        let sugar = createFrequencyStep("Sugar", "Do you crave sugary foods?")
        let carbs = createFrequencyStep("Carbohydrates", "Do you crave high carbohydrate foods like bread, crackers, or cereal?")
        let fat = createFrequencyStep("Fatty Food", "Do you crave high fat foods like avocado, olive oil, bruschetta, or peanut butter?")
        let grease = createFrequencyStep("Grease", "Do you crave \"greasy foods\" like burgers, french fries, or donuts?")
        let greasyUpset = createFrequencyStep("Grease Upset", "Do greasy foods upset your stomach?")
        let pain = createFrequencyStep("Painful Food", "Do certain foods give you pain, bloating, or gassiness?")
        let bloatedWakeUp = createFrequencyStep("Bloated Wake Up", "Do you wake up bloated?")
        let bloatedBedtime = createFrequencyStep("Bloated Bedtime", "Do you go to bed bloated?")
        let anemic = createFrequencyStep("Anemic", "Have you been told you are anemic?")
        let urinationDay = createFrequencyStep("Urination During Day", "Do you frequently urinate during the day?")
        let urinationNight = createFrequencyStep("Urination at Night", "Do you frequently urinate during at night or while trying to sleep?")
        let wakeUp = createFrequencyStep("Wake up at night", "Do you often wake up in the middle of your sleep?")
        let backToSleep = createFrequencyStep("Back to Sleep", "Do you find it hard tto go back to sleep if you wake up in the middle of your sleep?")
        let racingMind = createFrequencyStep("Racing Mind", "Do you find it hard to fall asleep at night because of a racing mind?")
        let bodyAwake = createFrequencyStep("Body Awake", "Do you find it hard to fall asleep at night because of your body feeling too awake?")
        let tiredAwake = createFrequencyStep("Tired Awake", "Does your body feel tired but your mind feels awake at bedtime?")
        let afterLunchNap = createFrequencyStep("After Lunch Nap", "Do you have an energy drop or often want to nap after lunch?")
        let hungryBeforeBed = createFrequencyStep("Hungry Before Bed", "Are you most hungry before bed?")
        let dessert = createFrequencyStep("Dessert", "Do you feel like eating dessert or snacks most often after breakfast or after dinner?")
        let snackRegularly = createFrequencyStep("Snack Regularly", "Do you snack more than 3 times per day on most days?")
        let desireSnacks = createFrequencyStep("Desire Snacks", "Do you want to snack often but are able to stop yourself?")
        let sighs = createFrequencyStep("Frequent Sighs", "Do you frequently sigh or feel like you need to take a deep breath?")
        let dizzy = createFrequencyStep("Dizzy", "Do you feel dizzy if you go too long without eating?")
        let irritated = createFrequencyStep("Irritated", "Do you feel irritated if you go too long without eating?")
        let skipMeals = createFrequencyStep("Skip Meals", "Can you skip meals without issues?")
        let intermittentFasting = createFrequencyStep("Intermittent Fasting", "Are you able to intermittent fast?")

        let summary = ORKCompletionStep(identifier: "summary")
        summary.title = "Finished questionnaire!"
        summary.text = "The next step is to order your lab and visit a local Quest Diagnostics center to have your blood drawn. Several days later you'll get an email with your lab results. Save the PDF on your device and upload on this app. Then you'll receive your personalized nutrition plan!"
        steps += [summary]
        
        return ORKOrderedTask(identifier: "task", steps: steps)
    }()
    
    @State var isSurveyShowing = false
    @State var isUploading = false
    
    @State var lab: Lab?

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
                                lab = labs[answer - 1]
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
                .sheet(isPresented: $isUploading) {
                    FilePicker { url in
                        print(url)
                        
                        isUploading = false
                    }
                    .edgesIgnoringSafeArea(.all)
                }
                Spacer()
                Action(label: "View Lab and Nutrition Plan", disabled: true) {
                    print("View Lab and Nutrition Plan")
                }
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
