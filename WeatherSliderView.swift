import SwiftUI


struct WeatherSliderView: View {
    @Binding var level: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Level")
                .font(.headline)
                .foregroundColor(Color(red: 0.4, green: 0.6, blue: 0.9))
                .frame(maxWidth: .infinity, alignment: .leading)

            Slider(value: $level, in: 0...4, step: 1)
                .accentColor(Color(red: 0.4, green: 0.6, blue: 0.9))
                .tint(.white) 

            HStack {
                Image(systemName: "leaf.fill")
                Spacer()
                Image(systemName: "sunset.fill")
                Spacer()
                Image(systemName: "snowflake")
            }
            .foregroundColor(Color(red: 0.4, green: 0.6, blue: 0.9))
            .font(.system(size: 24, weight: .bold))
            
            VStack(alignment: .leading, spacing: 4) {
                Text("0 - the level of clothing that is suitable in very hot weather")
                    .font(.caption)
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)

                Text("4 - the level of clothing that is suitable in very cold weather")
                    .font(.caption)
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            .frame(maxWidth: .infinity, alignment: .leading)


        }
    }
}
