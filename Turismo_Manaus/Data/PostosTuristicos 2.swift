import Foundation

//TODO: remove enum Distancia OK
//TODO: verificar coordenadas de instacias grandes

public var PontosTuristicos: [PontoTuristico] = [
    PontoTuristico(
        id: UUID(),
        name: "Amazonas Shopping",
        imageName: .amazonasshopping,
        desc: "Shopping de vários andares com lojas, praça de alimentação e entretenimento, incluindo um cinema.",
        categoria: Categorias.tradicionais,
        latitude: "-3.094200",
        longitude: "-60.023000",
        preco: Precos.medio,
        horarios: [Horarios.todos],
        status: "dia e noite",
        maps: "https://maps.app.goo.gl/kRbx2eUnAGo2N7Cu8",
        endereco: "Av. Djalma Batista, 482 - Parque 10 de Novembro, Manaus - AM, 69050-010",
        link: "https://amazonasshopping.com.br/"),
    
    PontoTuristico(
        id: UUID(),
        name: "Amazonico Peixaria Regional",
        imageName: .amazonicopeixariaregional,
        desc: "Cardápio variado com destaque para o tambaqui na brasa, cervejas, refrigerantes e sucos, ambiente tradicional.",
        categoria: Categorias.culinaria,
        latitude: "-3.091882",
        longitude: "-60.019834",
        preco: Precos.caro,
        horarios: [.tarde, .noite],
        status: "noite",
        maps: "https://maps.app.goo.gl/42Xs2sx8Qf6MEVgk8",
        endereco: "Av. Darcy Vargas, 226 - Parque Dez de Novembro, Manaus - AM, 69055-035",
        link: "https://www.instagram.com/amazonicopeixaria/"),
    
    PontoTuristico(
        id: UUID(),
        name: "Angatu Café Unidade Centro",
        imageName: .angatucafeunidadecentro,
        desc: "Delicioso para café da manhã, e com serviço também para lanche da tarde e jantar! Cozinha regional muito boa.",
        categoria: Categorias.culinaria,
        latitude: "-3.128881",
        longitude: "-60.025858",
        preco: Precos.medio,
        horarios: [Horarios.todos],
        status: "manhã, tarde e noite",
        maps: "https://maps.app.goo.gl/1SfV6ir3k7aXNisi8",
        endereco: "R. Monsenhor Coutinho, 402 - Centro, Manaus - AM, 69010-110",
        link: "https://www.instagram.com/angatucafe?igsh=MTEzYzY2bTB3N2I4ZA=="),
    
    PontoTuristico(
        id: UUID(),
        name: "Balneario Jose Ribeiro Soares Sesc",
        imageName: .balneariojoseribeirosoaressesc,
        desc: "Um espaço de lazer com piscina e áreas para descanso e recreação.",
        categoria: Categorias.tradicionais,
        latitude: "-3.068322,",
        longitude: "-60.044675",
        preco: Precos.medio,
        horarios: [Horarios.manha],
        status: "manhã",
        maps: "https://maps.app.goo.gl/hQQ89Nd78Zz7NZy57",
        endereco: "Av. Constantinopla, 288 - Alvorada, Manaus - AM, 69045-000",
        link: "https://www.sesc.com.br/unidade/sesc-balneario-2/"),
    
    PontoTuristico(
        id: UUID(),
        name: "Cantare Karaoke & Pub",
        imageName: .cantarekaraokePub,
        desc: "Ponto de encontro aconchegante e descontraído para fãs de karaokê, com diversas opções de petiscos e drinques.",
        categoria: Categorias.festas,
        latitude: "-3.098881",
        longitude: "-60.020685",
        preco: Precos.caro,
        horarios: [Horarios.noite],
        status: "noite",
        maps: "https://maps.app.goo.gl/FB5dUJFBsRiqMQCt6",
        endereco: "R. Rio Purús, 29 - Nossa Sra. das Gracas, Manaus - AM, 69053-050",
        link: "https://www.instagram.com/cantare_karaoke/"),
]

