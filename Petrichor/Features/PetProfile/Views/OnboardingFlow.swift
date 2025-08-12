import SwiftUI

// MARK: - Main Onboarding Container
struct OnboardingFlow: View {
    @State private var currentStep = 0
    @State private var showingPetProfileSetup = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            // Background gradient
            Color.brandPrimary100
            .ignoresSafeArea()
            
            TabView(selection: $currentStep) {
                OnboardingStep1()
                    .tag(0)
                
                OnboardingStep2(showPetProfile: $showingPetProfileSetup)
                    .tag(1)
                
                OnboardingStep3()
                    .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut, value: currentStep)
            
            // Custom page indicators and navigation
            VStack {
                HStack {
                    Spacer()
                    PetrichorButton(
                        title: "Skip",
                        action: {
                            //Skip
                        },
                        style: .secondary,
                        size: .small
                    )
                    .foregroundColor(.secondary)
                    .padding()
                }
                
                Spacer()
            }
        }
        .sheet(isPresented: $showingPetProfileSetup) {
            AddPetForm()
        }
    }
}

// MARK: - Step 1
struct OnboardingStep1: View {
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            // Illustration placeholder
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.orange.opacity(0.1))
                    .frame(height: 300)
                
                VStack(spacing: 20) {
                    // Dog on couch illustration
                    Image(systemName: "pawprint.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.orange)
                    
                    Image(systemName: "sun.max.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.yellow)
                }
            }
            .padding(.horizontal)
            
            VStack(spacing: 16) {
                Text("Plan walks with confidence")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.petrichorTextPrimaryDark)
                    .multilineTextAlignment(.center)
                
                Text("Know the best time of day to head outside with your pet—based on real-time weather, heat levels, and paw comfort.")
                    .font(.body)
                    .foregroundColor(.petrichorText)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
            }
            .padding(.horizontal)
            
            Spacer()
            
            PetrichorButton(
                title: "Sounds good, continue",
                action: {
                    withAnimation {
                        // This will be handled by the parent container
                    }
                },
                style: .tertiary,
                size: .large,
                width: .fullWidth
            )
            .padding(.horizontal)
            .padding(.bottom, 50)
        }
    }
}

// MARK: - Step 2
struct OnboardingStep2: View {
    @Binding var showPetProfile: Bool
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            // Illustration placeholder
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.purple.opacity(0.1))
                    .frame(height: 300)
                
                VStack(spacing: 20) {
                    HStack(spacing: 15) {
                        // Multiple dogs illustration
                        Image(systemName: "pawprint.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.purple)
                        
                        Image(systemName: "pawprint.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.blue)
                        
                        Image(systemName: "pawprint.fill")
                            .font(.system(size: 35))
                            .foregroundColor(.green)
                    }
                    
                    Image(systemName: "tree.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.green.opacity(0.7))
                }
            }
            .padding(.horizontal)
            
            VStack(spacing: 16) {
                Text("Get tailored advice for your pet")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.petrichorTextPrimaryDark)
                    .multilineTextAlignment(.center)
                
                Text("Get insights designed just for your furry companion's breed, coat and sensitivities.")
                    .font(.body)
                    .foregroundColor(.petrichorText)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
            }
            .padding(.horizontal)
            
            Spacer()
            
            VStack(spacing: 20) {
                PetrichorButton(
                    title: "Set up my pet profile",
                    action: {
                        showPetProfile = true
                    },
                    style: .tertiary,
                    size: .large,
                    width: .fullWidth
                    
                )
                
                PetrichorButton(
                    title: "Set up later",
                    action: {
                        //Skip
                    },
                    style: .secondary,
                    size: .large
                )
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - Step 3
struct OnboardingStep3: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            // Illustration placeholder
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.blue.opacity(0.1))
                    .frame(height: 300)
                
                VStack(spacing: 20) {
                    HStack(spacing: 10) {
                        Image(systemName: "cloud.rain.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.blue)
                        
                        Image(systemName: "sun.max.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.yellow)
                    }
                    
                    Image(systemName: "figure.walk")
                        .font(.system(size: 50))
                        .foregroundColor(.primary)
                }
            }
            .padding(.horizontal)
            
            VStack(spacing: 16) {
                Text("Be ready, rain or shine")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.petrichorTextPrimaryDark)
                    .multilineTextAlignment(.center)
                
                Text("From sudden rains to scorching sun, we'll help you and your pet gear up with the right essentials")
                    .font(.body)
                    .foregroundColor(.petrichorText)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
            }
            .padding(.horizontal)
            
            Spacer()
            
            PetrichorButton(
                title: "Let's go!",
                action: {
                    dismiss()
                },
                style: .tertiary,
                size: .large,
                width: .fullWidth
            )
            .padding(.horizontal)
            .padding(.bottom, 74)
        }
    }
}

// MARK: - Preview
struct OnboardingFlow_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingFlow()
    }
}
