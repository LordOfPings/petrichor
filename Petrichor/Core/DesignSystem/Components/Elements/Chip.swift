import SwiftUI

// MARK: - Chip/Tag Component
struct PetrichorChip: View {
    let text: String
    let style: ChipStyle
    let size: ChipSize
    
    enum ChipStyle {
        case primary, secondary, success, warning, danger, neutral
    }
    
    enum ChipSize {
        case small, medium
    }
    
    init(
        text: String,
        style: ChipStyle = .primary,
        size: ChipSize = .small
    ) {
        self.text = text
        self.style = style
        self.size = size
    }
    
    var body: some View {
        Text(text)
            .font(fontSize)
            .fontWeight(.medium)
            .foregroundColor(textColor)
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
    }
    
    // MARK: - Style Properties
    private var textColor: Color {
        switch style {
        case .primary:
            return .neutralsWhite
        case .secondary:
            return .petrichorPrimary
        case .success:
            return .green900
        case .warning:
            return .yellow900
        case .danger:
            return .red900
        case .neutral:
            return .neutralsGrey700
        }
    }
    
    private var backgroundColor: Color {
        switch style {
        case .primary:
            return .brandPrimary700
        case .secondary:
            return .brandPrimary100
        case .success:
            return .green300
        case .warning:
            return .yellow400
        case .danger:
            return .red300
        case .neutral:
            return .neutralsGrey100
        }
    }
    
    private var borderColor: Color {
        switch style {
        case .primary, .success, .warning, .danger:
            return .clear
        case .secondary:
            return .petrichorPrimary
        case .neutral:
            return .clear
        }
    }
    
    private var borderWidth: CGFloat {
        switch style {
        case .primary, .success, .warning, .danger:
            return 0
        case .secondary, .neutral:
            return 1
        }
    }
    
    private var fontSize: Font {
        switch size {
        case .small:
            return .caption
        case .medium:
            return .footnote
        }
    }
    
    private var horizontalPadding: CGFloat {
        switch size {
        case .small: return 8
        case .medium: return 12
        }
    }
    
    private var verticalPadding: CGFloat {
        switch size {
        case .small: return 4
        case .medium: return 6
        }
    }
    
    private var cornerRadius: CGFloat {
        switch size {
        case .small: return 12
        case .medium: return 16
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        HStack(spacing: 8) {
            PetrichorChip(text: "Recommended", style: .primary)
            PetrichorChip(text: "Optional", style: .secondary)
            PetrichorChip(text: "Success", style: .success)
        }
        
        HStack(spacing: 8) {
            PetrichorChip(text: "Warning", style: .warning)
            PetrichorChip(text: "Error", style: .danger)
            PetrichorChip(text: "Neutral", style: .neutral)
        }
        
        HStack(spacing: 8) {
            PetrichorChip(text: "Small", style: .primary, size: .small)
            PetrichorChip(text: "Medium", style: .primary, size: .medium)
        }
    }
    .padding()
    .background(Color.neutralsWhite)
}
