//
//  FilterViewRefactored.swift
//  Turismo_Manaus
//
//  FilterView refatorada para MVVM - Usa FilterViewModel
//

import SwiftUI

struct FilterView: View {
    @ObservedObject var viewModel: FilterViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.fundofiltro
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Filtros Rápidos
                        quickFiltersSection
                        
                        // Seção de Categoria
                        FilterSection(
                            title: "Categoria",
                            icon: "tag.fill"
                        ) {
                            CategoryPicker(selectedCategory: $viewModel.selectedCategoria)
                        }
                        
                        // Seção de Preço
                        FilterSection(
                            title: "Faixa de Preço",
                            icon: "dollarsign.circle.fill"
                        ) {
                            PricePicker(selectedPrice: $viewModel.selectedPreco)
                        }
                        
                        // Seção de Distância
                        FilterSection(
                            title: "Distância",
                            icon: "location.fill"
                        ) {
                            DistancePicker(selectedDistance: $viewModel.selectedDistancia)
                        }
                        
                        // Seção de Horário
                        FilterSection(
                            title: "Horário de Funcionamento",
                            icon: "clock.fill"
                        ) {
                            HoursPicker(selectedHours: $viewModel.selectedHorario)
                        }
                        
                        Spacer(minLength: 100)
                    }
                    .padding()
                }
            }
            .navigationTitle("Filtros")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Limpar Tudo") {
                        viewModel.limparFiltros()
                    }
                    .foregroundColor(.red)
                    .disabled(!viewModel.hasActiveFilters)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Aplicar") {
                        dismiss()
                    }
                    .foregroundColor(.accentColorYellow)
                    .fontWeight(.semibold)
                }
            }
        }
    }
    
    // MARK: - Quick Filters Section
    private var quickFiltersSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "bolt.fill")
                    .foregroundColor(.accentColorYellow)
                Text("Filtros Rápidos")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
                ForEach(FiltroRapido.allCases, id: \.rawValue) { filtro in
                    QuickFilterButton(
                        filtro: filtro,
                        action: { viewModel.aplicarFiltroRapido(filtro) }
                    )
                }
            }
        }
        .padding()
        .background(Color.bgGlass1.opacity(0.3))
        .cornerRadius(12)
    }
}

// MARK: - Supporting Views

struct FilterSection<Content: View>: View {
    let title: String
    let icon: String
    @ViewBuilder let content: Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.accentColorYellow)
                    .frame(width: 20)
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
            }
            
            content
        }
        .padding()
        .background(Color.bgGlass1.opacity(0.2))
        .cornerRadius(12)
    }
}

struct QuickFilterButton: View {
    let filtro: FiltroRapido
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: filtro.icon)
                    .font(.system(size: 16))
                
                Text(filtro.rawValue)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(filtro.color.opacity(0.3))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(filtro.color, lineWidth: 1)
            )
        }
    }
}

struct CategoryPicker: View {
    @Binding var selectedCategory: Categories
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
            ForEach(Categories.allCases, id: \.id) { category in
                FilterOptionButton(
                    title: category.displayName,
                    icon: category.icon,
                    isSelected: selectedCategory == category
                ) {
                    selectedCategory = category
                }
            }
        }
    }
}

struct PricePicker: View {
    @Binding var selectedPrice: Prices
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
            ForEach(Prices.allCases, id: \.id) { price in
                FilterOptionButton(
                    title: price.displayName,
                    icon: price.icon,
                    isSelected: selectedPrice == price,
                    subtitle: price.priceRange
                ) {
                    selectedPrice = price
                }
            }
        }
    }
}

struct DistancePicker: View {
    @Binding var selectedDistance: Distances
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
            ForEach(Distances.allCases, id: \.id) { distance in
                FilterOptionButton(
                    title: distance.displayName,
                    icon: distance.icon,
                    isSelected: selectedDistance == distance,
                    subtitle: distance.transportSuggestion
                ) {
                    selectedDistance = distance
                }
            }
        }
    }
}

struct HoursPicker: View {
    @Binding var selectedHours: Hours
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 1), spacing: 12) {
            ForEach(Hours.allCases, id: \.id) { hour in
                FilterOptionButton(
                    title: hour.displayName,
                    icon: hour.icon,
                    isSelected: selectedHours == hour,
                    subtitle: hour.timeRange
                ) {
                    selectedHours = hour
                }
            }
        }
    }
}

struct FilterOptionButton: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let subtitle: String?
    let action: () -> Void
    
    init(title: String, icon: String, isSelected: Bool, subtitle: String? = nil, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.isSelected = isSelected
        self.subtitle = subtitle
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                HStack {
                    Image(systemName: icon)
                        .font(.system(size: 18))
                        .foregroundColor(isSelected ? .accentColorYellow : .white.opacity(0.7))
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(title)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(isSelected ? .accentColorYellow : .white)
                        
                        if let subtitle = subtitle {
                            Text(subtitle)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.6))
                        }
                    }
                    
                    Spacer()
                    
                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.accentColorYellow)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
            }
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isSelected ? Color.accentColorYellow.opacity(0.1) : Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(
                                isSelected ? Color.accentColorYellow : Color.white.opacity(0.2),
                                lineWidth: isSelected ? 2 : 1
                            )
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    FilterView(viewModel: FilterViewModel())
} 