# Simbora Manaus

An iOS app that encourages **Manaus residents to explore their own city**. It suggests a tourist spot, restaurant or nightlife spot, and turns visiting it into a **weekly challenge** with Game Center achievements.

## Features

- **Random suggestion:** the app picks a place for you, and you can filter by **category** (traditional, food, parties), **time of day** (morning, afternoon, night), **price** (cheap, medium, expensive) and **distance** from you (3, 5 or 10 km).
- **Challenges:** accept a place as a challenge with a **7-day deadline**, then mark it as visited.
- **Visit history:** challenges and visited places are saved on the device with Core Data.
- **Game Center:** sign in with your Game Center profile and unlock **achievements** for the places you visit and for repeat visits.
- **Place details:** description, address, opening hours, link and a shortcut to Maps for each spot.
- **Carousel and onboarding:** a place carousel and a three-page onboarding flow.
- **Local data:** about 40 curated places in Manaus, bundled with the app.

## Architecture

| Folder | Contents |
| --- | --- |
| `Config` | App entry point |
| `Data` | The curated list of places |
| `Models` | `PontoTuristico`, Core Data model and persistence, Game Center auth, location |
| `Presentation/Enums` | Filter options: categories, distances, hours, prices |
| `Presentation/Views` | Home, challenge screens, onboarding, filter, tab bar and carousel components |

## Tech stack

![Swift](https://img.shields.io/badge/Swift-F05138?style=for-the-badge&logo=swift&logoColor=white) ![SwiftUI](https://img.shields.io/badge/SwiftUI-007AFF?style=for-the-badge&logo=swift&logoColor=white) ![CoreData](https://img.shields.io/badge/CoreData-2566E5?style=for-the-badge&logo=database&logoColor=white) ![GameKit](https://img.shields.io/badge/GameKit-FF9500?style=for-the-badge&logo=apple&logoColor=white) ![CoreLocation](https://img.shields.io/badge/CoreLocation-34C759?style=for-the-badge&logo=apple&logoColor=white) ![SceneKit](https://img.shields.io/badge/SceneKit-000000?style=for-the-badge&logo=apple&logoColor=white) ![Xcode](https://img.shields.io/badge/Xcode-147EFB?style=for-the-badge&logo=xcode&logoColor=white)

## Running the project

Requirements: Xcode and an iPhone or simulator running **iOS 17.2 or later**. Location and Game Center features work best on a real device signed in to Game Center.

1. Clone the repository:
   ```bash
   git clone https://github.com/Luan-Aiezza/Turismo_Manaus.git
   ```
2. Open `Simbora Manaus.xcodeproj` in Xcode.
3. Select an iPhone and press **Run** (⌘R).

## Team

Built by Ítalo Monte, Samuel Coelho, Luan Aiezza and Victor Vasconcelos.
