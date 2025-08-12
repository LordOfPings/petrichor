import SwiftUI

// MARK: - Selection Card Component
struct SelectionCard<Content: View>: View {
    let title: String
    let subtitle: String
    let isSelected: Bool
    let action: () -> Void
    let accessoryContent: () -> Content
    
    init(
        title: String,
        subtitle: String,
        isSelected: Bool,
        action: @escaping () -> Void,
        @ViewBuilder accessoryContent: @escaping () -> Content = { EmptyView() }
    ) {
        self.title = title
        self.subtitle = subtitle
        self.isSelected = isSelected
        self.action = action
        self.accessoryContent = accessoryContent
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(title)
                            .title3()
                            .foregroundColor(titleColor)
                        
                        accessoryContent()
                        
                        Spacer()
                        
                        if isSelected {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title2)
                                .foregroundColor(iconColor)
                        }
                    }
                    
                    Text(subtitle)
                        .bodyStyle()
                        .foregroundColor(subtitleColor)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(backgroundColor)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    // MARK: - Style Properties
    private var backgroundColor: Color {
        isSelected ? .brandPrimary200 : .neutralsWhite
    }
    
    private var titleColor: Color {
        isSelected ? .brandPrimary800 : .petrichorText
    }
    
    private var subtitleColor: Color {
        isSelected ? .brandPrimary700 : .petrichorTextSecondary
    }
    
    private var iconColor: Color {
        isSelected ? .brandPrimary800 : .clear
    }
    
    private var borderColor: Color {
        isSelected ? .clear : .neutralsGrey300
    }
    
    private var borderWidth: CGFloat {
        isSelected ? 0 : 1
    }
}


#Preview {
    VStack(spacing: 16) {
        SelectionCard(
            title: "Metric",
            subtitle: "Celsius • Milliliters • Kph • Millibars",
            isSelected: true,
            action: {}
        )
        
        SelectionCard(
            title: "Imperial",
            subtitle: "Fahrenheit • Miles • Mph • Inches",
            isSelected: false,
            action: {}
        )
        
        SelectionCard(
            title: "Automatic",
            subtitle: "Data is automatically updated based on your device location using GPS",
            isSelected: true,
            action: {}
        ) {
            PetrichorChip(
                text: "Recommended",
                style: .primary
            )
        }
        
        SelectionCard(
            title: "Manual",
            subtitle: "Data is based on your selected location. You'll need to update it whenever you move around.",
            isSelected: false,
            action: {}
        )
    }
    .padding()
    .background(Color.neutralsGrey100)
}
