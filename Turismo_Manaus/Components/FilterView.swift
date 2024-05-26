
import SwiftUI
import SceneKit
import GameKit
import CoreLocation
import Foundation

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
        
        ZStack {
            Color.bgGlass1
                .ignoresSafeArea()
                .blur(radius: 50.0)
                .border(Color.bgGlass1, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.clear), alignment: .bottom
                )
            VStack {
                VStack {
                    HStack {
                        Text("Cancelar")
                        Spacer()
                        Text("Filtros")
                        Spacer()
                        Text("Salvar")
                    }
                    .padding(.bottom, 35.0)
                    HStack{
                        Text("Horário")
                        Spacer()
                    }
                    
                    Picker(selection: $selectedHorario, label: Text("")) {
                        Text("Todos").tag(Horarios.todos)
                        Text("Manhã").tag(Horarios.manha)
                        Text("Tarde").tag(Horarios.tarde)
                        Text("Noite").tag(Horarios.noite)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                            .cornerRadius(8)
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
                Spacer()
            }.padding(16.0)
        }
        .ignoresSafeArea()
        
    }
    
}
