import SwiftUI

// MARK: - Page Header Component
struct PageHeader: View {
    let subtitle: String
    let title: String
    let onBack: (() -> Void)?
    let onProfile: (() -> Void)?
    
    init(
        subtitle: String,
        title: String,
        onBack: (() -> Void)? = nil,
        onProfile: (() -> Void)? = nil
    ) {
        self.subtitle = subtitle
        self.title = title
        self.onBack = onBack
        self.onProfile = onProfile
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Top navigation bar
            HStack {
                if let onBack = onBack {
                    Button(action: onBack) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.petrichorPrimary)
                            .fontWeight(.medium)
                    }
                }
                
                Spacer()
                
                Button(action: onProfile ?? {}) {
                    Image(systemName: "person.circle")
                        .font(.title2)
                        .foregroundColor(.petrichorTextSecondary)
                }
            }
            
            // Page title section
            VStack(alignment: .leading, spacing: 4) {
                Text(subtitle)
                    .bodyStyle()
                    .foregroundColor(.petrichorTextSecondary)
                
                Text(title)
                    .xlargeTitle()
                    .foregroundColor(.petrichorPrimary)
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

#Preview("Page Header") {
    VStack(spacing: 20) {
        PageHeader(
            subtitle: "My pets",
            title: "Add a dog",
            onBack: {},
            onProfile: {}
        )
        
        PageHeader(
            subtitle: "Weather",
            title: "Today's forecast"
        )
        
        Spacer()
    }
    .background(Color.brandPrimary100.opacity(0.3))
}
