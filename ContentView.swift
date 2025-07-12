import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Int = 0

    var body: some View {
        VStack(spacing: 0) {
            
            ZStack {
                if selectedTab == 0 {
                    StreetView()
                } else if selectedTab == 1 {
                    WardrobeView()
                }
            }
            
            HStack(spacing: 0) {
                Button(action: {
                    selectedTab = 0
                }) {
                    Text("Street")
                        .font(.footnote)
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity)
                        .background(selectedTab == 0 ? Color(red: 0.96, green: 0.76, blue: 0.17) : Color.white)
                        .foregroundColor(selectedTab == 0 ? .black : .gray)
                }

                Button(action: {
                    selectedTab = 1
                }) {
                    Text("Wardrobe")
                        .font(.footnote)
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity)
                        .background(selectedTab == 1 ? Color(red: 0.96, green: 0.76, blue: 0.17) : Color.white)
                        .foregroundColor(selectedTab == 1 ? .black : .gray)
                }
            }
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(red: 0.96, green: 0.76, blue: 0.17), lineWidth: 2)
            )
            .padding(.horizontal, 20)
            .padding(.bottom, 20) 
            .background(Color.clear)
        }
        .background(Color(red: 0.05, green: 0.10, blue: 0.30).ignoresSafeArea())
    }
}
