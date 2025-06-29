import SwiftUI

struct Button: View {
    // Just the button component code
}

#Preview {
    VStack(spacing: 12) {
        Button(title: "Primary", action: {})
        Button(title: "Secondary", action: {}, style: .secondary)
        Button(title: "Outline", action: {}, style: .outline)
    }
    .padding()
}
