import SwiftUI

struct Action: View {
    let label: String
    let disabled: Bool
    let action: () -> Void
    
    init(label: String, disabled: Bool = false, action: @escaping () -> Void) {
        self.label = label
        self.disabled = disabled
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .bold()
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(Color(#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)))
                .cornerRadius(12)
                .opacity(disabled ? 0.5 : 1)
        }
        .disabled(disabled)
    }
}
