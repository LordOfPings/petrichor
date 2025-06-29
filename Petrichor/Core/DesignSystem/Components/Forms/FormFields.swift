import SwiftUI

// MARK: - Text Input Field Component
struct PetrichorTextField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var isRequired: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(label)
                    .subheadStyle()
                    .foregroundColor(.petrichorText)
                
                if isRequired {
                    Text("*")
                        .subheadStyle()
                        .foregroundColor(.weatherDanger)
                }
                
                Spacer()
            }
            
            TextField(placeholder, text: $text)
                .bodyStyle()
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.neutralsWhite)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.neutralsGrey300, lineWidth: 1)
                )
        }
    }
}

// MARK: - Dropdown/Picker Field Component
struct PetrichorPickerField<T: Hashable>: View {
    let label: String
    let placeholder: String
    @Binding var selection: T?
    let options: [T]
    let displayText: (T) -> String
    var isRequired: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(label)
                    .subheadStyle()
                    .foregroundColor(.petrichorText)
                
                if isRequired {
                    Text("*")
                        .subheadStyle()
                        .foregroundColor(.weatherDanger)
                }
                
                Spacer()
            }
            
            Menu {
                ForEach(options, id: \.self) { option in
                    Button(displayText(option)) {
                        selection = option
                    }
                }
            } label: {
                HStack {
                    Text(selection.map(displayText) ?? placeholder)
                        .bodyStyle()
                        .foregroundColor(selection == nil ? .neutralsGrey500 : .petrichorText)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .font(.caption)
                        .foregroundColor(.neutralsGrey500)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.neutralsWhite)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.neutralsGrey300, lineWidth: 1)
                )
            }
        }
    }
}

// MARK: - Radio Button Group Component
struct PetrichorRadioGroup<T: Hashable>: View {
    let label: String
    let options: [T]
    let displayText: (T) -> String
    @Binding var selection: T?
    var isRequired: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(label)
                    .subheadStyle()
                    .foregroundColor(.petrichorText)
                
                if isRequired {
                    Text("*")
                        .subheadStyle()
                        .foregroundColor(.weatherDanger)
                }
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selection = option
                    }) {
                        HStack(spacing: 12) {
                            Circle()
                                .stroke(
                                    selection == option ? Color.petrichorPrimary : Color.neutralsGrey400,
                                    lineWidth: 2
                                )
                                .frame(width: 20, height: 20)
                                .overlay(
                                    Circle()
                                        .fill(Color.petrichorPrimary)
                                        .frame(width: 10, height: 10)
                                        .opacity(selection == option ? 1 : 0)
                                )
                            
                            Text(displayText(option))
                                .bodyStyle()
                                .foregroundColor(.petrichorText)
                            
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Number Input with Suffix Component
struct PetrichorNumberField: View {
    let label: String
    let placeholder: String
    let suffix: String
    @Binding var value: String
    var isRequired: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(label)
                    .subheadStyle()
                    .foregroundColor(.petrichorText)
                
                if isRequired {
                    Text("*")
                        .subheadStyle()
                        .foregroundColor(.weatherDanger)
                }
                
                Spacer()
            }
            
            HStack(spacing: 0) {
                TextField(placeholder, text: $value)
                    .bodyStyle()
                    .keyboardType(.decimalPad)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                
                Text(suffix)
                    .bodyStyle()
                    .foregroundColor(.petrichorTextInverse)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color.brandPrimary600)
            }
            .background(Color.neutralsWhite)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.neutralsGrey300, lineWidth: 1)
            )
        }
    }
}

