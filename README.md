# 🎬 Movie Catalog App

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white) ![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white) ![GitHub last commit](https://img.shields.io/github/last-commit/Araayaaa/movie-catalog-flutter)

A simple movie catalog application built with Flutter. This project serves as a portfolio piece for learning Flutter fundamentals and applying for internship programs. It fetches live data from The Movie Database (TMDB) API.

---

## ✨ Features

-   **Discover Movies:** Displays a list of "Now Playing" movies on the initial screen.
-   **Movie Search:** Search for movies by title with a debouncing mechanism for a better user experience and API performance.
-   **Detailed View:** Get detailed information for each movie, including:
    -   High-quality poster image.
    -   Average rating score.
    -   Genre tags presented as clean-looking chips.
    -   Full synopsis or overview.
-   **Responsive Layout:** The movie gallery uses a `GridView` that adapts well to different screen sizes.
-   **State Handling:** Gracefully handles loading and error states with clear UI indicators.

---

## 🛠️ Tech Stack & Dependencies

-   **Framework:** Flutter
-   **Language:** Dart
-   **Architecture:** Basic Clean Folder Structure (models, services, screens, widgets)
-   **API:** [The Movie Database (TMDB) API](https://www.themoviedb.org/documentation/api)
-   **Key Packages:**
    -   `http`: For making HTTP requests to the TMDB API.
    -   `google_fonts`: For better and consistent typography.
    -   `transparent_image`: For a smooth fade-in effect on network images.

---

## 🚀 Getting Started

To get a local copy up and running, follow these simple steps.

1.  **Clone the Repository**
    ```bash
    git clone [https://github.com/Araayaaa/movie-catalog-flutter.git](https://github.com/Araayaaa/movie-catalog-flutter.git)
    cd movie-catalog-flutter
    ```

2.  **Set Up The API Key**
    -   Get your free API Key from [The Movie Database (TMDB)](https://www.themoviedb.org/signup).
    -   In the `lib/services/` directory, rename the file `api_constants.example.dart` to `api_constants.dart`.
    -   Open the `api_constants.dart` file and insert your API key:
        ```dart
        // lib/services/api_constants.dart
        const String apiKey = 'YOUR_TMDB_API_KEY_GOES_HERE';
        ```

3.  **Install Dependencies**
    ```bash
    flutter pub get
    ```

4.  **Run the App**
    ```bash
    flutter run
    ```

---

## 🎯 Future Improvements

Features and improvements that could be added to this project in the future:

-   [ ] Implement an advanced state management solution (e.g., Provider, Riverpod, BLoC).
-   [ ] Add a "Favorites" feature to save movies locally on the device (using `shared_preferences` or `hive`).
-   [ ] Implement infinite scrolling / pagination for movie lists and search results.
-   [ ] Add detail pages for cast and crew members.
-   [ ] Write unit and widget tests to ensure code quality.

---

## 📜 License

This project is licensed under the MIT License. See the `LICENSE` file for more details.