import SwiftUI
import MobileCoreServices
import UniformTypeIdentifiers

final class FilePicker: UIViewControllerRepresentable {
    final class Coordinator: NSObject, UIDocumentPickerDelegate {
        let parent: FilePicker
        
        init(_ parent: FilePicker) {
            self.parent = parent
        }
        
        func documentPicker(
            _ controller: UIDocumentPickerViewController,
            didPickDocumentsAt urls: [URL]
        ) {
            parent.callback(urls[0])
            parent.onDismiss()
        }
        
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            parent.onDismiss()
        }
    }
    
    let callback: (URL) -> Void
    let onDismiss: () -> Void

    init(callback: @escaping (URL) -> Void, onDismiss: @escaping () -> Void) {
        self.callback = callback
        self.onDismiss = onDismiss
    }

    func makeCoordinator() -> Coordinator {
        .init(self)
    }

    func updateUIViewController(
        _ uiViewController: UIDocumentPickerViewController,
        context: Context
    ) {}

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let controller = UIDocumentPickerViewController(
            forOpeningContentTypes: [.pdf],
            asCopy: true
        )
        
        controller.delegate = context.coordinator
        controller.allowsMultipleSelection = false
        
        return controller
    }
}
