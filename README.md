# Small_World_Task

## Quick summary

A simple app which hits the IMDB APIs and show a list of movies, also show details when items on the list are tapped.. We are using the IMDB below mentioned API:

- https://api.themoviedb.org/3/discover/movie?api_key={sample-key}
- https://api.themoviedb.org/3/movie/{movie_id}?api_key={sample-key}

## Which Architecture is used in the app?
The app is implemented on MVVM with Clean Architecture.

- MVVM -> For the Presentation.
- UseCase -> For the Domain Logic.
- Repository -> For the Data.


