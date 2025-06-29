import SwiftUI

// MARK: - Simple Page Title Component
struct PageTitle: View {
    let title: String
    let subtitle: String?
    let alignment: HorizontalAlignment
    
    init(
        _ title: String,
        subtitle: String? = nil,
        alignment: HorizontalAlignment = .leading
    ) {
        self.title = title
        self.subtitle = subtitle
        self.alignment = alignment
    }
    
    var body: some View {
        VStack(alignment: alignment, spacing: 4) {
            Text(title)
                .largeTitle()
                .foregroundColor(.petrichorText)
            
            if let subtitle = subtitle {
                Text(subtitle)
                    .bodyStyle()
                    .foregroundColor(.petrichorTextSecondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: alignment == .leading ? .leading : alignment == .trailing ? .trailing : .center)
        .padding(.horizontal)
    }
}

#Preview("Page Title") {
    VStack(spacing: 30) {
        PageTitle(
            "Weather Forecast",
            subtitle: "Today's conditions for your pets"
        )
        
        PageTitle(
            "Settings",
            alignment: .center
        )
        
        PageTitle(
            "Profile",
            subtitle: "Manage your account",
            alignment: .trailing
        )
        
        Spacer()
    }
    .background(Color.brandPrimary100.opacity(0.3))
}
