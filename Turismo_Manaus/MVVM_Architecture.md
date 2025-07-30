# Arquitetura MVVM - Turismo Manaus

Este documento descreve a arquitetura MVVM implementada no projeto Turismo Manaus.

## 📐 Estrutura do Projeto

```
Turismo_Manaus/
├── Models/                  # Modelos de dados
│   ├── Enums/              # Enumerações organizadas
│   │   ├── Categories.swift
│   │   ├── Hours.swift
│   │   ├── Prices.swift
│   │   └── Distances.swift
│   ├── PontoTuristico.swift # Modelo principal
│   └── Core Data files
├── ViewModels/             # ViewModels especializados
│   ├── HomeViewModel.swift
│   ├── FilterViewModel.swift
│   ├── LoadingViewModel.swift
│   └── LocationViewModel.swift
├── Services/               # Services para lógica de negócio
│   ├── LocationService.swift
│   └── DataService.swift
├── Views/                  # Views organizadas
│   ├── Refactored/        # Views refatoradas para MVVM
│   └── Legacy/            # Views originais (para referência)
├── Components/             # Componentes reutilizáveis
├── Core/                   # Utilities e extensões
│   ├── Extensions/
│   └── Utilities/
└── Config/                 # Configurações da app
```

## 🔧 Componentes da Arquitetura

### Models

**Responsabilidade**: Representar dados e estruturas de informação.

- ✅ **Structs** ao invés de classes (melhor para SwiftUI)
- ✅ **Codable** para serialização
- ✅ **Identifiable** e **Hashable** para performance
- ✅ **Computed properties** para lógica de apresentação simples

**Exemplo**:

```swift
struct PontoTuristico: Identifiable, Hashable, Codable {
    let id: UUID
    let name: String
    let coordinate: CLLocationCoordinate2D
    // ...

    var formattedDistance: String {
        // lógica de formatação
    }
}
```

### ViewModels

**Responsabilidade**: Gerenciar estado da UI e lógica de apresentação.

- ✅ **@MainActor** para thread safety
- ✅ **ObservableObject** para reatividade
- ✅ **@Published** para propriedades que atualizam a UI
- ✅ **Specialized ViewModels** para cada tela/funcionalidade

**ViewModels Implementados**:

1. **HomeViewModel**: Gerencia tela principal, filtros e seleção aleatória
2. **FilterViewModel**: Lógica específica de filtros reutilizável
3. **LoadingViewModel**: Estados de carregamento com progresso
4. **LocationViewModel**: Interface para LocationService

### Services

**Responsabilidade**: Lógica de negócio, APIs e funcionalidades específicas.

- ✅ **Single responsibility** - cada service tem uma função específica
- ✅ **Dependency injection** quando necessário
- ✅ **Error handling** estruturado com enums personalizados
- ✅ **Async/await** para operações assíncronas

**Services Implementados**:

1. **LocationService**: Gerenciamento completo de localização
2. **DataService**: CRUD de dados e cache
3. **GameCenterService**: Integração com Game Center (dentro dos ViewModels)

### Views

**Responsabilidade**: Interface do usuário, apresentação visual.

- ✅ **Separation of concerns** - apenas UI, sem lógica de negócio
- ✅ **ViewModels injection** via @StateObject ou @ObservedObject
- ✅ **Reusable components** para elementos comuns
- ✅ **Declarative UI** com SwiftUI

## 🎯 Princípios Seguidos

### 1. Single Responsibility Principle (SRP)

Cada classe tem uma responsabilidade específica:

- Models: Dados
- ViewModels: Estado da UI
- Services: Lógica de negócio
- Views: Apresentação

### 2. Dependency Inversion

ViewModels dependem de abstrações (Services), não de implementações concretas.

### 3. Separation of Concerns

UI, lógica de negócio e dados são separados em camadas distintas.

### 4. Testability

Cada componente pode ser testado isoladamente.

## 📋 Fluxo de Dados

```
User Interaction → View → ViewModel → Service → Data
                                  ↓
                            @Published Properties
                                  ↓
                          View Updates (SwiftUI)
```

### Exemplo de Fluxo:

1. **User taps filter button**
2. **View** chama método no ViewModel
3. **ViewModel** atualiza filtros e chama Service
4. **Service** filtra dados
5. **ViewModel** expõe dados filtrados via @Published
6. **View** atualiza automaticamente (SwiftUI reactivity)

## 🔄 Gerenciamento de Estado

### ViewModel State Management

```swift
@MainActor
class HomeViewModel: ObservableObject {
    // UI State
    @Published var isLoading = false
    @Published var errorMessage: String?

    // Data State
    @Published var pontosFiltrados: [PontoTuristico] = []

    // User Input State
    @Published var selectedCategoria = Categories.todos
}
```

### Service State Management

```swift
@MainActor
class LocationService: ObservableObject {
    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var locationError: LocationError?
}
```

## 🚀 Vantagens da Implementação

1. **Maintainability**: Código organizado e fácil de manter
2. **Testability**: Cada componente pode ser testado isoladamente
3. **Reusability**: ViewModels e Services podem ser reutilizados
4. **Scalability**: Fácil adicionar novas funcionalidades
5. **Performance**: @Published otimizado para SwiftUI
6. **Thread Safety**: @MainActor garante execução na main thread

## 📝 Padrões Utilizados

### 1. Repository Pattern (implícito no DataService)

```swift
class DataService {
    func pontos(por categoria: Categories) -> [PontoTuristico]
    func pesquisar(termo: String) -> [PontoTuristico]
}
```

### 2. Observer Pattern (SwiftUI + Combine)

```swift
@Published var filtros // Automaticamente notifica Views
```

### 3. Factory Pattern (para ViewModels)

```swift
@StateObject private var viewModel = HomeViewModel(locationService: locationService)
```

### 4. Strategy Pattern (para diferentes tipos de filtro)

```swift
enum FiltroRapido {
    case pertoDeMim, gratuito, culinaria
    // Cada caso tem sua estratégia de aplicação
}
```

## 🧪 Testabilidade

### Testes de ViewModel

```swift
func testFilterApplication() {
    let viewModel = FilterViewModel()
    viewModel.selectedCategoria = .culinaria

    let filtered = viewModel.aplicarFiltros(a: mockPontos)
    XCTAssertTrue(filtered.allSatisfy { $0.categoria == .culinaria })
}
```

### Testes de Service

```swift
func testLocationService() async {
    let service = LocationService()
    await service.requestSingleLocation()
    XCTAssertNotNil(service.currentLocation)
}
```

## 🔧 Melhorias Futuras

1. **Dependency Injection Container**
2. **Navigation Coordinator**
3. **Network Layer** para APIs
4. **Local Database** integration
5. **Unit Tests** implementation
6. **Integration Tests**
7. **UI Tests** automation

## 📖 Referências

- [MVVM Pattern](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel)
- [SwiftUI Data Flow](https://developer.apple.com/documentation/swiftui/managing-model-data-in-your-app)
- [Combine Framework](https://developer.apple.com/documentation/combine)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

---

_Documentação criada durante refatoração para MVVM - Janeiro 2025_
