import SwiftUI

struct AddClothingView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: WardrobeViewModel


    let categories = ["Bottoms", "Outwear", "Shoes"]

    @State private var selectedCategory: String? = nil
    @State private var name = ""
    @State private var brand = ""
    @State private var color: Color = .red
    @State private var level: Double = 2
    @State private var selectedUIImage: UIImage? = nil
    @State private var selectedImageData: Data? = nil


    @FocusState private var nameFieldIsFocused: Bool
    @FocusState private var brandFieldIsFocused: Bool

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    
              
                    Text("Add Clothes")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Ктегория
                    CustomDropDown(categories: categories, selectedCategory: $selectedCategory)
                    
                 
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Title of Clothing")
                            .foregroundColor(Color(red: 0.4, green: 0.6, blue: 0.9))
                        
                        HStack {
                            TextField("Type", text: $name)
                                .focused($nameFieldIsFocused)
                                .foregroundColor(.white)
                                .frame(height: 50)
                                .font(.system(size: 18, weight: .light))
                            
                            Button {
                                nameFieldIsFocused = true
                            } label: {
                                Image(systemName: "pencil")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(.white)
                                    .padding(6)
                                    .background(Color(red: 0.76, green: 0.58, blue: 0.0))
                                    .clipShape(Circle())
                            }
                        }
                        .padding(.horizontal)
                        .background(Color(white: 0.6))
                        .cornerRadius(8)
                    }
                    
                
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Brand")
                            .foregroundColor(Color(red: 0.4, green: 0.6, blue: 0.9))
                        
                        HStack {
                            TextField("Type", text: $brand)
                                .focused($brandFieldIsFocused)
                                .font(.system(size: 18, weight: .light))
                                .frame(height: 50)
                                .foregroundColor(.white)
                            
                            Button {
                                brandFieldIsFocused = true
                            } label: {
                                Image(systemName: "pencil")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(.white)
                                    .padding(6)
                                    .background(Color(red: 0.76, green: 0.58, blue: 0.0))
                                    .clipShape(Circle())
                            }
                        }
                        .padding(.horizontal)
                        .background(Color(white: 0.6))
                        .cornerRadius(8)
                    }
                    
                 
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Color")
                            .foregroundColor(Color(red: 0.4, green: 0.6, blue: 0.9))
                        
                        ColorPicker(colorName(for: color), selection: $color)
                            .frame(height: 40)
                            .padding()
                            .background(Color(white: 0.6))
                            .cornerRadius(8)
                    }
             
                    VStack(alignment: .leading, spacing: 4) {
                    WeatherSliderView(level: $level)
                        .offset(y: -10)
                }
                    
                    
                    ZStack {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 150)
                            .cornerRadius(10)

                        if let uiImage = selectedUIImage {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                                .cornerRadius(10)
                        } else {
                            Image(systemName: "camera")
                                .font(.system(size: 40))
                                .foregroundColor(.gray)
                        }
                    }
                    .onTapGesture {
                        selectedUIImage = UIImage(systemName: "tshirt")
                        if let uiImage = selectedUIImage {
                            selectedImageData = uiImage.jpegData(compressionQuality: 0.8)
                        }
                    }

                  
                    Button("SAVE") {
                        if let cat = selectedCategory {
                            let item = ClothingItemModel(
                                category: cat,
                                name: name,
                                brand: brand,
                                color: color,
                                weatherLevel: Int(level),
                                imageData: selectedImageData
                            )
                            viewModel.add(item: item)
                            dismiss()
                        }
                    }
                    .disabled(!(selectedCategory != nil && !name.isEmpty && !brand.isEmpty))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background((selectedCategory != nil && !name.isEmpty && !brand.isEmpty) ? Color.yellow : Color.gray)
                    .cornerRadius(8)
                }
                .padding()
            }
            .background(Color(red: 0.05, green: 0.10, blue: 0.30).ignoresSafeArea())
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Back") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
}

func colorName(for color: Color) -> String {
    
    switch color.description {
    case Color.red.description: return "Red"
    case Color.blue.description: return "Blue"
    case Color.green.description: return "Green"
    case Color.yellow.description: return "Yellow"
    case Color.orange.description: return "Orange"
    case Color.purple.description: return "Purple"
    case Color.black.description: return "Black"
    case Color.white.description: return "White"
    case Color.gray.description: return "Gray"
    default: return "Custom"
    }
}
