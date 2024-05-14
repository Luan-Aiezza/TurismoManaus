
import SwiftUI



struct FilterView: View {
    @State private var selectedTab: Int = 0
    @State private var selectedLocal: Int = 0
    @State private var selectedHorario: Int = 0
    @State private var selectedDistancia: Int = 0
    @State private var selectedPreco: Int = 0
    
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

                Picker(selection: $selectedLocal, label: Text("")) {
                    Text("Aleatório").tag(0)
                    Text("Tradicional").tag(1)
                    Text("Culinária").tag(2)
                    Text("Festas").tag(3)
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
                    Text("Aleatório").tag(0)
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
                    Text("Aleatório").tag(0)
                    Text("Até 3km").tag(1)
                    Text("Até 5km").tag(2)
                    Text("Até 10km").tag(3)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding()
            
            VStack {
                HStack{
                    Text("Preço")
                    Spacer()
                }
                Picker(selection: $selectedPreco, label: Text("")) {
                    Text("Aleatório").tag(0)
                    Text("0-50 R$").tag(1)
                    Text("50-100 R$").tag(2)
                    Text("100+ R$").tag(3)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding()
        }
        .padding()
        
    }
}

#Preview {
    FilterView()
}
