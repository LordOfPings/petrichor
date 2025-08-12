import SwiftUI

// MARK: - Settings View
struct SettingsView: View {
    
    // MARK: - State Properties
    @State private var selectedUnits: UnitSystem = .metric
    @State private var selectedLocation: LocationMode = .automatic
    
    // MARK: - Data Models
    enum UnitSystem: CaseIterable {
        case metric, imperial
        
        var title: String {
            switch self {
            case .metric: return "Metric"
            case .imperial: return "Imperial"
            }
        }
        
        var subtitle: String {
            switch self {
            case .metric: return "Celsius • Milliliters • Kph • Millibars"
            case .imperial: return "Fahrenheit • Miles • Mph • Inches"
            }
        }
    }
    
    enum LocationMode: CaseIterable {
        case automatic, manual
        
        var title: String {
            switch self {
            case .automatic: return "Automatic"
            case .manual: return "Manual"
            }
        }
        
        var subtitle: String {
            switch self {
            case .automatic:
                return "Data is automatically updated based on your device location using GPS"
            case .manual:
                return "Data is based on your selected location. You'll need to update it whenever you move around."
            }
        }
        
        var isRecommended: Bool {
            self == .automatic
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Page Header (Outside ScrollView)
            PageHeader(
                subtitle: "Home",
                title: "Settings",
                onBack: {},
                onProfile: {}
            )
            
            PetrichorSpacer(.large)
            
            // MARK: - Settings Content (Inside ScrollView)
            ScrollView {
                VStack(spacing: 0) {
                    
                    VStack(spacing: 32) {
                        // Units Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Units")
                                .title2()
                                .foregroundColor(.petrichorText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            VStack(spacing: 12) {
                                ForEach(UnitSystem.allCases, id: \.self) { unit in
                                    SelectionCard(
                                        title: unit.title,
                                        subtitle: unit.subtitle,
                                        isSelected: selectedUnits == unit,
                                        action: {
                                            selectedUnits = unit
                                        }
                                    )
                                }
                            }
                        }
                        
                        // Location Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Location")
                                .title2()
                                .foregroundColor(.petrichorText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            VStack(spacing: 12) {
                                ForEach(LocationMode.allCases, id: \.self) { location in
                                    SelectionCard(
                                        title: location.title,
                                        subtitle: location.subtitle,
                                        isSelected: selectedLocation == location,
                                        action: {
                                            selectedLocation = location
                                        }
                                    ) {
                                        if location.isRecommended {
                                            PetrichorChip(
                                                text: "Recommended",
                                                style: .primary
                                            )
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // Bottom spacing
                    PetrichorSpacer(.xxl)
                }
            }
            .background(Color.neutralsWhite)
        }
        .background(Color.neutralsWhite)
        .toolbar(.hidden, for: .navigationBar)
    }
    
    // MARK: - Actions
    private func saveSettings() {
        print("💾 Saving settings:")
        print("  Units: \(selectedUnits)")
        print("  Location: \(selectedLocation)")
        
        // In a real app, you would:
        // 1. Save to UserDefaults or AppStorage
        // 2. Update app-wide settings
        // 3. Trigger weather data refresh if needed
    }
}

// MARK: - Previews
#Preview("Settings View") {
    SettingsView()
}

#Preview("Settings - Different Selections") {
    SettingsViewPreview()
}

// MARK: - Preview Helper
private struct SettingsViewPreview: View {
    var body: some View {
        SettingsView()
            .onAppear {
                // This shows different selected states in preview
                // Note: Won't actually change @State in preview, but shows intent
            }
    }
}
