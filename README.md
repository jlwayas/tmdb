# tmdb
by Jesús López

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
    ├   ├   ├── Enums
    │   │   ├── Extensions
    │   │   ├── Movies
    │   │   ├── MovieSection
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

+ Utils.swift - Class that contains the methods to configure the jsonDecoder and the dateFormatter

### Models
**Enums**
+ DataFetchPhase.swift - Enum used to map the state (phase: .empty, success and .failure) of the viewModels objects

**Extensions**
+ Bundle.swift - Extension used to implement the loading and decoding of the test json to be able to run the canvas of the views in local mode
+ Movie.swift - Extension used to generate the different dummies of the movie models

**Movies**
* MovieResponse.swift - Base model for mapping the response of a movie
* Movie.swift - Main model that contains the entire body of a movie as well as autocomputed variables to generate all the necessary data to display on the screen
* MovieGenre.swift - Model that stores the genre(s) of a movie
* MovieCredit.swift -Model that stores the credit(s) of a movie
* MovieCast.swift - Model that stores the cast(s) of a movie
* MovieCrew.swift - Model that stores the crew(s) of a movie
* MovieVideoResponse.swift - Model that stores the video(s) of a movie
* MovieVideo.swift - Model that stores the video of a movie

**Movie Section**
+ MovieSection.swift - Model that stores the base information of the movie categories

**Resources**
+ movie_info.json - Stub that contains the sample information of a movie
+ movie_list.json - Stub that contains the sample information of a list movies
+ search_movie.json - Stub containing sample information for a list of movies to search for

### Services
**Class**
+ MovieStore.swift - Class that implements the protocols of the movies services

**Enums**
+ MovieListEndpoints.swift - Enum containing the 4 application endpoint categories
+ MovieError.swift - Enum that contains the different errors that can be displayed in the application

**Protocols**
+ MovieService.swift - Protocol that dictates the services that are implemented within the application

### ViewModels
+ ImageLoader.swift - ViewModel that has the responsibility to load the images through a URL and store them in cache
+ MovieHomeState.swift - ViewModel that is responsible for loading a group of movie requests asynchronously and the functions on its attributes
+ MovieListState.swift - ViewModel that is responsible for loading the movies by category and for carrying out the pagination of the same asynchronously, offline search of the movies and the functions on the attributes of the same
+ MovieSearchState.swift - ViewModel that is responsible for loading the movies so that they are written on the screen with a 1-second writing delay
+ MovieDetailState.swift - ViewModel that has the responsibility of loading the movies by id and its operations

### Views
**Overlays**

+ BlurredBackground.swift - Overlay intended for future implementation to have a gradient colored background
+ EmptyPlaceholderView.swift - Overlay implemented to show the user when there is an empty response, showing a custom text and image
+ RetryView.swift - Overlay implemented to show the user a retry action, it has a callback type attribute

**UikitViews**
+ SafariView.swift - Bridge view implemented to use Safari with Switui to show the videos with a sheet action

**Views**
+ MovieDetailImage.swift - Reusable view to display an image with aspect ratio 16/9
+ MovieDetailListView.swift - Reusable view to display all the necessary detail information of a movie
+ MovieDetailView.swift - Container view to show the detail of a movie (image, detail) and also show the youtube video
+ MovieHomeView.swift - Container view to show the home of the application
+ MovieRowView.swift - Row type view to show quick detail of movies being filtered from search view
+ MoviesByCategoryView.swift - Container view to display a grid of movies by category
+ +MovieSearchView.swift - Container view to show the rows of movies filtered by the text that the user is typing
+ MovieThumbnailCarouselView.swift - View to display the image of a movie with the three types of layouts (backdrop, grid, poster)
+ MovieThumbnailView.swift - Container view to display a carousel of images for the different categories

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
