import SwiftUI

struct FilePicker: UIViewControllerRepresentable {
    final class Coordinator: NSObject, UIDocumentBrowserViewControllerDelegate {
        let parent: FilePicker
        
        init(_ parent: FilePicker) {
            self.parent = parent
        }
        
        func documentBrowser(
            _ controller: UIDocumentBrowserViewController,
            didPickDocumentsAt urls: [URL]
        ) {
            urls.first.map(parent.onUrl)
        }
    }
    
    let onUrl: (URL) -> Void
    
    func makeCoordinator() -> Coordinator {
        .init(self)
    }
    
    func makeUIViewController(context: Context) -> UIDocumentBrowserViewController {
        let viewController = UIDocumentBrowserViewController()
        
        viewController.delegate = context.coordinator
        
        viewController.allowsDocumentCreation = false
        viewController.allowsPickingMultipleItems = false
        
        return viewController
    }
    
    func updateUIViewController(
        _ viewController: UIDocumentBrowserViewController,
        context: Context
    ) {}
}
