
import SwiftUI
import CoreLocation

struct FilterView: View {
    
    @Binding var selectedCategoria: Categorias
    @Binding var selectedHorario: Horarios
    @Binding var selectedDistancia: Distancias
    @Binding var selectedPreco: Precos
    
    @ObservedObject var locationViewModel: LocationViewModel
    
    private func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Filtros")
                    .font(.headline)
                Spacer()
            }
            .padding()
           
            
            //            VStack {
            //                HStack{
            //                    Text("Horário")
            //                    Spacer()
            //                }
            //                Picker(selection: $selectedHorario, label: Text("")) {
            //                    Text("Todos").tag(0)
            //                    Text("Manhã").tag(1)
            //                    Text("Tarde").tag(2)
            //                    Text("Noite").tag(3)
            //                }
            //                .pickerStyle(SegmentedPickerStyle())
            //            }
            //            .padding()
            
            
            
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
            
            if (locationViewModel.locationManager?.authorizationStatus != .denied) {
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
            }
            
            else {
                VStack(spacing: 20) {
                    HStack{
                        Text("Distância")
                        Spacer()
                    }
                    VStack (spacing: 20){
                        Text("Permita o acesso a localização para usar esse filto")
                            .font(.caption)
                        Button(action: {
                            openSettings()
                        }, label: {
                            Text("Ajustes")
                                .bold()
                                .foregroundStyle(Color.blue)
                        })
                    }
                }
                .foregroundStyle(Color.black)
                .padding()
                
            }

        }
        .foregroundStyle(Color.black)
        
    }
    
}
    
    
