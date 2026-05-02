# 🛒 Marketoo App with AI

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-blue?style=for-the-badge&logo=flutter" alt="Flutter Badge" />
  <img src="https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart" alt="Dart Badge" />
  <img src="https://img.shields.io/badge/Status-Active%20Development-success?style=for-the-badge" alt="Status Badge" />
  <img src="https://img.shields.io/badge/Platform-Cross%20Platform-purple?style=for-the-badge" alt="Platform Badge" />
</p>

<p align="center">
  A modern Flutter e-commerce application featuring local persistence, responsive UI, state management, and AI-ready architecture.
</p>

---

## 📌 Overview

**Marketoo_app_with_ai** is a cross-platform e-commerce app built with Flutter.  
The project is structured to support a polished shopping experience across **Android, iOS, Web, Windows, macOS, and Linux**, with a strong focus on:

- 🧩 Clean and maintainable code structure
- 💾 Local data persistence via SQLite helper utilities
- 🎛️ Provider-based state management
- 🌙 Light/Dark theme switching
- 🛍️ Cart and category management
- 🚀 Native splash and platform support
- 🤖 AI-ready expansion for future intelligent features

---

## ✨ Key Features

| Feature | Description |
|---|---|
| 🏠 Home Screen | Displays product/category-driven shopping entry point |
| 🔎 Category Browsing | Browse products by category with dedicated pages |
| 🛒 Shopping Cart | Add, update, and manage cart items with persistent state |
| 📦 Product Details | View product information before purchase |
| 🌗 Theme Switching | Light and dark mode support using provider state |
| 💽 Local Storage | DB helper for persistence and offline-friendly experience |
| 🧭 Splash Screen | Custom startup experience |
| 🖥️ Cross-Platform | Built to run on mobile, desktop, and web |

---

## 🧱 Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter |
| Language | Dart |
| State Management | Provider |
| Persistence | SQLite / Local DB helper (`db_helper.dart`) |
| UI/Theming | Custom colors, text styles, and theme configuration |
| Platforms | Android, iOS, Web, Linux, macOS, Windows |

---

## 📂 Project Structure

```bash
Marketoo_app_with_ai/
├── lib/
│   ├── core/
│   │   ├── app_colors.dart
│   │   ├── app_text_style.dart
│   │   ├── app_theme.dart
│   │   └── db_helper.dart
│   ├── models/
│   │   └── app_models.dart
│   ├── pages/
│   │   ├── splash_screen.dart
│   │   ├── home.dart
│   │   ├── cart_page.dart
│   │   ├── category_products_page.dart
│   │   └── product_details.dart
│   ├── providers/
│   │   ├── cart_provider.dart
│   │   ├── category_provider.dart
│   │   └── theme_provider.dart
│   └── main.dart
├── android/
├── ios/
├── web/
├── linux/
├── macos/
├── windows/
├── test/
└── pubspec.yaml
```

---

## 📱 App Gallery

<table>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/0d02e96f-f716-401d-9418-ae1e845509a7" width="220" />
      <br /><b>Splash Screen</b><br />Custom initialization screen
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/a6058abe-d635-48f3-a876-8fcfb6cd336d" width="220" />
      <br /><b>Home Page (Light)</b><br />Dynamic category fetching
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/c2435794-b080-4420-9420-111cf6f75237" width="220" />
      <br /><b>Home Page (Dark)</b><br />Real-time theme switching
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/7041fbd2-4d2a-4539-a1c4-3deb78cb4a03" width="220" />
      <br /><b>Product Details</b><br />Product info & cart integration
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/558da2f0-abf8-45e5-975c-5fda6b669da5" width="220" />
      <br /><b>Admin Controls</b><br />In-app CRUD operations (Add/Edit)
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/c8d87609-bf26-4796-b250-9dc301e95b8a" width="220" />
      <br /><b>Dynamic Product Listing</b><br />List view with dead-link protection
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/8bf906c4-3688-422f-969f-1073b6bf1e95" width="220" />
      <br /><b>Shopping Cart</b><br />Persistent storage & quantity controls
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/48ba1153-f164-4639-ad41-7fd517e29906" width="220" />
      <br /><b>Secure Checkout Flow</b><br />Receipt generation & safe clearing
    </td>
  </tr>
