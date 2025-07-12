import SwiftUI


struct GradientToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label

            ZStack {
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(white: 0.2))
                    .frame(width: 60, height: 30)

        
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: [Color(red: 0.4, green: 0.6, blue: 0.9), .white]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 2
                    )
                    .frame(width: 60, height: 30)

             
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color(red: 0.4, green: 0.6, blue: 0.9), .white]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 24, height: 24)
                    .offset(x: configuration.isOn ? 15 : -15)
                    .shadow(radius: 2)
                    .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
                    .onTapGesture {
                        configuration.isOn.toggle()
                    }
            }
        }
    }
}
