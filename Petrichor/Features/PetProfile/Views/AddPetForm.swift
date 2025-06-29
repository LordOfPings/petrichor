import SwiftUI

struct AddPetForm: View {
    
    // MARK: - State Properties
    @State private var petName = ""
    @State private var selectedBreed: String?
    @State private var selectedCoat: String?
    @State private var selectedSex: String?
    @State private var weight = ""
    @State private var allergies = ""
    @State private var prescriptions = ""
    @State private var showValidationErrors = false
    
    // MARK: - Data Options
    private let breeds = [
        "Golden Retriever",
        "Labrador Retriever",
        "German Shepherd",
        "French Bulldog",
        "Bulldog",
        "Poodle",
        "Other"
    ]
    
    private let coatTypes = [
        "Short",
        "Medium",
        "Long",
        "Curly",
        "Wire",
        "Double"
    ]
    
    private let sexOptions = ["Male", "Female"]
    
    // MARK: - Computed Properties
    private var isFormValid: Bool {
        !petName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        selectedBreed != nil &&
        selectedSex != nil
    }
    
    var body: some View {
        VStack(spacing: 0) {
            PageHeader(
                subtitle: "My pets",
                title: "Add a dog",
                onBack: handleBack,
                onProfile: handleProfile
            )
            
            PetrichorSpacer(.large)
            
        ScrollView {
            VStack(spacing: 20) {
                    SectionHeader(
                        "Details",
                        action: handleSave,
                        actionTitle: "Save"
                    )
                    
                    VStack(spacing: 16) {
                        PetrichorTextField(
                            label: "Name",
                            placeholder: "What do we call this star?",
                            text: $petName,
                            isRequired: true
                        )
                        
                        PetrichorPickerField(
                            label: "Breed",
                            placeholder: "What breed of cute is your dog",
                            selection: $selectedBreed,
                            options: breeds,
                            displayText: { $0 },
                            isRequired: true
                        )
                        
                        PetrichorPickerField(
                            label: "Coat",
                            placeholder: "From sleek to floof—how's their coat",
                            selection: $selectedCoat,
                            options: coatTypes,
                            displayText: { $0 }
                        )
                        
                        PetrichorRadioGroup(
                            label: "Sex",
                            options: sexOptions,
                            displayText: { $0 },
                            selection: $selectedSex
                        )
                        
                        PetrichorNumberField(
                            label: "Weight",
                            placeholder: "Enter weight",
                            suffix: "LBs",
                            value: $weight
                        )
                        
                        PetrichorTextField(
                            label: "Allergies",
                            placeholder: "Add any allergies",
                            text: $allergies
                        )
                        
                        PetrichorTextField(
                            label: "Prescriptions",
                            placeholder: "Add any prescriptions",
                            text: $prescriptions
                        )
                    }
                    .background(Color.NeutralsWhite)
                    .padding(.horizontal)
                }
                
                PetrichorSpacer(.xxl)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .alert("Incomplete Form", isPresented: $showValidationErrors) {
            Button("OK") { }
        } message: {
            Text("Please fill in all required fields (Name, Breed, and Sex) before saving.")
        }
    }
    
    // MARK: - Actions
    private func handleBack() {
        print("📱 Back button tapped")
    }
    
    private func handleProfile() {
        print("👤 Profile button tapped")
    }
    
    private func handleSave() {
        guard isFormValid else {
            showValidationErrors = true
            return
        }
        
        print("💾 Saving pet: \(petName)")
    }
}

#Preview {
    AddPetForm()
}
