import SwiftUI

let defaults = UserDefaults.standard

var seen: Bool {
    get { defaults.bool(forKey: "seen") }
    set { defaults.setValue(newValue, forKey: "seen") }
}

@main
struct NutritionLabSurveyApp: App {
	var body: some Scene {
		WindowGroup {
            NavigationView {
                if seen {
                    HomeView()
                } else {
                    LandingView()
                }
            }
		}
	}
}
