import SwiftUI

struct StreetView: View {
    @StateObject private var weatherVM = WeatherViewModel()
    @State private var showOutfitPicker = false
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: Date())
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                
           
                HStack {
                    Text(formattedDate)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)

                    Spacer()

                    VStack(alignment: .trailing, spacing: 2) {
                        if let temp = weatherVM.temperature {
                            Text("\(temp) °C")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                        }
                        Text("\(weatherVM.city), \(weatherVM.country)")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)

  
                VStack(alignment: .leading, spacing: 8) {
                    Text("Morning")
                        .font(.system(size: 16, weight: .medium))
                   
                        .foregroundColor(.white)
                        .padding(.horizontal)

                    Button(action: {
                        showOutfitPicker.toggle()
                    }) {
                        VStack {
                            Image(systemName: "hanger")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                            Text("Pick Outfit")
                                .foregroundColor(.white)
                                .font(.system(size: 24, weight: .regular))
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 120)
                        .background(Color(red: 0.5, green: 0.5, blue: 0.1)) 
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(red: 0.96, green: 0.76, blue: 0.17), lineWidth: 2)
                        )
                        .cornerRadius(8)
                        .padding(.horizontal)
                    }
                    .fullScreenCover(isPresented: $showOutfitPicker) {
                        OutfitPickerView()
                    }
                }

                Spacer()
            }
            .background(Color(red: 0.05, green: 0.10, blue: 0.30).ignoresSafeArea())
        }
    }
}
