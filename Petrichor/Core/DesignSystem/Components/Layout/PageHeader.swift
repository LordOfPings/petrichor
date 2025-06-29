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
                    HorizontalSpacer(.medium)
                    
                    Text(subtitle)
                        .bodyStyle()
                        .foregroundColor(.petrichorTextPrimaryDark)
                }
                
                Spacer()
                
                Button(action: onProfile ?? {}) {
                    Image(systemName: "person.circle")
                        .font(.title2)
                        .foregroundColor(.petrichorPrimary)
                }
                
            }
            
            // Page title section
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .xlargeTitle()
                    .foregroundColor(.petrichorTextPrimaryDark)
            }
        }
        .padding(.horizontal)
        .padding(.top, 32)
        .padding(.bottom, 32)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background (
            Color.petrichorBrandBackground
            .ignoresSafeArea(.all, edges: .top)
        )
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
}
