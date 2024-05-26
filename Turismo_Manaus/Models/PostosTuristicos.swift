import Foundation

enum Categorias: String {
    case todos = "todos"
    case tradicionais = "tradicionais"
    case culinaria = "culinaria"
    case festas = "festas"
}

enum Precos {
    case todos
    case barato
    case medio
    case caro
}


enum Horarios {
    case todos
    case manha
    case tarde
    case noite
}

enum Distancias {
    case todos
    case tres
    case cinco
    case dez
}



public var PontosTuristicos: [PontoTuristico] = [
    
    PontoTuristico(id: UUID(), name: "Parque Senador Jefferson Péres", desc: "Parque urbano amplo ao longo de um riacho com um pórtico de arcos em ferro, uma trilha coberta e monumentos.", categoria: Categorias.tradicionais, latitude: "-3.1308190156009417", longitude: "-60.01565870581663", preco: Precos.barato, horarios: Horarios.todos, distancia: Distancias.tres, status: "dia e noite", maps: "https://maps.app.goo.gl/q3oLwFAFjdVN9wcDA"),
    
    PontoTuristico(id: UUID(), name: "Parque Estadual Sumaúma", desc: "Parque integrado por uma ampla área protegida, espaço com elementos do imaginário amazônico e trilhas.", categoria: Categorias.tradicionais, latitude: "-3.027970927183905", longitude: "-59.9796098154616", preco: Precos.barato, horarios: Horarios.manha, distancia: Distancias.tres, status: "dia", maps: "https://maps.app.goo.gl/tr6gz9hRBmtbTgmT6"),
    
    PontoTuristico(id: UUID(), name: "Parque Municipal do Mindu", desc: "Área de conservação com belas vistas, trilhas na floresta, equipamentos de recreação, anfiteatro e biblioteca.", categoria: Categorias.tradicionais, latitude: "-3.070139843495979", longitude: "-60.00776228221505", preco: Precos.barato, horarios: Horarios.manha, distancia: Distancias.tres, status: "dia", maps: "https://maps.app.goo.gl/WaFpsXCTGqi6HGJG6"),
    
    PontoTuristico(id: UUID(), name: "Museu da Amazônia - MUSA", desc: "Área florestal com tours guiados pela flora, fauna e cultura amazônicas, além de uma torre com mirante.", categoria: Categorias.tradicionais, latitude: "-3.003074936062124", longitude: "-59.939695460412175", preco: Precos.barato, horarios: Horarios.manha, distancia: Distancias.tres, status: "dia", maps: "https://maps.app.goo.gl/avTvoNcvtb7feUpq8"),
    
    PontoTuristico(id: UUID(), name: "Palácio Rio Negro", desc: "Propriedade de um barão da borracha do séc. XIX com decoração da época, exposições históricas e jardins.", categoria: Categorias.tradicionais, latitude: "-3.1273719709009646", longitude: "-60.01637515443204", preco: Precos.barato, horarios: Horarios.manha, distancia: Distancias.tres, status: "dia", maps: "https://maps.app.goo.gl/taKnhn7r9GqNgbnW7"),
    
    PontoTuristico(id: UUID(), name: "Mirante de São Vicentee", desc: "Excelente opção de Lazer em Manaus, agregando modernidade a natureza no Centro Histórico de Manaus.", categoria: Categorias.tradicionais, latitude: "-3.126270054252635", longitude: "-60.03008918935117", preco: Precos.barato, horarios: Horarios.todos, distancia: Distancias.tres, status: "dia e noite", maps: "https://maps.app.goo.gl/TieXusvXgXM8ojkE8"),
    
    PontoTuristico(id: UUID(), name: "Palacete Provincial", desc: "Antiga sede da polícia do século XIX que abriga museus de arte, numismática, arqueologia e muito mais.", categoria: Categorias.tradicionais, latitude: "-3.1315248892455627", longitude: "-60.02085545975643", preco: Precos.barato, horarios: Horarios.manha, distancia: Distancias.tres, status: "dia", maps: "https://maps.app.goo.gl/8suT7NpNiY1EYaWQA"),
    
    PontoTuristico(id: UUID(), name: "Largo de São Sebastião", desc: "Praça cercada por árvores e prédios históricos com um grande monumento e apresentações artísticas.", categoria: Categorias.tradicionais, latitude: "-3.121563096202804", longitude: "-60.02252516112234", preco: Precos.barato, horarios: Horarios.todos, distancia: Distancias.tres, status: "dia e noite", maps: "https://maps.app.goo.gl/5UJnZezpxnDMq2TF8"),
    
    PontoTuristico(id: UUID(), name: "Praça 5 de Setembro (Praça da Saudade)", desc: "Praça arborizada em um antigo cemitério com memorial ao poeta Tenreiro Aranha e uma pérgola.", categoria: Categorias.tradicionais, latitude: "-3.1188205858951554", longitude: "-60.0256150660099", preco: Precos.barato, horarios: Horarios.todos, distancia: Distancias.tres, status: "dia e noite", maps: "https://maps.app.goo.gl/NpAG4YnZ9daZtVrb6"),
    
    PontoTuristico(id: UUID(), name: "Parque da Ponta Negra", desc: "Praia famosa no Rio Amazonas em meio a áreas verdes, mirantes e um anfiteatro.", categoria: Categorias.tradicionais, latitude: "-3.0559997192845603", longitude: "-60.10194715359573", preco: Precos.barato, horarios: Horarios.todos, distancia: Distancias.tres, status: "dia e noite", maps: "https://maps.app.goo.gl/G1pdapFWeFrE7f6T8"),
    
    PontoTuristico(id: UUID(), name: "Teatro Amazonas", desc: "Famoso teatro renascentista de 1896, auge da borracha na cidade, com capacidade para concertos e passeios.", categoria: Categorias.tradicionais, latitude: "-3.1262607690026063", longitude: "-60.023156727216026", preco: Precos.barato, horarios: Horarios.tarde, distancia: Distancias.tres, status: "tarde", maps: "https://maps.app.goo.gl/a5sr7v2aX7sMFYut5"),
    
    PontoTuristico(id: UUID(), name: "Museu Internacional do Esporte", desc: "Nossa história toda em um só lugar, o melhor futebol, os craques, as jogadas e tudo para se ver.", categoria: Categorias.tradicionais, latitude: "-3.0835426374271613", longitude: "-60.02911182023614", preco: Precos.barato, horarios: Horarios.tarde, distancia: Distancias.tres, status: "tarde", maps: "https://maps.app.goo.gl/aBtLC742d69Dr8Vq9"),
    
    PontoTuristico(id: UUID(), name: "Museu Do Homem Do Norte", desc: "Ótimo lugar para conhecer uma parte importante da história de nossa cidade.", categoria: Categorias.tradicionais, latitude: "-3.1330740388261384", longitude: "-59.986923379763866", preco: Precos.barato, horarios: Horarios.manha, distancia: Distancias.tres, status: "dia", maps: "https://maps.app.goo.gl/U3xdFMsgExEeMXTi6"),
    
    PontoTuristico(id: UUID(), name: "Mercado Municipal Adolpho Lisboa", desc: "Local com ótimas variedades de produtos, bons vendedores e bons preços", categoria: Categorias.tradicionais, latitude: "-3.1396735635644184", longitude: "-60.02374607791054", preco: Precos.barato, horarios: Horarios.manha, distancia: Distancias.tres, status: "dia", maps: "https://maps.app.goo.gl/cMkYfPmdrZ2Wxb496"),
    
    PontoTuristico(id: UUID(), name: "Museu da Cidade de Manaus (Paço da Liberdade)", desc: "Museu em um palácio neoclássico com exposições interativas sobre a cultura e a história de Manaus.", categoria: Categorias.tradicionais, latitude: "-3.134241572131786", longitude: "-60.02856451349074", preco: Precos.barato, horarios: Horarios.manha, distancia: Distancias.tres, status: "dia", maps: "https://maps.app.goo.gl/QSXo2Xy72ZiGsCqW9"),
    
    PontoTuristico(id: UUID(), name: "Centro Cultural Palácio da Justiça do Amazonas", desc: "Ministério da Justiça em um edifício histórico e elegante com tours guiados e vários eventos culturais.", categoria: Categorias.tradicionais, latitude: "-3.1299800741594854", longitude: "-60.02440987251497", preco: Precos.barato, horarios: Horarios.manha, distancia: Distancias.tres, status: "dia", maps: "https://maps.app.goo.gl/u4x54oPdLwv2M6oQA"),
    
    PontoTuristico(id: UUID(), name: "Encontro das águas", desc: "Encontro das águas de Manaus, acesso possivel a partir do porto da CEASA, a porta de saída de Manaus para Porto Velho.", categoria: Categorias.tradicionais, latitude: "-3.134245862866356", longitude: "-59.9023831136615", preco: Precos.caro, horarios: Horarios.manha, distancia: Distancias.tres, status: "dia", maps: "https://maps.app.goo.gl/EGd7DV25LKakUMEB6"),
    
    PontoTuristico(id: UUID(), name: "Kalena Café", desc: "Pequeno ponto gastronômico à italiana com sacada e boemia serve cafés de barista entre salgados e doces.", categoria: Categorias.culinaria, latitude: "-3.1103475089438444", longitude: "-60.01445205902422", preco: Precos.medio, horarios: Horarios.todos, distancia: Distancias.tres, status: "dia e noite", maps: "https://maps.app.goo.gl/h7MZQQYMMopHJ7LG8"),
    
    PontoTuristico(id: UUID(), name: "Café com Leite", desc: "Cardápio com cafés variados, sanduíches, doces e bolos, destaque às sobremesas no copo, clima tranquilo.", categoria: Categorias.culinaria, latitude: "-3.1080825954662674", longitude: "-60.01722850303556", preco: Precos.medio, horarios: Horarios.todos, distancia: Distancias.tres, status: "dia e noite", maps: "https://maps.app.goo.gl/6tKNCLWeJKSm2tzG6"),
    
    PontoTuristico(id: UUID(), name: "Manauara Shopping", desc: "O Manauara Shopping homenageia em sua arquitetura a fauna, flora e a cultura amazonense, e conta com um mix completo de lojas e grandes marcas, além de um teatro com quase 600 lugares.", categoria: Categorias.tradicionais, latitude: "-3.104163307782565", longitude: "-60.011986450927466", preco: Precos.barato, horarios: Horarios.manha, distancia: Distancias.tres, status: "dia", maps: "https://maps.app.goo.gl/6qHCQSiwzPVpngtR8"),
    
    PontoTuristico(id: UUID(), name: "Praia de Ponta Negra", desc: "Praia conhecida com duna famosa, cabanas, restaurantes e bares, além de hotéis e comodidades nas proximidades.", categoria: Categorias.tradicionais, latitude: "-5.880619557784327", longitude: "-35.16288395927036", preco: Precos.barato, horarios: Horarios.todos, distancia: Distancias.tres, status: "dia e noite", maps: "https://maps.app.goo.gl/Zo7m8BJPA5uQT6Eq7"),
    
    PontoTuristico(id: UUID(), name: "Dome's Burgers - Mundi", desc: "", categoria: Categorias.culinaria, latitude: "-3.0840632322220896", longitude: "-59.99683816583337", preco: Precos.medio, horarios: Horarios.noite, distancia: Distancias.tres, status: "noite", maps: "https://maps.app.goo.gl/ioHdAnxi8gvsJsqT6"),
    
    PontoTuristico(id: UUID(), name: "Restaurante Banzeiro Manaus", desc: "A cozinha informal à la carte de pratos da região amazônica e vinhos, com temas discretos da vida ribeirinha.", categoria: Categorias.culinaria, latitude: "-3.1101712809745763", longitude: "-60.016826599186885", preco: Precos.caro, horarios: Horarios.todos, distancia: Distancias.tres, status: "tarde e noite", maps: "https://maps.app.goo.gl/aVPZ5c1DZapg8g5f7"),
    
    PontoTuristico(id: UUID(), name: "Restaurante Choupana", desc: "Um restaurante de comida regional. Serve Filé de tucunaré, pato no tucupi e outras comidas regionais, em casa com tijolo aparente, arte e mezanino.", categoria: Categorias.culinaria, latitude: "-3.1085431097846232, ", longitude: "-60.01264641040796", preco: Precos.caro, horarios: Horarios.todos, distancia: Distancias.tres, status: "tarde e noite", maps: "https://maps.app.goo.gl/aVPZ5c1DZapg8g5f7"),
    
    PontoTuristico(id: UUID(), name: "Balneário José Ribeiro Soares SESC", desc: "Parques Aquáticos I e II; 9h às 16h30 (domingos e feriados)", categoria: Categorias.tradicionais, latitude: "-3.0679256505131125", longitude: "-60.044545826691326", preco: Precos.medio, horarios: Horarios.manha, distancia: Distancias.tres, status: "dia", maps: "https://maps.app.goo.gl/hQQ89Nd78Zz7NZy57"),
    
    PontoTuristico(id: UUID(), name: "Cantare Karaoke & Pub", desc: "Ponto de encontro aconchegante e descontraído para fãs de karaokê, com diversas opções de petiscos e drinques.", categoria: Categorias.festas, latitude: "-3.0985964278517333", longitude: "-60.02067005547076", preco: Precos.medio, horarios: Horarios.noite, distancia: Distancias.tres, status: "noite", maps: "https://maps.app.goo.gl/cwVRxbAo1XKTW9Zj6"),
    
    PontoTuristico(id: UUID(), name: "Coco Bambu Manaus", desc: "Restaurante de frutos do mar", categoria: Categorias.culinaria, latitude: "-3.0850076042000887", longitude: "-60.07218105716932", preco: Precos.caro, horarios: Horarios.todos, distancia: Distancias.tres, status: "tarde e noite", maps: "https://maps.app.goo.gl/Ewxxbb6nsMP8k5H98"),
    
    PontoTuristico(id: UUID(), name: "All Night Pub", desc: "Happy hours e comidinhas em casa de entretenimento noturno com apresentações ao vivo de pop, rock e sertanejo.", categoria: Categorias.festas, latitude: "-3.0848611174598015", longitude: "-59.99972264384931", preco: Precos.caro, horarios: Horarios.noite, distancia: Distancias.tres, status: "noite", maps: "https://maps.app.goo.gl/jmkjqn8ns34RJJGQ6"),
    
    PontoTuristico(id: UUID(), name: "Amazonas Shopping", desc: "Shopping de vários andares com lojas, praça de alimentação e entretenimento, incluindo um cinema.", categoria: Categorias.tradicionais, latitude: "-3.092207923083299", longitude: "-60.02273752499065", preco: Precos.medio, horarios: Horarios.todos, distancia: Distancias.tres, status: "dia e noite", maps: "https://maps.app.goo.gl/kRbx2eUnAGo2N7Cu8"),
    
    PontoTuristico(id: UUID(), name: "Café Da Manhã Tradicional", desc: "Bons produtos e preços bem abaixo dos demais.", categoria: Categorias.culinaria, latitude: "-3.1025467026171", longitude: "-60.00158713558179", preco: Precos.barato, horarios: Horarios.todos, distancia: Distancias.tres, status: "dia e noite", maps: "https://maps.app.goo.gl/xzBe7AYPM8u19WfX9"),
    
    PontoTuristico(id: UUID(), name: "Brunch Diner & Coffee", desc: "Restaurante tranquilo e animado que serve pratos de café da manhã em estilo americano, como bagels e waffles.", categoria: Categorias.culinaria, latitude: "-3.0892539917497306", longitude: "-59.99528967251497", preco: Precos.caro, horarios: Horarios.todos, distancia: Distancias.tres, status: "dia e noite", maps: "https://maps.app.goo.gl/9tDwoDpmU1AGB9yH9"),
    
    PontoTuristico(id: UUID(), name: "JSK Burgers - Praça Laranjeiras", desc: "Espaço informal com restaurantes para todos os gostos, incluindo opções italianas, japonesas e brasileiras.", categoria: Categorias.culinaria, latitude: "-3.064217688051578", longitude: "-60.011597763608016", preco: Precos.caro, horarios: Horarios.noite, distancia: Distancias.tres, status: "noite", maps: "https://maps.app.goo.gl/uZCftSsuHUVo2kLy6"),
    
    PontoTuristico(id: UUID(), name: "Porão do Alemão Rock bar", desc: "Local animado com rock ao vivo, comida simples, um bar e duas áreas externas.", categoria: Categorias.festas, latitude: "-3.09497997969293", longitude: "-60.05116591501288", preco: Precos.medio, horarios: Horarios.noite, distancia: Distancias.tres, status: "noite", maps: "https://maps.app.goo.gl/UD24xW4L4onNkLdR9"),
    
    PontoTuristico(id: UUID(), name: "K4 Lounge", desc: "Sexta-feira e Sábado. Somente maiores de idade. Avenida Visconde de Porto Seguro, 8, Flores.", categoria: Categorias.festas, latitude: "-3.062807768564073", longitude: "-60.005303496295994", preco: Precos.medio, horarios: Horarios.noite, distancia: Distancias.tres, status: "noite", maps: "https://maps.app.goo.gl/WpcZHh7TYqRqdQa98"),
    
    PontoTuristico(id: UUID(), name: "Fabrica & Sorveteria Glacial", desc: "Há mais de 45 anos refrescando o povo manauara com o autêntico sabor da Amazônia.", categoria: Categorias.culinaria, latitude: "-3.1156668489851396", longitude: "-60.01669911973841", preco: Precos.medio, horarios: Horarios.todos, distancia: Distancias.tres, status: "dia e noite", maps: "https://maps.app.goo.gl/YVrynhQBgyxeGR9L9"),
    
    PontoTuristico(id: UUID(), name: "Caritó Bar & Restaurante", desc: "Tira-gostos variados, além de chopes e caipirinhas, em boteco com transmissão dos jogos e música ao vivo.", categoria: Categorias.culinaria, latitude: "-3.0913426207249524", longitude: "-59.998011433058075", preco: Precos.medio, horarios: Horarios.noite, distancia: Distancias.tres, status: "noite", maps: "https://maps.app.goo.gl/uGEMvWJv7B72Zv7RA"),
    
    PontoTuristico(id: UUID(), name: "Cachaçaria do Dedé - Parque 10", desc: "Rótulos de cachaças feitas em diferentes regiões e pratos como joelho de porco ou picanha em clima intimista.", categoria: Categorias.culinaria, latitude: "-3.079874253230125", longitude: "-60.01019442885381", preco: Precos.caro, horarios: Horarios.todos, distancia: Distancias.tres, status: "tarde e noite", maps: "https://maps.app.goo.gl/UM915Q8sbvETd9L56"),
    
    PontoTuristico(id: UUID(), name: "RED DOG PUB", desc: "Bar com variedade de drinques, cervejas e aperitivos, atmosfera alternativa e noites com shows de rock.", categoria: Categorias.festas, latitude: "-3.1006533335674256", longitude: "-60.02195218904709", preco: Precos.medio, horarios: Horarios.noite, distancia: Distancias.tres, status: "noite", maps: "https://maps.app.goo.gl/M6nugQgFA4Eizgy37"),
    
    PontoTuristico(id: UUID(), name: "Flutuante Amazônia", desc: "Comida é muito boa, ambiente bem familiar.", categoria: Categorias.culinaria, latitude: "-3.0143763833065744", longitude: "-60.094720088222395", preco: Precos.caro, horarios: Horarios.manha, distancia: Distancias.tres, status: "dia", maps: "https://maps.app.goo.gl/EFpnz1Xz3gzPP9ybA"),
    
    PontoTuristico(id: UUID(), name: "Zoológico Do Cigs", desc: "O Zoológico do CIGS teve sua origem em 1967, a partir da necessidade de apresentar aos alunos do então Curso de Guerra na Selva (CGS) elementos da fauna e da flora amazônica, conhecimentos esses importantes na formação dos Guerreiros de Selva.", categoria: Categorias.tradicionais, latitude: "-3.0982717849028756", longitude: "-60.044888053326446", preco: Precos.barato, horarios: Horarios.manha, distancia: Distancias.tres, status: "dia", maps: "https://maps.app.goo.gl/ESSFsMpJgsnzb21Z6"),
    
    PontoTuristico(id: UUID(), name: "Bosque da Ciência - INPA - Instituto Nacional de Pesquisa da Amazônia", desc: "Você poderá permanecer no Bosque da Ciência somente em seu período de acesso. Faça seu agendamento! https://bosquedacienciaam.wixsite.com/agendamento", categoria: Categorias.tradicionais, latitude: "-3.097255580164747", longitude: "-59.98778515716932", preco: Precos.barato, horarios: Horarios.manha, distancia: Distancias.tres, status: "dia", maps: "https://maps.app.goo.gl/BzLjMSkdDJVKrYfy7"),
    
    PontoTuristico(id: UUID(), name: "Edifício The Office", desc: "Nascimento do aplicativo", categoria: Categorias.tradicionais, latitude: "-3.1129125802828614", longitude: "-60.01384493987119", preco: Precos.caro, horarios: Horarios.todos, distancia: Distancias.tres, status: "dia e tarde", maps: "https://maps.app.goo.gl/1eWTHph3NRNVwiH97"),
    ]
