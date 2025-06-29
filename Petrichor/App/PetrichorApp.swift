import SwiftUI

@main
struct PetrichorApp: App {
    
    init() {
        FontRegistration.registerFonts()  // Add font registration
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
