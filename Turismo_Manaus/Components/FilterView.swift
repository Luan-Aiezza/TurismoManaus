
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
    @Binding var isShowingFilterView: Bool
    
    @ObservedObject var locationViewModel: LocationViewModel
    
    private func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }
    
    var body: some View {
        
        ZStack {
        
   Color.black
           .ignoresSafeArea()
                .opacity(0.8)
                .border(Color.bgGlass1, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.clear), alignment: .bottom
                )
            VStack {
                VStack {
                    HStack {
                        Button(action: {
                            isShowingFilterView.toggle()
                            selectedPreco = Precos.todos
                            selectedHorario = Horarios.todos
                            selectedDistancia = Distancias.todos
                            selectedCategoria = Categorias.todos
                        }, label: {
                            Text("Cancelar")
                                .foregroundStyle(.white)
                        })
                        
                        Spacer()
                        Text("Filtros")
                            .foregroundStyle(.white)
                        Spacer()
                        Button(action: {
                            isShowingFilterView.toggle()
                        }, label: {
                            Text("   Salvar")
                                .foregroundStyle(.white)
                                .frame(width: 72)
                        })
                    }
                    .padding(.vertical, 8.0)
                    HStack{
                        Text("Horário")
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    .padding(.top,16.0)
                    
                    
                    Picker(selection: $selectedHorario, label: Text("")) {
                        Text("Todos").tag(Horarios.todos)
                        Text("Manhã").tag(Horarios.manha)
                        Text("Tarde").tag(Horarios.tarde)
                        Text("Noite").tag(Horarios.noite)
                    }
                    .foregroundStyle(.blue)
                    .pickerStyle(SegmentedPickerStyle())
                    .cornerRadius(8)
                    .padding(.vertical, 8.0)
                }
                
                VStack {
                    HStack{
                        Text("Local")
                            .foregroundStyle(.white)
                        Spacer()
                    }.padding(.top,16.0)
                    
                    Picker(selection: $selectedCategoria, label: Text("")) {
                        Text("Todos").tag(Categorias.todos)
                        Text("Tradicional").tag(Categorias.tradicionais)
                        Text("Culinária").tag(Categorias.culinaria)
                        Text("Festas").tag(Categorias.festas)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.vertical, 8.0)
                }
                
                
                VStack {
                    HStack{
                        Text("Preço")
                            .foregroundStyle(.white)
                        Spacer()
                    }.padding(.top,16.0)
                    Picker(selection: $selectedPreco, label: Text("")) {
                        Text("Todos").tag(Precos.todos)
                        Text("$").tag(Precos.barato)
                        Text("$$").tag(Precos.medio)
                        Text("$$$").tag(Precos.caro)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.vertical, 8.0)
                }
                
                if (locationViewModel.locationManager?.authorizationStatus != .denied) {
                    VStack {
                        HStack{
                            Text("Distância")
                                .foregroundStyle(.white)
                            Spacer()
                        }
                        .padding(.top,16.0)
                        Picker(selection: $selectedDistancia, label: Text("")) {
                            Text("Todos").tag(Distancias.todos)
                            Text("Até 3km").tag(Distancias.tres)
                            Text("Até 5km").tag(Distancias.cinco)
                            Text("Até 10km").tag(Distancias.dez)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.vertical, 8.0)
                    }
                }
                
                else {
                    VStack(spacing: 20) {
                        HStack{
                            Text("Distância")
                                .foregroundStyle(.white)
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
                    .padding()
                    
                }
                Spacer()
            }.padding(16.0)
                .foregroundStyle(.white)
        }
        .ignoresSafeArea()
        
    }
    
}
