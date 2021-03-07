import SwiftUI
import ResearchKit

struct Survey: UIViewControllerRepresentable {
	final class Coordinator: NSObject, ORKTaskViewControllerDelegate {
		let parent: Survey
		
		init(_ parent: Survey) {
			self.parent = parent
		}
		
		func taskViewController(
			_ taskViewController: ORKTaskViewController,
			didFinishWith reason: ORKTaskViewControllerFinishReason,
			error: Error?
		) {
			parent.onDone(taskViewController.result)
		}
	}
	
	let task: ORKTask
	let onDone: (ORKTaskResult) -> Void
	
	func makeCoordinator() -> Coordinator {
		.init(self)
	}
	
	func makeUIViewController(context: Context) -> ORKTaskViewController {
		let viewController = ORKTaskViewController(task: task, taskRun: nil)
		viewController.delegate = context.coordinator
		
		return viewController
	}
	
	func updateUIViewController(
		_ viewController: ORKTaskViewController,
		context: Context
	) {}
}
