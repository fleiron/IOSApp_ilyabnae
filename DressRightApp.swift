import SwiftUI

@main
struct YourAppNameApp: App {
    @StateObject var wardrobeViewModel = WardrobeViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(wardrobeViewModel)
        }
    }
}
