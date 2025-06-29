import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                // MARK: - Header Section with Custom Fonts
                VStack(spacing: 12) {
                    Text("🌧️ Petrichor")
                        .xlargeTitle()  // ClashDisplay-Semibold, 48pt
                        .foregroundColor(.petrichorPrimary)
                    
                    Text("Beautiful Custom Typography")
                        .title2()  // ClashDisplay-Medium, 22pt
                        .foregroundColor(.petrichorTextSecondary)
                    
                    Text("Clash Display + Switzer Design System")
                        .bodyStyle()  // Switzer-Regular, 16pt
                        .foregroundColor(.petrichorTextTertiary)
                }
                .multilineTextAlignment(.center)
                .padding()
                
                // MARK: - Typography Showcase
                TypographyShowcase()
                
                // MARK: - Weather Status Cards
                WeatherStatusSection()
                
                // MARK: - Color System Grid
                VStack(spacing: 24) {
                    // Brand Colors
                    ColorFamilySection(
                        title: "Brand Primary",
                        colors: [
                            .brandPrimary100, .brandPrimary300, .brandPrimary500,
                            .brandPrimary700, .brandPrimary900
                        ],
                        labels: ["100", "300", "500", "700", "900"]
                    )
                    
                    // System Colors
                    ColorFamilySection(
                        title: "Weather Colors",
                        colors: [.weatherSafe, .weatherCaution, .weatherDanger, .weatherInfo],
                        labels: ["Safe", "Caution", "Danger", "Info"]
                    )
                    
                    // Color families
                    ColorFamilySection(
                        title: "Green Palette",
                        colors: [.green100, .green300, .green500, .green700, .green900],
                        labels: ["100", "300", "500", "700", "900"]
                    )
                    
                    ColorFamilySection(
                        title: "Blue Palette",
                        colors: [.blue100, .blue300, .blue500, .blue700, .blue900],
                        labels: ["100", "300", "500", "700", "900"]
                    )
                    
                    ColorFamilySection(
                        title: "Neutrals",
                        colors: [.neutralsWhite, .neutralsGrey200, .neutralsGrey400, .neutralsGrey600, .neutralsGrey700],
                        labels: ["White", "200", "400", "600", "700"]
                    )
                }
                
                // MARK: - Typography + Color Combinations
                TypographyColorCombinations()
            }
            .padding()
        }
        .background(Color.petrichorBackground)
    }
}

// MARK: - Typography Showcase Component
struct TypographyShowcase: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Typography Hierarchy")
                .title1()  // ClashDisplay-Bold, 28pt
                .foregroundColor(.petrichorText)
            
            VStack(alignment: .leading, spacing: 12) {
                TypographyExample(
                    text: "X-Large Title",
                    style: .xlargeTitle,
                    description: "48pt • ClashDisplay Semibold"
                )
                
                TypographyExample(
                    text: "Large Title",
                    style: .largeTitle,
                    description: "34pt • ClashDisplay Bold"
                )
                
                TypographyExample(
                    text: "Title 1",
                    style: .title1,
                    description: "28pt • ClashDisplay Bold"
                )
                
                TypographyExample(
                    text: "Title 2",
                    style: .title2,
                    description: "22pt • ClashDisplay Medium"
                )
                
                TypographyExample(
                    text: "Title 3",
                    style: .title3,
                    description: "20pt • Switzer Semibold"
                )
                
                TypographyExample(
                    text: "Headline Style",
                    style: .headline,
                    description: "17pt • Switzer Semibold"
                )
                
                TypographyExample(
                    text: "Body Style",
                    style: .body,
                    description: "16pt • Switzer Regular"
                )
                
                TypographyExample(
                    text: "Subhead Style",
                    style: .subhead,
                    description: "15pt • Switzer Medium"
                )
                
                TypographyExample(
                    text: "Footnote Style",
                    style: .footnote,
                    description: "13pt • Switzer Regular"
                )
                
                TypographyExample(
                    text: "Caption Style",
                    style: .caption,
                    description: "12pt • Switzer Medium"
                )
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.petrichorSurface)
        .cornerRadius(16)
    }
}

// MARK: - Typography Example Component
struct TypographyExample: View {
    let text: String
    let style: Font
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(text)
                .font(style)
                .foregroundColor(.petrichorText)
            
