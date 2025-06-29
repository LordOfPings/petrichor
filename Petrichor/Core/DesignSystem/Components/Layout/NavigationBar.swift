import SwiftUI

struct NavigationBar: View {
    let title: String?
    let onBack: (() -> Void)?
    let onAction: (() -> Void)?
    let actionIcon: String?
    let actionTitle: String?
    
    init(
        title: String? = nil,
        onBack: (() -> Void)? = nil,
        onAction: (() -> Void)? = nil,
        actionIcon: String? = nil,
        actionTitle: String? = nil
    ) {
        self.title = title
        self.onBack = onBack
        self.onAction = onAction
        self.actionIcon = actionIcon
        self.actionTitle = actionTitle
    }
    
    var body: some View {
        HStack {
            // Back button
            if let backAction = onBack {
                Button {
                    backAction()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.petrichorPrimary)
                        .fontWeight(.medium)
                }
            }
            
            // Title
            if let title = title {
                Spacer()
                Text(title)
                    .headlineStyle()
                    .foregroundColor(.petrichorText)
                Spacer()
            } else {
                Spacer()
            }
            
            // Action button
            if let actionHandler = onAction {
                Button {
                    actionHandler()
                } label: {
                    HStack(spacing: 4) {
                        if let actionTitle = actionTitle {
                            Text(actionTitle)
                                .subheadStyle()
                                .foregroundColor(.petrichorPrimary)
                        }
                        
                        if let actionIcon = actionIcon {
                            Image(systemName: actionIcon)
                                .font(.title2)
                                .foregroundColor(.petrichorPrimary)
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

#Preview {
    VStack(spacing: 20) {
        NavigationBar(
            title: "Pet Details",
            onBack: { print("Back tapped") },
            onAction: { print("Action tapped") },
            actionTitle: "Edit"
        )
        
        Spacer()
    }
    .background(Color.brandPrimary100.opacity(0.3))
}
