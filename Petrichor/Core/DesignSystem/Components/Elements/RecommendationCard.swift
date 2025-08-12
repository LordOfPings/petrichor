import SwiftUI

// MARK: - Data Models
struct Recommendation: Identifiable {
    let id = UUID()
    let icon: String // SF Symbol
    let title: String
    let description: String
    let mode: RecommendationMode
}

enum RecommendationMode: CaseIterable {
    case pet, human
    
    var icon: String {
        switch self {
        case .pet: return "dog.fill"
        case .human: return "person.fill"
        }
    }
    
    var title: String {
        switch self {
        case .pet: return "Pet"
        case .human: return "Human"
        }
    }
}

enum RecommendationType {
    case gear, activity
    
    var title: String {
        switch self {
        case .gear: return "Gear recs"
        case .activity: return "Activity recs"
        }
    }
}

// MARK: - RecommendationCard Component
struct RecommendationCard: View {
    let type: RecommendationType
    let description: String
    let recommendations: [Recommendation]
    let showToggle: Bool
    
    @State private var selectedMode: RecommendationMode = .pet
    @State private var showTooltip: Bool = false
    @State private var tooltipRecommendation: Recommendation?
    
    // Filter recommendations based on selected mode
    private var filteredRecommendations: [Recommendation] {
        recommendations.filter { $0.mode == selectedMode }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            // Header with title and toggle
            HStack {
                Text(type.title)
                    .title2()
                    .foregroundColor(.petrichorTextInverse)
                
                Spacer()
                
                if showToggle {
                    ModeToggle(selectedMode: $selectedMode)
                }
                else {
                    // Invisible spacer to maintain consistent height
                    Spacer()
                        .frame(width: 80, height: 40) // Same size as toggle
                }
            }
            
            // Horizontal scrolling icons (aligned to title)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(filteredRecommendations) { recommendation in
                        RecommendationIcon(
                            recommendation: recommendation,
                            onTap: {
                                showTooltipFor(recommendation)
                            }
                        )
                    }
                }
                .padding(.trailing) // Only right padding for scroll
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Description text
            HStack {
                Text(description)
                    .bodyStyle()
                    .foregroundColor(.petrichorTextInverse)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            }
        }
        .padding()
        .background(Color.BrandPrimary700)
        .cornerRadius(32)
        .overlay(
            // Tooltip overlay
            tooltipOverlay
        )
    }
    
    // MARK: - Tooltip Overlay
    @ViewBuilder
    private var tooltipOverlay: some View {
        if showTooltip, let recommendation = tooltipRecommendation {
            TooltipView(
                title: recommendation.title,
                description: recommendation.description,
                onDismiss: {
                    dismissTooltip()
                }
            )
            .transition(.opacity.combined(with: .scale(scale: 0.8)))
            .animation(.easeInOut(duration: 0.2), value: showTooltip)
        }
    }
    
    // MARK: - Actions
    private func showTooltipFor(_ recommendation: Recommendation) {
        tooltipRecommendation = recommendation
        withAnimation {
            showTooltip = true
        }
        
        // Auto-dismiss after 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            dismissTooltip()
        }
    }
    
    private func dismissTooltip() {
        withAnimation {
            showTooltip = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            tooltipRecommendation = nil
        }
    }
}

// MARK: - Mode Toggle Component
struct ModeToggle: View {
    @Binding var selectedMode: RecommendationMode
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(RecommendationMode.allCases, id: \.self) { mode in
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedMode = mode
                    }
                }) {
                    Image(systemName: mode.icon)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(selectedMode == mode ? .BrandPrimary800 : .BrandPrimary100)
                        .frame(width: 32, height: 32)
                        .background(
                            Circle()
                                .fill(selectedMode == mode ? .petrichorTextInverse : Color.clear)
                        )
                }
            }
        }
        .padding(4)
        .background(
            Capsule()
                .fill(Color.BrandPrimary800)
        )
    }
}

// MARK: - Recommendation Icon Component
struct RecommendationIcon: View {
    let recommendation: Recommendation
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            Image(systemName: recommendation.icon)
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(.petrichorTextInverse)
                .frame(width: 56, height: 56)
                .background(
                    Circle()
                        .fill(Color.BrandPrimary800)
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Tooltip Component
struct TooltipView: View {
    let title: String
    let description: String
    let onDismiss: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .bodyStyle()
                .fontWeight(.semibold)
                .foregroundColor(.petrichorText)
            
            if !description.isEmpty {
                Text(description)
                    .captionStyle()
                    .foregroundColor(.petrichorTextSecondary)
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.petrichorSurfaceElevated)
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        )
        .frame(maxWidth: 200)
        .position(x: UIScreen.main.bounds.width / 2, y: 100)
        .onTapGesture {
            onDismiss()
        }
    }
}

// MARK: - Mock Data
extension Recommendation {
    static let mockGearRecommendations: [Recommendation] = [
        Recommendation(icon: "tshirt.fill", title: "Cooling Vest", description: "Keep your dog cool in hot weather", mode: .pet),
        Recommendation(icon: "umbrella.fill", title: "Raincoat", description: "Stay dry during walks", mode: .pet),
        Recommendation(icon: "pawprint.fill", title: "Paw Balm", description: "Protect paws from hot pavement", mode: .pet),
        Recommendation(icon: "sun.max.fill", title: "Hat", description: "Protect yourself from UV rays", mode: .human),
        Recommendation(icon: "drop.fill", title: "Water Bottle", description: "Stay hydrated during outdoor activities", mode: .human),
        Recommendation(icon: "eyeglasses", title: "Sunglasses", description: "Eye protection from bright sun", mode: .human)
    ]
    
    static let mockActivityRecommendations: [Recommendation] = [
        Recommendation(icon: "figure.walk", title: "Short Walk", description: "15-20 minute gentle exercise", mode: .pet),
        Recommendation(icon: "tree.fill", title: "Shade Play", description: "Play in shaded areas only", mode: .pet),
        Recommendation(icon: "house.fill", title: "Indoor Activities", description: "Keep activities inside", mode: .pet),
        Recommendation(icon: "figure.outdoor.cycle", title: "Light Cycling", description: "Easy bike ride in cool areas", mode: .human),
        Recommendation(icon: "figure.run", title: "Morning Jog", description: "Exercise before it gets too hot", mode: .human),
        Recommendation(icon: "sportscourt.fill", title: "Indoor Sports", description: "Move activities indoors", mode: .human)
    ]
}

// MARK: - Previews
#Preview("Recommendation Cards") {
    VStack(spacing: 24) {
        RecommendationCard(
            type: .gear,
            description: "It's sweater weather! Don't forget to carry an umbrella or a raincoat",
            recommendations: Recommendation.mockGearRecommendations,
            showToggle: true
        )
        
        RecommendationCard(
            type: .activity,
            description: "Too hot for a play. Keep walks under 20mins. Keep in the shade if possible.",
            recommendations: Recommendation.mockActivityRecommendations,
            showToggle: false
        )
    }
    .padding()
    .background(Color.petrichorBackground)
}