            Text(description)
                .captionStyle()
                .foregroundColor(.petrichorTextSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Typography + Color Combinations
struct TypographyColorCombinations: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Typography + Color Combinations")
                .title1()
                .foregroundColor(.petrichorText)
            
            VStack(spacing: 12) {
                // Success combination
                HStack {
                    Text("✅ Success")
                        .headlineStyle()
                        .foregroundColor(.weatherSafe)
                    Spacer()
                    Text("Perfect weather for walks!")
                        .bodyStyle()
                        .foregroundColor(.petrichorText)
                }
                .padding()
                .background(Color.weatherSafeLight.opacity(0.1))
                .cornerRadius(12)
                
                // Caution combination
                HStack {
                    Text("⚠️ Caution")
                        .headlineStyle()
                        .foregroundColor(.weatherCaution)
                    Spacer()
                    Text("Check conditions first")
                        .bodyStyle()
                        .foregroundColor(.petrichorText)
                }
                .padding()
                .background(Color.weatherCautionLight.opacity(0.1))
                .cornerRadius(12)
                
                // Danger combination
                HStack {
                    Text("🔥 Danger")
                        .headlineStyle()
                        .foregroundColor(.weatherDanger)
                    Spacer()
                    Text("Stay indoors with pets")
                        .bodyStyle()
                        .foregroundColor(.petrichorText)
                }
                .padding()
                .background(Color.weatherDangerLight.opacity(0.1))
                .cornerRadius(12)
                
                // Brand combination
                HStack {
                    Text("🌧️ Brand")
                        .headlineStyle()
                        .foregroundColor(.petrichorPrimary)
                    Spacer()
                    Text("Petrichor weather insights")
                        .bodyStyle()
                        .foregroundColor(.petrichorTextSecondary)
                }
                .padding()
                .background(Color.brandPrimary100.opacity(0.3))
                .cornerRadius(12)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Weather Status Section
struct WeatherStatusSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Weather Status Components")
                .title1()
                .foregroundColor(.petrichorText)
            
            HStack(spacing: 12) {
                WeatherStatusCard(
                    color: .weatherSafe,
                    icon: "sun.max.fill",
                    title: "Safe",
                    subtitle: "Perfect for walks",
                    temperature: "22°C"
                )
                
                WeatherStatusCard(
                    color: .weatherCaution,
                    icon: "cloud.sun.fill",
                    title: "Caution",
                    subtitle: "Check conditions",
                    temperature: "35°C"
                )
                
                WeatherStatusCard(
                    color: .weatherDanger,
                    icon: "thermometer.sun.fill",
                    title: "Danger",
                    subtitle: "Stay indoors",
                    temperature: "40°C"
                )
            }
        }
    }
}

// MARK: - Weather Status Card
struct WeatherStatusCard: View {
    let color: Color
    let icon: String
    let title: String
    let subtitle: String
    let temperature: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(color)
            
            VStack(spacing: 4) {
                Text(title)
                    .subheadStyle()  // Switzer-Medium
                    .fontWeight(.semibold)
                    .foregroundColor(.petrichorText)
                
                Text(subtitle)
                    .captionStyle()  // Switzer-Medium
                    .foregroundColor(.petrichorTextSecondary)
                
                Text(temperature)
                    .footnoteStyle()  // Switzer-Regular
                    .fontWeight(.medium)
                    .foregroundColor(color)
            }
            .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.petrichorSurface)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(color.opacity(0.2), lineWidth: 1)
        )
    }
}

// MARK: - Color Family Section
struct ColorFamilySection: View {
    let title: String
    let colors: [Color]
    let labels: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .title3()  // Switzer-Semibold
                .foregroundColor(.petrichorText)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: min(colors.count, 5)), spacing: 8) {
                ForEach(Array(colors.enumerated()), id: \.offset) { index, color in
                    ColorSwatch(
                        color: color,
                        label: labels[safe: index] ?? "\(index)"
                    )
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Color Swatch
struct ColorSwatch: View {
    let color: Color
    let label: String
    
    var body: some View {
        VStack(spacing: 6) {
            RoundedRectangle(cornerRadius: 12)
                .fill(color)
                .frame(height: 50)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.neutralsGrey300, lineWidth: 0.5)
                )
            
            Text(label)
                .captionStyle()  // Switzer-Medium
                .foregroundColor(.petrichorTextSecondary)
        }
    }
}

// MARK: - Safe Array Extension
extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

#Preview {
    ContentView()
}

#Preview("Dark Mode") {
    ContentView()
        .preferredColorScheme(.dark)
}

#Preview("Large Text") {
    ContentView()
        .dynamicTypeSize(.xLarge)
}
