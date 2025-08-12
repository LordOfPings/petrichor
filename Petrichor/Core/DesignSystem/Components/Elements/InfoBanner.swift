import SwiftUI

// MARK: - Data Models
struct WeatherInsight: Identifiable {
    let id = UUID()
    let primaryText: String
    let secondaryText: String
    let icon: String // SF Symbol
    let riskLevel: RiskLevel
}

enum RiskLevel: CaseIterable {
    case low, moderate, high, veryHigh
    
    var color: Color {
        switch self {
        case .low: return .weatherSafe
        case .moderate: return .weatherInfo
        case .high: return .weatherCaution
        case .veryHigh: return .weatherDanger
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .low: return .weatherSafeLight
        case .moderate: return .weatherInfoLight
        case .high: return .weatherCautionLight
        case .veryHigh: return .weatherDangerLight
        }
    }
}

// MARK: - InfoBanner Component
struct InfoBanner: View {
    let insights: [WeatherInsight]
    @State private var currentIndex = 0
    @State private var showPullHint = false
    @State private var dragOffset: CGFloat = 0
    @State private var isTransitioning = false
    
    var body: some View {
        HStack(spacing: 0) {
            // Main content container
            ZStack {
                ForEach(Array(insights.enumerated()), id: \.element.id) { index, insight in
                    InsightCard(insight: insight)
                        .offset(y: offsetForIndex(index))
                        .opacity(opacityForIndex(index))
                        .animation(.smooth(duration: 0.5, extraBounce: 0), value: currentIndex)
                        .animation(.smooth(duration: 0.5, extraBounce: 0), value: isTransitioning)
                }
            }
            .clipped() // Prevents text from showing outside bounds during animation
            .gesture(
                DragGesture()
                    .onChanged { value in
                        dragOffset = value.translation.height
                    }
                    .onEnded { value in
                        let threshold: CGFloat = 40
                        
                        if value.translation.height < -threshold && currentIndex < insights.count - 1 {
                            // Swipe up - next insight
                            withAnimation(.smooth(duration: 0.5, extraBounce: 0)) {
                                isTransitioning = true
                                currentIndex += 1
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                isTransitioning = false
                            }
                        } else if value.translation.height > threshold && currentIndex > 0 {
                            // Swipe down - previous insight
                            withAnimation(.smooth(duration: 0.5, extraBounce: 0)) {
                                isTransitioning = true
                                currentIndex -= 1
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                isTransitioning = false
                            }
                        }
                        
                        // Reset drag offset
                        withAnimation(.smooth(duration: 0.3)) {
                            dragOffset = 0
                        }
                    }
            )
            .padding(.horizontal)
            .padding(.vertical, 12)
            .background(Color.petrichorBrandBackground)
            .cornerRadius(120)
            .offset(y: showPullHint ? -4 : 0)
            .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: showPullHint)
            
            HorizontalSpacer(.medium)
            
            // Vertical page indicator dots (outside container)
            VStack(spacing: 6) {
                ForEach(0..<insights.count, id: \.self) { index in
                    Circle()
                        .fill(index == currentIndex ? Color.petrichorPrimary : Color.petrichorTextTertiary)
                        .frame(width: 6, height: 6)
                        .scaleEffect(index == currentIndex ? 1.2 : 1.0)
                        .animation(.easeInOut(duration: 0.3), value: currentIndex)
                }
            }
        }
        .onAppear {
            // Start the subtle pull-up hint animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                showPullHint = true
            }
        }
    }
    
    // MARK: - Animation Helpers
    private func offsetForIndex(_ index: Int) -> CGFloat {
        let cardHeight: CGFloat = 40
        
        if index == currentIndex {
            return dragOffset
        } else if index == currentIndex - 1 {
            // Previous card (slides up when going back)
            return isTransitioning ? 0 : -cardHeight
        } else if index == currentIndex + 1 {
            // Next card (slides down when going forward)
            return isTransitioning ? 0 : cardHeight
        } else {
            // Cards further away
            return index < currentIndex ? -cardHeight * 2 : cardHeight * 2
        }
    }
    
    private func opacityForIndex(_ index: Int) -> Double {
        if index == currentIndex {
            return 1.0
        } else if isTransitioning && (index == currentIndex - 1 || index == currentIndex + 1) {
            return 0.6
        } else {
            return 0.0
        }
    }
}

// MARK: - Individual Insight Card
struct InsightCard: View {
    let insight: WeatherInsight
    
    var body: some View {
        HStack(spacing: 12) {
            // Icon
            Image(systemName: insight.icon)
                .font(.title3)
                .foregroundColor(.petrichorTextPrimaryDark)
                .frame(width: 24, height: 24)
            
            // Text content
            HStack(spacing: 8) {
                Text(insight.primaryText)
                    .bodyStyle()
                    .foregroundColor(.petrichorTextPrimaryDark)
                
                Text("|")
                    .bodyStyle()
                    .foregroundColor(.petrichorTextPrimaryDark)
                
                Text(insight.secondaryText)
                    .bodyStyle()
                    .foregroundColor(.petrichorTextPrimaryDark)
                    .fontWeight(.medium)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

// MARK: - Mock Data
extension WeatherInsight {
    static let mockInsights: [WeatherInsight] = [
        WeatherInsight(
            primaryText: "Humidity 60%",
            secondaryText: "Overheating risk",
            icon: "drop.fill",
            riskLevel: .high
        ),
        WeatherInsight(
            primaryText: "Feels like 26°",
            secondaryText: "Weak gusts",
            icon: "wind",
            riskLevel: .moderate
        )
    ]
}

// MARK: - Previews
#Preview("InfoBanner") {
    VStack(spacing: 24) {
        InfoBanner(insights: WeatherInsight.mockInsights)
        
        // Show different risk levels
        InfoBanner(insights: [
            WeatherInsight(
                primaryText: "UV Index 3",
                secondaryText: "Low risk",
                icon: "sun.max.fill",
                riskLevel: .low
            ),
            WeatherInsight(
                primaryText: "Heat Index 35°",
                secondaryText: "Very high risk",
                icon: "thermometer.sun.fill",
                riskLevel: .veryHigh
            )
        ])
    }
    .padding()
    .background(Color.petrichorBackground)
}
