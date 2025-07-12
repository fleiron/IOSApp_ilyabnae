import CoreLocation
import CoreLocationUI
import SwiftUI

struct WeatherData: Decodable {
    let main: Main
    let name: String
    let sys: Sys
    
    struct Main: Decodable {
        let temp: Double
    }
    
    struct Sys: Decodable {
        let country: String
    }
}

class WeatherViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var temperature: Int?
    @Published var city: String = ""
    @Published var country: String = ""

    private let locationManager = CLLocationManager()
    private let apiKey = "bd5e378503939ddaee76f12ad7a97608"

    
    override init() {
        super.init()
        locationManager.delegate = self

  
        locationManager.requestWhenInUseAuthorization()

     
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }

        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude

        fetchWeather(lat: lat, lon: lon)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error:", error.localizedDescription)
    }

    func fetchWeather(lat: Double, lon: Double) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else { return }

        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoded = try JSONDecoder().decode(WeatherData.self, from: data)

                DispatchQueue.main.async {
                    self.temperature = Int(decoded.main.temp)
                    self.city = decoded.name.uppercased()
                    self.country = decoded.sys.country.uppercased()
                }
            } catch {
                print("Weather fetch error:", error)
            }
        }
    }
}
