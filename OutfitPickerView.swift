

import SwiftUI

struct ClothingItem: Identifiable, Hashable {
    let id = UUID()
    let category: String
    let name: String
    let brand: String
    let color: Color
    let systemName: String
}

let outerwearItems = [
    ClothingItem(category: "Outerwear", name: "Jacket", brand: "Tommy Hilfiger", color: .purple, systemName: "person.fill"),
    ClothingItem(category: "Outerwear", name: "Jacket", brand: "Tommy Hilfiger", color: .black, systemName: "person.fill")
]

let bottomsItems = [
    ClothingItem(category: "Bottoms", name: "Jeans", brand: "Levi's", color: .blue, systemName:"jeans"),
    ClothingItem(category: "Bottoms", name: "Shorts", brand: "Nike", color: .gray, systemName: "shorts")
]

let shoesItems = [
    ClothingItem(category: "Shoes", name: "Sneakers", brand: "Adidas", color: .red, systemName: "sneakers"),
    ClothingItem(category: "Shoes", name: "Boots", brand: "Timberland", color: .brown, systemName: "boots")
] // systemName можно потом улучшить

struct OutfitPickerView: View {
    @Environment(\.dismiss) var dismiss

    @State private var isOuterwearEnabled = false
    @State private var isBottomsEnabled = false
    @State private var isShoesEnabled = false

    @State private var selectedOuterwear: ClothingItem? = nil
    @State private var selectedBottoms: ClothingItem? = nil
    @State private var selectedShoes: ClothingItem? = nil

    @State private var showingCategory: String? = nil

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Outfit Selection")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                    Text("Morning")
                        .foregroundColor(.white.opacity(0.8))

                    categoryToggle(title: "Outerwear", isEnabled: $isOuterwearEnabled, selectedItem: $selectedOuterwear, items: outerwearItems)
                    categoryToggle(title: "Bottoms", isEnabled: $isBottomsEnabled, selectedItem: $selectedBottoms, items: bottomsItems)
                    categoryToggle(title: "Shoes", isEnabled: $isShoesEnabled, selectedItem: $selectedShoes, items: shoesItems)

                    Spacer()
                }
                .padding()
            }
            .background(Color(red: 0.05, green: 0.10, blue: 0.30).ignoresSafeArea())
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Back") { dismiss() }.foregroundColor(.white)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") { dismiss() }
                        .foregroundColor(canSave ? .yellow : .gray)
                        .disabled(!canSave)
                }
            }
            .sheet(item: Binding(get: {
                showingCategory.map { IdentifiableString(value: $0) }
            }, set: {
                showingCategory = $0?.value
            })) { identifiable in
                SelectionSheetView(
                    items: items(for: identifiable.value),
                    selectedItem: selectedBinding(for: identifiable.value),
                    category: identifiable.value
                )
                .presentationDetents([.fraction(0.5)])
                .presentationDragIndicator(.visible)
            }
        }
    }

    func categoryToggle(title: String, isEnabled: Binding<Bool>, selectedItem: Binding<ClothingItem?>, items: [ClothingItem]) -> some View {
        VStack(spacing: 8) {
            HStack {
                Text(title).fontWeight(.semibold).foregroundColor(.black)
                Spacer()
                Toggle("", isOn: isEnabled)
                    .onChange(of: isEnabled.wrappedValue) { newValue in
                        if newValue {
                            selectedItem.wrappedValue = items.first
                        } else {
                            selectedItem.wrappedValue = nil
                        }
                    }
                    .toggleStyle(GradientToggleStyle())
            }
            .padding()
            .background(Color.yellow)
            .cornerRadius(8)

            if isEnabled.wrappedValue {
                if let selected = selectedItem.wrappedValue {
                    Button(action: { showingCategory = title }) {
                        HStack(spacing: 12) {
                            Image(systemName: "tshirt")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.yellow)
                                .cornerRadius(6)
                            VStack(alignment: .leading) {
                                Text(selected.name).foregroundColor(.white)
                                Text(selected.brand).font(.caption).foregroundColor(.white.opacity(0.7))
                            }
                            Spacer()
                            Rectangle()
                                .fill(selected.color)
                                .frame(width: 20, height: 20)
                                .cornerRadius(4)
                            VStack(spacing: 2) {
                                  Image(systemName: "chevron.up")
                                      .foregroundColor(.white)
                                      .font(.system(size: 16, weight: .bold))
                                      .offset(y: -4)
                                  Image(systemName: "chevron.down")
                                      .foregroundColor(.white)
                                      .font(.system(size: 16, weight: .bold))
                              }
                        }
                        .padding()
                        .background(Color.yellow.opacity(0.3))
                        .cornerRadius(8)
                    }
                } else if items.isEmpty {
                    Text("У цій категорії немає одягу")
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }
            }
        }
    }

    var canSave: Bool {
        (isOuterwearEnabled && selectedOuterwear != nil) ||
        (isBottomsEnabled && selectedBottoms != nil) ||
        (isShoesEnabled && selectedShoes != nil)
    }

    func items(for category: String) -> [ClothingItem] {
        switch category {
        case "Outerwear": return outerwearItems
        case "Bottoms": return bottomsItems
        case "Shoes": return shoesItems
        default: return []
        }
    }

    func selectedBinding(for category: String) -> Binding<ClothingItem?> {
        switch category {
        case "Outerwear": return $selectedOuterwear
        case "Bottoms": return $selectedBottoms
        case "Shoes": return $selectedShoes
        default: return .constant(nil)
        }
    }
}

struct SelectionSheetView: View {
    let items: [ClothingItem]
    @Binding var selectedItem: ClothingItem?
    let category: String
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 16) {
            Text(category.uppercased())
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 20)

            ScrollView {
                VStack(spacing: 12) {
                    ForEach(items, id: \.self) { item in
                        Button(action: {
                            selectedItem = item
                            dismiss()
                        }) {
                            HStack(spacing: 12) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.name).foregroundColor(.white)
                                    Text(item.brand).font(.caption).foregroundColor(.white.opacity(0.7))
                                }
                                Spacer()
                                Rectangle()
                                    .fill(item.color)
                                    .frame(width: 20, height: 20)
                                    .cornerRadius(4)
                                if selectedItem == item {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.white)
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 0.5, green: 0.5, blue: 0.1))
                            .cornerRadius(8)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.bottom)
        .background(Color(red: 0.05, green: 0.10, blue: 0.30).ignoresSafeArea())
    }
}

struct IdentifiableString: Identifiable {
    var id: String { value }
    let value: String
}
