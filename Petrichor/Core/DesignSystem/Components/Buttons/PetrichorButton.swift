import SwiftUI

struct PetrichorButton: View {
    let title: String
    let action: () -> Void
    var style: ButtonStyle = .primary
    var size: ButtonSize = .medium
    var width: ButtonWidth = .regular           // ← Add width parameter
    var isDisabled: Bool = false
    
    enum ButtonStyle {
        case primary, secondary, outline
    }
    
    enum ButtonSize {
        case small, medium, large
    }
    
    enum ButtonWidth {                          // ← Add width variants
        case regular    // Fixed padding, intrinsic width
        case fullWidth  // Expands to fill available space
        case fixed(CGFloat)  // Custom fixed width
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .buttonText()
                .foregroundColor(foregroundColor)
                .frame(maxWidth: maxWidth)      // ← Use computed maxWidth
                .padding(.vertical, verticalPadding)
                .padding(.horizontal, horizontalPadding)
                .background(backgroundColor)
                .cornerRadius(cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(borderColor, lineWidth: borderWidth)
                )
        }
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.6 : 1.0)
    }
    
    // MARK: - Width Computation
    private var maxWidth: CGFloat? {            // ← Add width computation
        switch width {
        case .regular:
            return nil                          // Intrinsic width with padding
        case .fullWidth:
            return .infinity                    // Expands to fill
        case .fixed(let value):
            return value                        // Custom width
        }
    }
    
    // MARK: - Style Properties (existing code...)
    private var foregroundColor: Color {
        switch style {
        case .primary:
            return .neutralsWhite
        case .secondary:
            return .petrichorPrimary
        case .outline:
            return .petrichorPrimary
        }
    }
    
    private var backgroundColor: Color {
        switch style {
        case .primary:
            return .petrichorPrimary
        case .secondary:
            return .brandPrimary100
        case .outline:
            return .clear
        }
    }
    
    private var borderColor: Color {
        switch style {
        case .primary, .secondary:
            return .clear
        case .outline:
            return .petrichorPrimary
        }
    }
    
    private var borderWidth: CGFloat {
        style == .outline ? 1.5 : 0
    }
    
    private var verticalPadding: CGFloat {
        switch size {
        case .small: return 8
        case .medium: return 12
        case .large: return 16
        }
    }
    
    private var horizontalPadding: CGFloat {
        switch size {
        case .small: return 16
        case .medium: return 20
        case .large: return 24
        }
    }
    
    private var cornerRadius: CGFloat {
        switch size {
        case .small: return 8
        case .medium: return 12
        case .large: return 16
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        // Regular width buttons (intrinsic size)
        PetrichorButton(
            title: "Save",
            action: {},
            width: .regular
        )
        
        PetrichorButton(
            title: "Cancel",
            action: {},
            style: .secondary,
            width: .regular
        )
        
        // Full width buttons
        PetrichorButton(
            title: "Create Account",
            action: {},
            width: .fullWidth
        )
        
        PetrichorButton(
            title: "Sign In",
            action: {},
            style: .outline,
            width: .fullWidth
        )
        
        // Fixed width button
        PetrichorButton(
            title: "OK",
            action: {},
            width: .fixed(100)
        )
        
        // Small regular button
        PetrichorButton(
            title: "Done",
            action: {},
            size: .small,
            width: .regular
        )
    }
    .padding()
    .background(Color.brandPrimary100.opacity(0.3))
}
