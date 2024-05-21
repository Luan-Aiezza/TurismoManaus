
import SwiftUI
import CoreLocation

struct FilterView: View {
    
    @Binding var selectedCategoria: Categorias
    @Binding var selectedHorario: Horarios
    @Binding var selectedDistancia: Distancias
    @Binding var selectedPreco: Precos
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Filtros")
                    .font(.headline)
                Spacer()
            }
            .padding()
            
            VStack {
                HStack{
                    Text("Local")
                    Spacer()
                }
                
                Picker(selection: $selectedCategoria, label: Text("")) {
                    Text("Todos").tag(Categorias.todos)
                    Text("Tradicional").tag(Categorias.tradicionais)
                    Text("Culinária").tag(Categorias.culinaria)
                    Text("Festas").tag(Categorias.festas)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding()
            
            VStack {
                HStack{
                    Text("Horário")
                    Spacer()
                }
                Picker(selection: $selectedHorario, label: Text("")) {
                    Text("Todos").tag(0)
                    Text("Manhã").tag(1)
                    Text("Tarde").tag(2)
                    Text("Noite").tag(3)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding()
            VStack {
                HStack{
                    Text("Distância")
                    Spacer()
                }
                Picker(selection: $selectedDistancia, label: Text("")) {
                    Text("Todos").tag(Distancias.todos)
                    Text("Até 3km").tag(Distancias.tres)
                    Text("Até 5km").tag(Distancias.cinco)
                    Text("Até 10km").tag(Distancias.dez)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding()
            
            //            VStack {
            //                HStack{
            //                    Text("Distância")
            //                    Spacer()
            //                }
            //                Picker(selection: $selectedDistancia, label: Text("")) {
            //                    Text("Todos").tag(0)
            //                    Text("Até 3km").tag(1)
            //                    Text("Até 5km").tag(2)
            //                    Text("Até 10km").tag(3)
            //                }
            //                .pickerStyle(SegmentedPickerStyle())
            //            }
            //            .padding()
            
            VStack {
                HStack{
                    Text("Preço")
                    Spacer()
                }
                Picker(selection: $selectedPreco, label: Text("")) {
                    Text("Todos").tag(Precos.todos)
                    Text("$").tag(Precos.barato)
                    Text("$$").tag(Precos.medio)
                    Text("$$$").tag(Precos.caro)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding()
        }
        .padding()
        
    }
    
    
}


