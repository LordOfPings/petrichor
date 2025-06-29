import SwiftUI

// MARK: - Card Container Component
struct CardContainer<Content: View>: View {
    let content: Content
    var padding: CGFloat = 16
    var cornerRadius: CGFloat = 16
    var backgroundColor: Color = .neutralsWhite
    var borderColor: Color = .neutralsGrey300
    var borderWidth: CGFloat = 1
    var shadow: Bool = false
    
    init(
        padding: CGFloat = 16,
        cornerRadius: CGFloat = 16,
        backgroundColor: Color = .neutralsWhite,
        borderColor: Color = .neutralsGrey300,
        borderWidth: CGFloat = 1,
        shadow: Bool = false,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.padding = padding
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.shadow = shadow
    }
    
    var body: some View {
        content
            .padding(padding)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
            .shadow(
                color: shadow ? .black.opacity(0.1) : .clear,
                radius: shadow ? 4 : 0,
                x: 0,
                y: shadow ? 2 : 0
            )
    }
}

#Preview("Card Container") {
    VStack(spacing: 20) {
        CardContainer {
            VStack(alignment: .leading, spacing: 8) {
                Text("Weather Alert")
                    .headlineStyle()
                    .foregroundColor(.petrichorText)
                
                Text("Temperature is too hot for outdoor activities with pets.")
                    .bodyStyle()
                    .foregroundColor(.petrichorTextSecondary)
            }
        }
        
        CardContainer(
            backgroundColor: .brandPrimary100,
            borderColor: .petrichorPrimary,
            borderWidth: 2,
            shadow: true
        ) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Premium Feature")
                        .title3()
                        .foregroundColor(.petrichorPrimary)
                    
                    Text("Get advanced weather insights")
                        .bodyStyle()
                        .foregroundColor(.petrichorText)
                }
                
                Spacer()
                
                Image(systemName: "star.fill")
                    .foregroundColor(.petrichorPrimary)
                    .font(.title2)
            }
        }
        
        CardContainer(
            padding: 20,
            cornerRadius: 24,
            backgroundColor: .weatherSafeLight.opacity(0.3),
            borderColor: .weatherSafe,
            borderWidth: 2
        ) {
            Text("Perfect weather for walks! 🐕")
                .title3()
                .foregroundColor(.weatherSafeDark)
        }
        
        Spacer()
    }
    .padding()
    .background(Color.brandPrimary100.opacity(0.3))
}
