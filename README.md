# 🎬 movie_search_app

A Flutter-based **Movie Search application** that allows users to search and save movies locally.  
Built using **Flutter**, **BLoC**, **Dio**, and **Hive** for local storage.

---

## 🚀 Features

- 🔍 Search movies by title
- 💾 Save favorite movies locally using Hive
- 🔄 State management with **BLoC/Cubit**
- ⚡ Lightweight, fast, and offline-ready
- 📦 Modular and scalable architecture

---

## 📦 Dependencies

Key packages used in this project:

- [`bloc`](https://pub.dev/packages/bloc) → State management
- [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) → Flutter integration for BLoC
- [`dio`](https://pub.dev/packages/dio) → Networking for API requests
- [`flutter_pretty_dio_logger`](https://pub.dev/packages/flutter_pretty_dio_logger) → Dio request logging
- [`hive`](https://pub.dev/packages/hive) → Local database for storing favorite movies
- [`hive_flutter`](https://pub.dev/packages/hive_flutter) → Flutter integration for Hive
- [`equatable`](https://pub.dev/packages/equatable) → Simplifies value comparisons for state management
- [`cupertino_icons`](https://pub.dev/packages/cupertino_icons) → iOS-style icons

---

## 🏗️ Project Structure

- `core/` → Services, constants, and utilities
- `features/` → Movie search modules (API, models, UI, Hive adapters)
- `shared/` → Common widgets, themes, and helpers
- `main.dart` → Application entry point

---

## 📱 Download APK

👉 [Click here to download movie_search_app APK](https://github.com/Pugalesh-KM/movie_search_app/blob/main/assets/apk/movie_search_app.apk)


---

## ▶️ Getting Started

### 1. Clone the repo
```bash
git clone https://github.com/Pugalesh-KM/movie_search_app.git
cd movie_search_app
