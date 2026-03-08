# Marketoo App 🛒

A robust E-commerce Flutter application built with a focus on clean architecture, persistent local storage, and real-time state management.

## 📱 App Gallery

<table>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/0d02e96f-f716-401d-9418-ae1e845509a7" width="220" />
      <br/><b>Splash Screen</b><br/>Custom initialization screen
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/c8d87609-bf26-4796-b250-9dc301e95b8a" width="220" />
      <br/><b>Home Page (Light)</b><br/>Dynamic category fetching
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/c2435794-b080-4420-9420-111cf6f75237" width="220" />
      <br/><b>Home Page (Dark)</b><br/>Real-time theme switching
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/7041fbd2-4d2a-4539-a1c4-3deb78cb4a03" width="220" />
      <br/><b>Product Details</b><br/>Product info & cart integration
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/558da2f0-abf8-45e5-975c-5fda6b669da5" width="220" />
      <br/><b>Admin Controls</b><br/>In-app CRUD operations (Add/Edit)
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/a6058abe-d635-48f3-a876-8fcfb6cd336d" width="220" />
      <br/><b>Dynamic Product Listing</b><br/>List view with dead-link protection
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/8bf906c4-3688-422f-969f-1073b6bf1e95" width="220" />
      <br/><b>Shopping Cart</b><br/>Persistent storage & quantity controls
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/48ba1153-f164-4639-ad41-7fd517e29906" width="220"/>
      <br/><b>Secure Checkout Flow</b><br/>Receipt generation & safe clearing
    </td>
  </tr>
</table>

---

## 🛠 Architecture & Technologies

- **Framework:** Flutter (Dart)
- **State Management:** Provider (Layered Architecture)
- **Local Database:** SQLite (Persistent Shopping Cart & Products)
- **Design Pattern:** Separation of Concerns (Models, Providers, Core/DB, Views)

---

## 🛡️ Security & Technical Enrichment Context

- **Data Persistence & Normalization:** The cart system strictly stores `productId` and `quantity`. Data is dynamically aggregated using SQL `JOIN` operations to maintain the **Single Source of Truth** principle and prevent data redundancy.
- **Referential Integrity:** Enforced `ON DELETE CASCADE` ensures that deleting a product from the database automatically removes it from all associated user carts. This mitigates **Broken Object Level Authorization (BOLA)** vulnerabilities and prevents UI Null Pointer Exceptions.
- **Input Sanitization (Zero Trust):** The UI implementation does not blindly trust database payloads. Image rendering is protected by sanitization barriers (e.g., `image.startsWith('http')`) to prevent **Malicious URI Injection** that could lead to application crashes.
- **State Lifecycle & Atomic Operations:** The `CartProvider` orchestrates synchronization between RAM and SQLite using atomic transactions. Calling `notifyListeners()` broadcasts state changes to `Consumer` widgets, ensuring highly efficient, targeted UI rebuilds.

---

## 🐛 Troubleshooting & Solutions

- **Issue:** Red screen crash with `Invalid argument: No host specified in URI` when rendering cart images.
  - **Solution:** Implemented a sanitization guard before rendering the widget: `image.startsWith('http') ? Image.network(...) : Placeholder()`.

- **Issue:** Cascade Failure resulting in `CategoryProvider isn't a type` errors across UI files, despite correct import statements.
  - **Solution:** Investigated the internal structure of `category_provider.dart`. The Dart Analyzer entirely ignores and invalidates a file if it contains ghost imports (references to deleted files). Correcting internal paths resolved the global scope issue.

- **Issue:** Compilation error stating `The named parameter 'defaultValue' isn't defined` during the implementation of the product editing feature.
  - **Solution:** Refactored the UI to use `TextFormField` instead of `TextField`. This natively supports the `initialValue` property, reducing memory overhead by eliminating the need for boilerplate `TextEditingController` instances.

---

## 💻 Developer Cheat Sheet

### 1. Setup & Initialization

- `flutter pub get`
  - _Function:_ Fetches and downloads all dependencies listed in `pubspec.yaml` (e.g., provider, sqflite).
- `flutter clean`
  - _Function:_ Clears the build cache. Essential to run after major refactoring to prevent build conflicts.

### 2. Execution

- `flutter run`
  - _Function:_ Compiles and runs the application on the connected emulator or physical device.

### 🌟 Technical Maintenance

- `flutter pub outdated`
  - _Function:_ Scans the project for outdated packages, providing a report to help patch security vulnerabilities and improve performance.
- `flutter analyze`
  - _Function:_ Runs the static analyzer engine to detect logic bugs, syntax errors, and unused variables prior to runtime.
- `flutter build apk --split-per-abi`
  - _Function:_ Generates a highly optimized release APK, split by target processor architecture to significantly reduce the final app size.