</table>

---

## 🚀 Getting Started

### 1) Prerequisites

Ensure the following are installed:

| Requirement | Recommended |
|---|---|
| Flutter SDK | Latest stable 3.x |
| Dart SDK | Bundled with Flutter |
| Android Studio / Xcode / VS Code | For development and debugging |
| Git | For repository management |
| Platform SDKs | Android SDK, iOS tooling, or desktop toolchains as needed |

### 2) Clone the Repository

```bash
git clone https://github.com/teto06920623/Marketoo_app_with_ai.git
cd Marketoo_app_with_ai
```

### 3) Install Dependencies

```bash
flutter pub get
```

### 4) Run the App

#### Android / iOS
```bash
flutter run
```

#### Web
```bash
flutter run -d chrome
```

#### Windows
```bash
flutter run -d windows
```

#### macOS
```bash
flutter run -d macos
```

#### Linux
```bash
flutter run -d linux
```

---

## 🧪 Testing

Run widget and unit tests with:

```bash
flutter test
```

---

## 🧰 Useful Flutter Commands

| Command | Purpose |
|---|---|
| `flutter clean` | Remove build artifacts |
| `flutter pub get` | Fetch dependencies |
| `flutter test` | Execute tests |
| `flutter run` | Launch the application |
| `flutter build apk` | Build Android APK |
| `flutter build web` | Build web release |
| `flutter build ios` | Build iOS release |
| `flutter build windows` | Build Windows release |
| `flutter build macos` | Build macOS release |
| `flutter build linux` | Build Linux release |

---

## 🎨 Architecture & State Management

The app is organized around a feature-friendly Flutter structure:

- **Core**: Shared colors, typography, theme, and DB utilities
- **Models**: Data representations used across the app
- **Pages**: UI screens for shopping, cart, details, and splash flow
- **Providers**: State management for cart, categories, and theme

### Provider Responsibilities

| Provider | Responsibility |
|---|---|
| `CartProvider` | Manages cart items, quantities, and persistence |
| `CategoryProvider` | Handles category/product data loading |
| `ThemeProvider` | Controls dark/light theme switching |

---

## 💾 Local Persistence

The project includes `db_helper.dart`, indicating a local database layer for storing app data such as:

- Cart contents
- User-related app state
- Cached data for improved user experience

This makes the app more resilient and helps preserve state across sessions.

---

## 🌍 Supported Platforms

✅ Android  
✅ iOS  
✅ Web  
✅ Windows  
✅ macOS  
✅ Linux  

---

## 🤖 AI-Ready Direction

Although the current codebase primarily focuses on e-commerce fundamentals, the repository name and architecture suggest an **AI-ready foundation** for future enhancements such as:

- Product recommendations
- Smart search
- Personalized shopping experiences
- Customer behavior insights
- AI-assisted cart suggestions

---

## 👤 Author

| Field | Details |
|---|---|
| Author Name | **Taha Mohamad** |
| GitHub | [teto06920623](https://github.com/teto06920623) |
| Email | [teto06920623@gmail.com](mailto:teto06920623@gmail.com) |
| Phone / WhatsApp | **+01037392403** |
| LinkedIn | [Taha Mohamad Alrefaey](https://www.linkedin.com/taha-mohamad-alrefaey-a32bb538b) |

---

## 📄 License

This project is provided as-is for educational and development purposes.  
If a license file is added later, it should be referenced here.

---

## 🙌 Acknowledgements

- Flutter team for the amazing framework
- Provider package ecosystem for scalable state management
- The open-source community for continuous inspiration

---

<p align="center">
  <b>Built with ❤️ by Taha Mohamad</b>
</p>