import SwiftUI

// MARK: - Consistent Spacing Component
struct PetrichorSpacer: View {
    let size: SpacingSize
    
    enum SpacingSize {
        case xs, small, medium, large, xl, xxl
        
        var value: CGFloat {
            switch self {
            case .xs: return 4
            case .small: return 8
            case .medium: return 16
            case .large: return 24
            case .xl: return 32
            case .xxl: return 48
            }
        }
    }
    
    init(_ size: SpacingSize = .medium) {
        self.size = size
    }
    
    var body: some View {
        Spacer()
            .frame(height: size.value)
    }
}

// MARK: - Horizontal Spacer
struct HorizontalSpacer: View {
    let size: PetrichorSpacer.SpacingSize
    
    init(_ size: PetrichorSpacer.SpacingSize = .medium) {
        self.size = size
    }
    
    var body: some View {
        Spacer()
            .frame(width: size.value)
    }
}

// MARK: - Flexible Spacer (Fills available space)
struct FlexibleSpacer: View {
    let minLength: CGFloat
    
    init(minLength: CGFloat = 0) {
        self.minLength = minLength
    }
    
    var body: some View {
        Spacer(minLength: minLength)
    }
}

#Preview("Spacers") {
    VStack {
        Text("Top Content")
            .bodyStyle()
            .foregroundColor(.petrichorText)
        
        PetrichorSpacer(.xs)
        Rectangle()
            .fill(Color.petrichorPrimary)  // ← Fixed: Added Color.
            .frame(height: 2)
        
        PetrichorSpacer(.small)
        Rectangle()
            .fill(Color.petrichorPrimary)  // ← Fixed: Added Color.
            .frame(height: 2)
        
        PetrichorSpacer(.medium)
        Rectangle()
            .fill(Color.petrichorPrimary)  // ← Fixed: Added Color.
            .frame(height: 2)
        
        PetrichorSpacer(.large)
        Rectangle()
            .fill(Color.petrichorPrimary)  // ← Fixed: Added Color.
            .frame(height: 2)
        
        PetrichorSpacer(.xl)
        Rectangle()
            .fill(Color.petrichorPrimary)  // ← Fixed: Added Color.
            .frame(height: 2)
        
        PetrichorSpacer(.xxl)
        
        Text("Bottom Content")
            .bodyStyle()
            .foregroundColor(.petrichorText)
        
        FlexibleSpacer()
        
        HStack {
            Text("Left")
            HorizontalSpacer(.large)
            Text("Right")
        }
        .bodyStyle()
        .foregroundColor(.petrichorText)
    }
    .padding()
    .background(Color.brandPrimary100.opacity(0.3))
}
