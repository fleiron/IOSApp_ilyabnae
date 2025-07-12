import SwiftUI

struct CustomDropDown: View {
    let categories: [String]
    @Binding var selectedCategory: String?
    @State private var isExpanded = false


    let accentColor = Color(red: 0.76, green: 0.58, blue: 0.0)
    let cornerRadiusValue: CGFloat = 8

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text(selectedCategory ?? "Category")
                        .foregroundColor(.white)
                        .padding(.leading)
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: cornerRadiusValue)
                            .fill(Color.white)
                            .frame(width: 44, height: 44)
                        
                        Image(systemName: isExpanded ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 13, height: 15)
                            .foregroundColor(accentColor)
                    }
                }
                
            }
            .buttonStyle(PlainButtonStyle())
            
            if isExpanded {
                VStack(spacing: 0) {
                    ForEach(categories, id: \.self) { category in
                        Button(action: {
                            selectedCategory = category
                            withAnimation {
                                isExpanded = false
                            }
                        }) {
                            Text(category)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(12)
                                .background(accentColor)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                
            }
        }
      
        .background(accentColor)
        .cornerRadius(cornerRadiusValue)
        .frame(width: 200)
       
    }
}

