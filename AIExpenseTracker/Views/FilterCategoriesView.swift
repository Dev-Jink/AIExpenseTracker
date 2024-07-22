//
//  FilterCategoriesView.swift
//  AIExpenseTracker
//
//  Created by MyeongJin Kim on 7/22/24.
//

import SwiftUI

struct FilterCategoriesView: View {
    
    @Binding var selectedCategories: Set<Category>
    private let categories = Category.allCases
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(categories) { categories in
                        FilterButtonVieww(category: categories, isSelected: self.selectedCategories.contains(categories), onTap: self.onTap)
                    }
                }
                .padding(.horizontal)
            }
            
            if selectedCategories.count > 0 {
                Button(role: .destructive) {
                    self.selectedCategories.removeAll()
                } label: {
                    Text("Clear all filter selection (\(self.selectedCategories.count))")
                }
            }
        }
    }
    
    func onTap(category: Category) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }
}

struct FilterButtonVieww: View {
    
    var category: Category
    var isSelected: Bool
    var onTap: (Category) -> ()
    
    var body: some View {
        HStack(spacing: 4) {
            Text(category.rawValue.capitalized)
                .fixedSize(horizontal: true, vertical: true)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .stroke(isSelected ? category.color : Color.gray, lineWidth: 1)
                .overlay {
                    RoundedRectangle(cornerRadius: 16).foregroundColor(isSelected ? category.color : Color.clear)
                }
        }
        .frame(height: 44)
        .onTapGesture {
            self.onTap(category)
        }
        .foregroundColor(isSelected ? .white : nil)
    }
}

#Preview {
    @State var vm = LogListViewModel()
    return FilterCategoriesView(selectedCategories: $vm.selectedCategories)
}
