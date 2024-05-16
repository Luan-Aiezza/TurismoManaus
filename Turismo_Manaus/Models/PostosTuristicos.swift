import Foundation

enum Categorias {
    case tradicionais
    case culinaria
    case festas
}

enum Precos {
    case barato
    case medio
    case caro
}

var PontosTuristicos: [PontoTuristico] = [
    
    PontoTuristico(id: UUID(), name: "Parque Senador Jefferson Péres", desc: "Parque urbano amplo ao longo de um riacho com um pórtico de arcos em ferro, uma trilha coberta e monumentos.", categoria: Categorias.tradicionais, latitude: "-3.1308190156009417", longitude: "-60.01565870581663", preco: Precos.barato, horarios: ["05:00-21:00", "05:00-21:00", "05:00-21:00", "05:00-21:00", "05:00-21:00", "05:00-21:00", "05:00-21:00"]),
    
    PontoTuristico(id: UUID(), name: "Parque Estadual Sumaúma", desc: "Parque integrado por uma ampla área protegida, espaço com elementos do imaginário amazônico e trilhas.", categoria: Categorias.tradicionais, latitude: "-3.027970927183905", longitude: "-59.9796098154616", preco: Precos.barato, horarios: ["Fechado", "08:00–17:00", "08:00–17:00", "08:00–17:00", "08:00–17:00", "06:00–18:00", "06:00–18:00"]),
    
    PontoTuristico(id: UUID(), name: "Parque Municipal do Mindu", desc: "Área de conservação com belas vistas, trilhas na floresta, equipamentos de recreação, anfiteatro e biblioteca.", categoria: Categorias.tradicionais, latitude: "-3.070139843495979", longitude: "-60.00776228221505", preco: Precos.barato, horarios: ["Fechado", "05:00–17:00", "05:00–17:00", "05:00–17:00", "05:00–17:00", "05:00–17:00", "05:00–17:00"]),
    
    PontoTuristico(id: UUID(), name: "Museu da Amazônia - MUSA", desc: "Área florestal com tours guiados pela flora, fauna e cultura amazônicas, além de uma torre com mirante.", categoria: Categorias.tradicionais, latitude: "-3.003074936062124", longitude: "-59.939695460412175", preco: Precos.barato, horarios: ["08:30–17:00", "08:30–17:00", "Fechado", "08:30–17:00", "08:30–17:00", "08:30–17:00", "08:30–17:00"]),
    
    PontoTuristico(id: UUID(), name: "Palácio Rio Negro", desc: "Propriedade de um barão da borracha do séc. XIX com decoração da época, exposições históricas e jardins.", categoria: Categorias.tradicionais, latitude: "-3.1273719709009646", longitude: "-60.01637515443204", preco: Precos.barato, horarios: ["09:00–15:00", "Fechado", "09:00–15:00", "09:00–15:00", "09:00–15:00", "09:00–15:00", "Fechado"]),
    
    PontoTuristico(id: UUID(), name: "Mirante de São Vicentee", desc: "Excelente opção de Lazer em Manaus, agregando modernidade a natureza no Centro Histórico de Manaus.", categoria: Categorias.tradicionais, latitude: "-3.126270054252635", longitude: "-60.03008918935117", preco: Precos.barato, horarios: ["08:00–23:00", "08:00–23:00", "08:00–23:00", "08:00–23:00", "08:00–23:00", "07:00–00:00", "07:00–22:00"]),
    
    PontoTuristico(id: UUID(), name: "Palacete Provincial", desc: "Antiga sede da polícia do século XIX que abriga museus de arte, numismática, arqueologia e muito mais.", categoria: Categorias.tradicionais, latitude: "-3.1315248892455627", longitude: "-60.02085545975643", preco: Precos.barato, horarios: ["09:00–15:00", "09:00–15:00", "Fechado", "09:00–15:00", "09:00–15:00", "09:00–15:00", "Fechado"]),
    
    PontoTuristico(id: UUID(), name: "Largo de São Sebastião", desc: "Praça cercada por árvores e prédios históricos com um grande monumento e apresentações artísticas.", categoria: Categorias.tradicionais, latitude: "-3.121563096202804", longitude: "-60.02252516112234", preco: Precos.barato, horarios: ["00:00-23:59", "00:00-23:59", "00:00-23:59", "00:00-23:59", "00:00-23:59", "00:00-23:59", "00:00-23:59"]),
    
    PontoTuristico(id: UUID(), name: "Praça 5 de Setembro (Praça da Saudade)", desc: "Praça arborizada em um antigo cemitério com memorial ao poeta Tenreiro Aranha e uma pérgola.", categoria: Categorias.tradicionais, latitude: "-3.1188205858951554", longitude: "-60.0256150660099", preco: Precos.barato, horarios: ["00:00-23:59", "00:00-23:59", "00:00-23:59", "00:00-23:59", "00:00-23:59", "00:00-23:59", "00:00-23:59"]),
    
    PontoTuristico(id: UUID(), name: "Balneário José Ribeiro Soares SESC", desc: "Parques Aquáticos I e II; 9h às 16h30 (domingos e feriados)", categoria: Categorias.tradicionais, latitude: "-3.0679256505131125", longitude: "-60.044545826691326", preco: Precos.medio, horarios: ["Fechado", "Fechado", "Fechado", "Fechado", "Fechado", "Fechado", "08:30–17:00"]),
    
    PontoTuristico(id: UUID(), name: "Cantare Karaoke & Pub", desc: "Ponto de encontro aconchegante e descontraído para fãs de karaokê, com diversas opções de petiscos e drinques.", categoria: Categorias.festas, latitude: "-3.0985964278517333", longitude: "-60.02067005547076", preco: Precos.medio, horarios: ["Fechado", "19:00–00:00", "19:00–00:00", "19:00–00:00", "19:00–02:00", "19:00–02:00", "Fechado"]),
    
    PontoTuristico(id: UUID(), name: "All Night Pub", desc: "Happy hours e comidinhas em casa de entretenimento noturno com apresentações ao vivo de pop, rock e sertanejo.", categoria: Categorias.festas, latitude: "-3.0848611174598015", longitude: "-59.99972264384931", preco: Precos.caro, horarios: ["Fechado", "Fechado", "Fechado", "22:00–05:00", "22:00–06:00", "22:00–06:00", "Fechado"]),
    
    PontoTuristico(id: UUID(), name: "Coco Bambu Manaus", desc: "Restaurante de frutos do mar", categoria: Categorias.culinaria, latitude: "-3.0850076042000887", longitude: "-60.07218105716932", preco: Precos.caro, horarios: ["11:30–15:00, 17:00–00:00", "11:30–15:00, 17:00–00:00", "11:30–15:00, 17:00–00:00", "11:30–15:00, 17:00–00:00", "11:30–00:00", "11:30–00:00", "11:30–00:00"]),
    
    PontoTuristico(id: UUID(), name: "Amazonas Shopping", desc: "Shopping de vários andares com lojas, praça de alimentação e entretenimento, incluindo um cinema.", categoria: Categorias.tradicionais, latitude: "-3.092207923083299", longitude: "-60.02273752499065", preco: Precos.medio, horarios: ["10:00–22:00", "10:00–22:00", "10:00–22:00", "10:00–22:00", "10:00–22:00", "10:00–22:00", "10:00–21:00"]),
    
    PontoTuristico(id: UUID(), name: "Café Da Manhã Tradicional", desc: "Bons produtos e preços bem abaixo dos demais.", categoria: Categorias.culinaria, latitude: "-3.1025467026171", longitude: "-60.00158713558179", preco: Precos.barato, horarios: ["06:00–19:00", "06:00–19:00", "06:00–19:00", "06:00–19:00", "06:00–19:00", "06:00–12:00", "06:00–12:00"]),
    
    PontoTuristico(id: UUID(), name: "Brunch Diner & Coffee", desc: "Restaurante tranquilo e animado que serve pratos de café da manhã em estilo americano, como bagels e waffles.", categoria: Categorias.culinaria, latitude: "-3.0892539917497306", longitude: "-59.99528967251497", preco: Precos.caro, horarios: ["Fechado", "07:30–21:00", "07:30–21:00", "07:30–21:00", "07:30–21:00", "07:30–21:00", "07:30–13:00"]),
    
    PontoTuristico(id: UUID(), name: "JSK Burgers - Praça Laranjeiras", desc: "Espaço informal com restaurantes para todos os gostos, incluindo opções italianas, japonesas e brasileiras.", categoria: Categorias.culinaria, latitude: "-3.064217688051578", longitude: "-60.011597763608016", preco: Precos.caro, horarios: ["Fechado", "17:00–23:00", "17:00–23:00", "17:00–23:00", "17:00–23:00", "17:00–23:00", "17:00–23:00"]),
    
    PontoTuristico(id: UUID(), name: "Porão do Alemão Rock bar", desc: "Local animado com rock ao vivo, comida simples, um bar e duas áreas externas.", categoria: Categorias.festas, latitude: "-3.09497997969293", longitude: "-60.05116591501288", preco: Precos.medio, horarios: ["Fechado", "Fechado", "19:00–06:00", "19:00–04:00", "19:00–06:00", "19:00–06:00", "Fechado"]),
    
    PontoTuristico(id: UUID(), name: "K4 Lounge", desc: "Sexta-feira e Sábado. Somente maiores de idade. Avenida Visconde de Porto Seguro, 8, Flores.", categoria: Categorias.festas, latitude: "-3.062807768564073", longitude: "-60.005303496295994", preco: Precos.medio, horarios: ["Fechado", "Fechado", "Fechado", "Fechado", "22:00–04:00", "22:00–04:00", "Fechado"]),
    
    PontoTuristico(id: UUID(), name: "Fabrica & Sorveteria Glacial", desc: "Há mais de 45 anos refrescando o povo manauara com o autêntico sabor da Amazônia.", categoria: Categorias.culinaria, latitude: "-3.1156668489851396", longitude: "-60.01669911973841", preco: Precos.medio, horarios: ["09:30–23:00", "09:30–23:00", "09:30–23:00", "09:30–23:00", "09:30–23:00", "09:30–23:00", "09:30–23:00"]),
    
    ]
