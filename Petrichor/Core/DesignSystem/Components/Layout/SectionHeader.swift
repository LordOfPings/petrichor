import SwiftUI

// MARK: - Section Header Component
struct SectionHeader: View {
    let title: String
    let action: (() -> Void)?
    let actionTitle: String?
    let actionStyle: ActionStyle
    
    enum ActionStyle {
        case button, text
    }
    
    init(
        _ title: String,
        action: (() -> Void)? = nil,
        actionTitle: String? = nil,
        actionStyle: ActionStyle = .button
    ) {
        self.title = title
        self.action = action
        self.actionTitle = actionTitle
        self.actionStyle = actionStyle
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Text(title)
                .title2()
                .foregroundColor(.petrichorText)
            
            Spacer()
            
            if let action = action, let actionTitle = actionTitle {
                switch actionStyle {
                case .button:
                    PetrichorButton(
                        title: actionTitle,
                        action: action,
                        style: .primary,
                        size: .small,
                        width: .regular
                    )
                case .text:
                    Button {
                        action()
                    } label: {
                        Text(actionTitle)
                            .subheadStyle()
                            .foregroundColor(.petrichorPrimary)
                            .fontWeight(.medium)
                    }
                }
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

#Preview("Section Header") {
    VStack(spacing: 20) {
        SectionHeader(
            "Details",
            action: {},
            actionTitle: "Save",
            actionStyle: .button
        )
        
        SectionHeader(
            "Weather Alerts",
            action: {},
            actionTitle: "View All",
            actionStyle: .text
        )
        
        SectionHeader("Settings")
        
        Spacer()
    }
    .background(Color.brandPrimary100.opacity(0.3))
}
