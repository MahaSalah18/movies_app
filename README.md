#  Movies App

A simple Flutter Movies App built as my first solo project.  
The app displays popular and now-playing movies using The Movie Database (TMDB) API.

---

##  Features

- Display popular movies                        
- Show now playing movies
- Movie details screen
- Clean and responsive UI
- Dark / Light mode support
- Favorites feature (if applicable)
- Error handling for API requests

---

##  Tech Stack

- Flutter
- Dart
- Provider (State Management)
- MVVM Architecture
- TMDB API (https://www.themoviedb.org/)

---

##  Architecture

This project follows **MVVM (Model-View-ViewModel)** pattern:

- **Model** → Handles data structure and API response
- **View** → UI screens built with Flutter widgets
- **ViewModel** → Manages app state and business logic using Provider

---

##  API

This app uses **TMDB API** to fetch movies data such as:
- Popular movies
- Now playing movies
- Movie details

---

##  Screenshots

<img width="484" height="898" alt="Screenshot (730)" src="https://github.com/user-attachments/assets/4ec5986d-c968-426e-ab20-50345128f1a1" />
<img width="504" height="893" alt="Screenshot (731)" src="https://github.com/user-attachments/assets/49cfb7cf-fb75-4c1e-ab96-6429eb0ca08f" />
<img width="500" height="933" alt="Screenshot (732)" src="https://github.com/user-attachments/assets/0543699a-118e-4cf2-97ac-33746004401f" />
<img width="500" height="936" alt="Screenshot (733)" src="https://github.com/user-attachments/assets/c904a52f-822e-4587-98e6-d825c645f863" />
<img width="498" height="935" alt="Screenshot (735)" src="https://github.com/user-attachments/assets/81093a21-67c9-4060-a016-0b42a47d0a35" />
<img width="499" height="929" alt="Screenshot (736)" src="https://github.com/user-attachments/assets/7ac4ef06-7edf-47b8-bbb3-4d8248f07a2d" />
<img width="465" height="869" alt="Screenshot (737)" src="https://github.com/user-attachments/assets/b60f8755-71d4-4ae9-8de2-3e1116208409" />
<img width="470" height="862" alt="Screenshot (738)" src="https://github.com/user-attachments/assets/27c54d13-65b8-4ee7-96df-3bf2ddc2409e" />



## 📦 Getting Started

```bash
git clone https://github.com/MahaSalah18/movies_app
cd movies_app
flutter pub get
flutter run
