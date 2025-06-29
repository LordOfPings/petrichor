import SwiftUI

// MARK: - Typography System
// Custom typography using Clash Display + Switzer

extension Font {
    
    // MARK: - Display Fonts (Headers) - Clash Display
    
    /// Extra Large Title: 48pt, Semibold
    /// Usage: Hero titles, app name
    static let xlargeTitle = Font.custom("ClashDisplay-Semibold", size: 48)
    
    /// Large Title: 34pt, Bold
    /// Usage: Screen titles, main headers
    static let largeTitle = Font.custom("ClashDisplay-Bold", size: 34)
    
    /// Title 1: 28pt, Bold
    /// Usage: Section titles
    static let title1 = Font.custom("ClashDisplay-Bold", size: 28)
    
    /// Title 2: 22pt, Medium
    /// Usage: Subsection headers
    static let title2 = Font.custom("ClashDisplay-Medium", size: 22)
    
    // MARK: - Body Fonts (Content) - Switzer
    
    /// Title 3: 20pt, Semibold
    /// Usage: Card titles, important labels
    static let title3 = Font.custom("Switzer-Semibold", size: 20)
    
    /// Headline: 17pt, Semibold
    /// Usage: List headers, emphasis text
    static let headline = Font.custom("Switzer-Semibold", size: 17)
    
    /// Body: 16pt, Regular
    /// Usage: Main content, descriptions
    static let body = Font.custom("Switzer-Regular", size: 16)
    
    /// Callout: 16pt, Regular
    /// Usage: Important body text, buttons
    static let callout = Font.custom("Switzer-Regular", size: 16)
    
    /// Subhead: 15pt, Medium
    /// Usage: Secondary information
    static let subhead = Font.custom("Switzer-Medium", size: 15)
    
    /// Footnote: 13pt, Regular
    /// Usage: Fine print, metadata
    static let footnote = Font.custom("Switzer-Regular", size: 13)
    
    /// Caption: 12pt, Medium
    /// Usage: Labels, small text
    static let caption = Font.custom("Switzer-Medium", size: 12)
}

// MARK: - Typography View Extensions
// Chainable modifiers for clean, readable SwiftUI code

extension View {
    
    // MARK: - Display Typography
    
    /// Extra Large Title style - 48pt ClashDisplay Semibold
    func xlargeTitle() -> some View {
        self.font(.xlargeTitle)
    }
    
    /// Large Title style - 34pt ClashDisplay Bold
    func largeTitle() -> some View {
        self.font(.largeTitle)
    }
    
    /// Title 1 style - 28pt ClashDisplay Bold
    func title1() -> some View {
        self.font(.title1)
    }
    
    /// Title 2 style - 22pt ClashDisplay Medium
    func title2() -> some View {
        self.font(.title2)
    }
    
    // MARK: - Body Typography
    
    /// Title 3 style - 20pt Switzer Semibold
    func title3() -> some View {
        self.font(.title3)
    }
    
    /// Headline style - 17pt Switzer Semibold
    func headlineStyle() -> some View {
        self.font(.headline)
    }
    
    /// Body style - 16pt Switzer Regular
    func bodyStyle() -> some View {
        self.font(.body)
    }
    
    /// Callout style - 16pt Switzer Regular
    func calloutStyle() -> some View {
        self.font(.callout)
    }
    
    /// Subhead style - 15pt Switzer Medium
    func subheadStyle() -> some View {
        self.font(.subhead)
    }
    
    /// Footnote style - 13pt Switzer Regular
    func footnoteStyle() -> some View {
        self.font(.footnote)
    }
    
    /// Caption style - 12pt Switzer Medium
    func captionStyle() -> some View {
        self.font(.caption)
    }
}

// MARK: - Typography Combinations
// Pre-built combinations for common use cases

extension View {
    
    /// Weather card title styling
    func weatherCardTitle() -> some View {
        self
            .title3()
            .foregroundColor(.petrichorText)
    }
    
    /// Weather card subtitle styling
    func weatherCardSubtitle() -> some View {
        self
            .captionStyle()
            .foregroundColor(.petrichorTextSecondary)
    }
    
    /// Button text styling
    func buttonText() -> some View {
        self
            .calloutStyle()
            .fontWeight(.semibold)
    }
    
    /// Section header styling
    func sectionHeader() -> some View {
        self
            .title2()
            .foregroundColor(.petrichorText)
    }
    
    /// Descriptive text styling
    func descriptiveText() -> some View {
        self
            .bodyStyle()
            .foregroundColor(.petrichorTextSecondary)
    }
}

// MARK: - Font Registration
struct FontRegistration {
    static func registerFonts() {
        let fontNames = [
            "ClashDisplay-Bold",
            "ClashDisplay-Semibold",
            "ClashDisplay-Medium",
            "Switzer-Regular",
            "Switzer-Medium",
            "Switzer-Semibold"
        ]
        
        for fontName in fontNames {
            // Try both .otf and .ttf extensions
            if let fontURL = Bundle.main.url(forResource: fontName, withExtension: "otf") {
                registerFont(at: fontURL, name: fontName)
            } else if let fontURL = Bundle.main.url(forResource: fontName, withExtension: "ttf") {
                registerFont(at: fontURL, name: fontName)
            } else {
                print("❌ Font file not found: \(fontName)")
            }
        }
        
        // Debug: Print what fonts are actually available
        debugAvailableFonts()
    }
    
    private static func registerFont(at url: URL, name: String) {
        var error: Unmanaged<CFError>?
        let success = CTFontManagerRegisterFontsForURL(url as CFURL, .process, &error)
        
        if success {
            print("✅ Successfully registered: \(name)")
        } else {
            print("❌ Failed to register: \(name)")
            if let error = error?.takeRetainedValue() {
                print("   Error: \(error)")
            }
        }
    }
    
    private static func debugAvailableFonts() {
        print("\n🎨 Available Custom Fonts:")
        for family in UIFont.familyNames.sorted() {
            if family.localizedCaseInsensitiveContains("clash") ||
               family.localizedCaseInsensitiveContains("switzer") {
                print("📁 Family: \(family)")
                for font in UIFont.fontNames(forFamilyName: family) {
                    print("  • \(font)")
                }
            }
        }
        
        // Test specific font availability
        let testFonts = ["ClashDisplay-Bold", "Switzer-Regular"]
        for fontName in testFonts {
            let font = UIFont(name: fontName, size: 16)
            print("🧪 \(fontName): \(font != nil ? "✅ Available" : "❌ Not found")")
        }
    }
}
