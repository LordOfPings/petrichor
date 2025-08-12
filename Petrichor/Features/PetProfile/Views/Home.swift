import SwiftUI

// MARK: - Home View
struct HomeView: View {
    @State private var currentTime = Date()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    // Weather Header
                    WeatherHeaderSection()
                    
                    PetrichorSpacer(.small)
                    
                    // Info Banner
                    InfoBanner(insights: WeatherInsight.mockInsights)
                        .padding(.horizontal)
                    
                    PetrichorSpacer(.large)
                    
                    // Time Visualization
                    TimeVisualizationSection()
                        .padding(.horizontal)
                    
                    PetrichorSpacer(.large)
                    
                    // Risk Factors
                    RiskFactorsSection()
                        .padding()
                        .background(Color.petrichorBackground)
                        .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        Color.BrandPrimary400,
                                        Color.BrandPrimary500,
                                        Color.BrandPrimary600
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 2
                            )
                    )
                    
                        .padding(.horizontal)
                    PetrichorSpacer(.large)
                    
                    // Recommendation Cards
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            RecommendationCard(
                                type: .gear,
                                description: "It's sweater weather! Don't forget to carry an umbrella or a raincoat",
                                recommendations: Recommendation.mockGearRecommendations,
                                showToggle: true
                            )
                            .frame (width: UIScreen.main.bounds.width - 48)
                            
                            RecommendationCard(
                                type: .activity,
                                description: "Too hot for a play. Keep walks under 20mins. Keep in the shade if possible.",
                                recommendations: Recommendation.mockActivityRecommendations,
                                showToggle: false
                            )
                            .frame (width: UIScreen.main.bounds.width - 48)
                        }
                    }
                    .padding(.horizontal, 12)
                    
                    PetrichorSpacer(.small)
                }
            }
            .background(Color.petrichorBackground)
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Weather Header Section
struct WeatherHeaderSection: View {
    var body: some View {
        VStack(spacing: 4) {
            // Clickable Location
            NavigationLink(destination: SettingsView()) {
                Text("Burnaby, Canada")
                    .bodyStyle()
                    .foregroundColor(.petrichorTextSecondary)
            }
            .buttonStyle(PlainButtonStyle())
            
            // Temperature Display
            Text("26")
                .font(.xxlargeTitle)
                .foregroundColor(.petrichorTextPrimaryDark)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 20) // Account for status bar
        .padding(.bottom, 0)
    }
}

// MARK: - Time Visualization Section
struct TimeVisualizationSection: View {
    @State private var selectedTime: TimeInterval = 0
    @State private var isDragging: Bool = false
    
    private let totalHours: CGFloat = 24
    private let currentHour: CGFloat = 9 // 9 AM
    private let optimalStartHour: CGFloat = 9 // 9 AM
    private let optimalEndHour: CGFloat = 12 // 12 PM
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Text("Ideal time for walks and outdoor play")
                .subheadStyle()
                .foregroundColor(.petrichorText)
            
            Text("Now - 12 AM")
                .largeTitle()
                .foregroundColor(.petrichorTextPrimaryDark)
            
            // Time Bar Visualization
            GeometryReader { geometry in
                let barWidth = geometry.size.width
                let hourWidth = barWidth / totalHours
                
                ZStack(alignment: .leading) {
                    // Background bar
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.neutralsGrey200)
                        .frame(height: 8)
                    
                    // Optimal time range (green section)
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.weatherSafe)
                        .frame(width: (optimalEndHour - optimalStartHour) * hourWidth, height: 8)
                        .offset(x: optimalStartHour * hourWidth)
                    
                    // Current time indicator
                    Circle()
                        .fill(Color.petrichorPrimary)
                        .frame(width: 16, height: 16)
                        .offset(x: currentHour * hourWidth - 8)
                }
            }
            .frame(height: 16)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        isDragging = true
                        // Add hover interaction logic here later
                    }
                    .onEnded { _ in
                        isDragging = false
                    }
            )
        }
    }
}

// MARK: - Risk Factors Section
struct RiskFactorsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Risks factors")
                .subheadStyle()
                .foregroundColor(.petrichorTextTertiary)
            
            VStack(spacing: 4) {
                RiskFactorRow(
                    title: "Humidity",
                    level: "Very high",
                    chipStyle: .danger
                )
                
                RiskFactorRow(
                    title: "Temperature",
                    level: "High",
                    chipStyle: .warning
                )
                
                RiskFactorRow(
                    title: "Pollen",
                    level: "High",
                    chipStyle: .warning
                )
                
                RiskFactorRow(
                    title: "UV",
                    level: "Low",
                    chipStyle: .success
                )
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Risk Factor Row
struct RiskFactorRow: View {
    let title: String
    let level: String
    let chipStyle: PetrichorChip.ChipStyle
    
    var body: some View {
        HStack {
            HStack(spacing: 8) {
                Text(title)
                    .bodyStyle()
                    .foregroundColor(.petrichorText)
                
                Image(systemName: "arrow.up.right")
                    .font(.caption)
                    .foregroundColor(.petrichorTextSecondary)
            }
            
            Spacer()
            PetrichorChip (
                text: level,
                style: chipStyle,
                size: .small
                )
        }
    }
}

// MARK: - Mock Weather Data
struct WeatherData {
    let temperature: Int
    let location: String
    let humidity: Int
    let uvIndex: Int
    let feelsLike: Int
    let windSpeed: Int
}

extension WeatherData {
    static let mock = WeatherData(
        temperature: 26,
        location: "Burnaby, Canada",
        humidity: 60,
        uvIndex: 3,
        feelsLike: 26,
        windSpeed: 15
    )
}

// MARK: - Previews
#Preview("Home View") {
    HomeView()
}

#Preview("Weather Header") {
    WeatherHeaderSection()
        .background(Color.petrichorBackground)
}

#Preview("Time Visualization") {
    TimeVisualizationSection()
        .padding()
        .background(Color.petrichorBackground)
}

#Preview("Risk Factors") {
    RiskFactorsSection()
        .padding()
        .background(Color.petrichorBackground)
}