// MARK: - Multi-Line Text Area Component
struct PetrichorTextArea: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var isRequired: Bool = false
    var minHeight: CGFloat = 80
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(label)
                    .subheadStyle()
                    .foregroundColor(.petrichorText)
                
                if isRequired {
                    Text("*")
                        .subheadStyle()
                        .foregroundColor(.weatherDanger)
                }
                
                Spacer()
            }
            
            ZStack(alignment: .topLeading) {
                // Background and border
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.neutralsWhite)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.neutralsGrey300, lineWidth: 1)
                    )
                    .frame(minHeight: minHeight)
                
                // Placeholder text
                if text.isEmpty {
                    Text(placeholder)
                        .bodyStyle()
                        .foregroundColor(.neutralsGrey500)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                }
                
                // Actual text editor
                TextEditor(text: $text)
                    .bodyStyle()
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.clear)
                    .scrollContentBackground(.hidden)
            }
        }
    }
}

// MARK: - Search Field Component
struct PetrichorSearchField: View {
    let placeholder: String
    @Binding var searchText: String
    var onSearchChanged: ((String) -> Void)?
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.neutralsGrey500)
                .font(.body)
            
            TextField(placeholder, text: $searchText)
                .bodyStyle()
                .onChange(of: searchText){
                    onSearchChanged?(searchText)
                }
            
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                    onSearchChanged?("")
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.neutralsGrey500)
                        .font(.body)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.neutralsWhite)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.neutralsGrey300, lineWidth: 1)
        )
    }
}

// MARK: - Toggle/Switch Component
struct PetrichorToggle: View {
    let label: String
    let description: String?
    @Binding var isOn: Bool
    
    init(label: String, description: String? = nil, isOn: Binding<Bool>) {
        self.label = label
        self.description = description
        self._isOn = isOn
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(label)
                    .subheadStyle()
                    .foregroundColor(.petrichorText)
                
                if let description = description {
                    Text(description)
                        .captionStyle()
                        .foregroundColor(.petrichorTextSecondary)
                }
            }
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: .petrichorPrimary))
        }
    }
}

// MARK: - Previews
#Preview("Form Fields Showcase") {
    ScrollView {
        VStack(spacing: 24) {
            Text("Form Fields Collection")
                .title1()
                .foregroundColor(.petrichorText)
                .padding()
            
            VStack(spacing: 20) {
                PetrichorTextField(
                    label: "Pet Name",
                    placeholder: "What do we call this star?",
                    text: .constant(""),
                    isRequired: true
                )
                
                PetrichorPickerField(
                    label: "Breed",
                    placeholder: "What breed of cute is your dog",
                    selection: .constant(nil),
                    options: ["Golden Retriever", "Labrador", "Poodle"],
                    displayText: { $0 },
                    isRequired: true
                )
                
                PetrichorRadioGroup(
                    label: "Sex",
                    options: ["Male", "Female"],
                    displayText: { $0 },
                    selection: .constant(nil)
                )
                
                PetrichorNumberField(
                    label: "Weight",
                    placeholder: "Enter weight",
                    suffix: "LBs",
                    value: .constant("")
                )
                
                PetrichorTextArea(
                    label: "Notes",
                    placeholder: "Add any additional notes about your pet...",
                    text: .constant("")
                )
                
                PetrichorSearchField(
                    placeholder: "Search for something...",
                    searchText: .constant("")
                )
                
                PetrichorToggle(
                    label: "Enable Notifications",
                    description: "Get weather alerts for your pet",
                    isOn: .constant(true)
                )
            }
            .padding()
        }
    }
    .background(Color.brandPrimary100.opacity(0.3))
}

#Preview("Individual Components") {
    VStack(spacing: 16) {
        PetrichorTextField(
            label: "Sample Text Field",
            placeholder: "Enter text here",
            text: .constant("Sample text"),
            isRequired: true
        )
        
        PetrichorSearchField(
            placeholder: "Search pets...",
            searchText: .constant("Golden")
        )
        
        PetrichorToggle(
            label: "Weather Alerts",
            description: "Receive notifications when weather conditions change",
            isOn: .constant(false)
        )
    }
    .padding()
    .background(Color.brandPrimary100.opacity(0.3))
}
