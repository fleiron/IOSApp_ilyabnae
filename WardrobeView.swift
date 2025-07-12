import SwiftUI

// MARK: - ClothingItemModel
struct ClothingItemModel: Identifiable, Hashable {
    let id = UUID()
    var category: String
    var name: String
    var brand: String
    var color: Color
    var weatherLevel: Int
    var imageData: Data?
}


class WardrobeViewModel: ObservableObject {
    @Published var items: [ClothingItemModel] = []

    var groupedItems: [String: [ClothingItemModel]] {
        Dictionary(grouping: items, by: { $0.category })
    }

    func add(item: ClothingItemModel) {
        items.append(item)
    }
}


struct WardrobeView: View {
    @EnvironmentObject var viewModel: WardrobeViewModel
    @State private var showingAddClothing = false

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                
                Color(red: 0.05, green: 0.10, blue: 0.30)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(viewModel.groupedItems.sorted(by: { $0.key < $1.key }), id: \.key) { category, items in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(category)
                                    .font(.title2)
                                    .foregroundColor(.white)

                                ForEach(items) { item in
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(item.name).foregroundColor(.white)
                                            Text(item.brand) .font(.system(size: 18, weight: .light)).foregroundColor(.white.opacity(0.7))
                                        }
                                        Spacer()
                                        if let data = item.imageData,
                                           let uiImage = UIImage(data: data) {
                                            Image(uiImage: uiImage)
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .cornerRadius(6)
                                        } else {
                                            Rectangle()
                                                .fill(item.color)
                                                .frame(width: 30, height: 30)
                                                .cornerRadius(4)
                                        }
                                    }
                                    .padding()
                                    .background(Color.yellow.opacity(0.5))
                                    .cornerRadius(8)
                                }
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Wardrobe")

                Button(action: { showingAddClothing = true }) {
                    Image(systemName: "plus")
                        .font(.system(size: 28, weight: .bold)) 
                        .foregroundColor(.white)
                        .frame(width: 55, height: 55)
                        .background(
                            Circle()
                                .fill(Color.yellow)
                                .overlay(
                                    Circle()
                                        .stroke(Color.white.opacity(0.5), lineWidth: 2)
                                )
                        )
                      
                }
                .padding()
                .fullScreenCover(isPresented: $showingAddClothing) {
                    AddClothingView()
                }
            }
        }
    }
}



