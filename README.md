# tmdb

## Version
1.0

## Build and Runtime Requirements
+ macOs Monterey 12.2.1
+ Xcode 13.3 or later
+ iOS 15.4 or later
+ SwiftUI 3

## Features
+ Consume the tmdb movies and series API
+ Categories: Now Playing, Popular, Top Rated, Upcoming
+ Detail view of each movie
+ Use of cache memory to store the images of the films
+ Offline search by categories
+ Visualization of the videos in the detail of each item through a sheet of the Youtube page
+ Animations when loading movie posters
+ Online search engine.
+ Design pattern implemented: **MVVM**
+ Programmatic UI
+ Pagination and infinite scroll by category

## Next Steps
+ Implement save data in CoreData
+ SignIn, signUp and Logout
+ Implement logic to show Tv's

## Project Structure
    
    ├── tmdb                    # Source files
    │   ├── Assets.xcassets
    │   ├── Helpers
    │   ├── Models
    │   ├── Resources
    │   ├── Services
    │   ├── ViewModels
    │   ├── Views
    │   │   ├── Overlays
    │   │   ├── UikitViews
    ├── tmdbTests               # Automated Unit tests
    ├── tmdbUITests             # Automated User Interfaces tests
    ├── tmdb.xcodeproj
    └── README.md

## Layers

### Helpers

+ Utils.swift

### Models
**Enums**
+ DataFetchPhase.swift

**Extensions**
+ Bundle.swift
+ Movie.swift
+ MovieSection.swift

**Movies**
* MovieResponse.swift
* Movie.swift
* MovieGenre.swift
* MovieCredit.swift
* MovieCast.swift
* MovieCrew.swift
* MovieVideoResponse.swift
* MovieVideo.swift

**Movie Section**
+ MovieSection.swift

**Resources**
+ movie_info.json
+ movie_list.json
+ search_movie.json

### Services
**Class**
+ MovieStore.swift

**Enums**
+ MovieListEndpoints.swift
+ MovieError.swift

**Protocols**
+ MovieService.swift

### ViewModels
+ ImageLoader.swift
+ MovieHomeState.swift
+ MovieListState.swift
+ MovieSearchState.swift
+ MovieDetailState.swift

### Views
**Overlays**

+ BlurredBackground.swift
+ EmptyPlaceholderView.swift
+ RetryView.swift

**UikitViews**
+ SafariView.swift

## Questions

### Single Responsability
Es el primer principio y buenas prácticas de SOLID, el cuál nos dicta que un módulo, clase o vista cumpla con una única función, por lo que da como resultado que sea fácil de entender, mantener, reemplazar y testear.

### Clean Code
+ Fácil de entender
+ Fácil de acoplar nuevos requerimientos
+ Fácil de desacoplar requerimientos
+ Fácil de mantener
+ Aplicar los principios SOLID y DRY
+ Uso de buenas prácticas
