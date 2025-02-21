# 🚀 CryptoTracker

## 📌 Overview

**CryptoTracker** is an iOS application that fetches cryptocurrency data from the [CoinRanking API](https://api.coinranking.com/v2) and displays a list of the **top 100 coins** with pagination, filtering, and favorite functionality. The app is built using a combination of **UIKit** and **SwiftUI**, showcasing my ability to work with both frameworks seamlessly.

This project demonstrates my ability to work with **RESTful APIs, MVVM architecture, Combine, and SwiftUI animations**, while also handling **image rendering (SVG format)** and **real-time charting** for coin performance.

---

## 🎯 Features

### 📌 1. Coin List (Dashboard)
✅ Displays a **paginated list** of the top 100 cryptocurrencies (**20 per page**).  
✅ Shows **icon, name, current price, and 24-hour performance** for each coin.  
✅ **Swipe left** to add/remove favorites quickly.  
✅ **Filter coins** by **highest price** and **best 24-hour performance**.  

### 📌 2. Coin Detail Page
✅ Displays **in-depth information** about a selected coin.  
✅ **Interactive performance chart** with filters to track progress over different time durations.  
✅ Shows additional **statistics** to help users analyze market trends.  

### 📌 3. Favorites Screen
✅ Displays all **favorited cryptocurrencies**.  
✅ Allows users to **remove favorites** by swiping left.  
✅ Access **detailed coin information** from this screen.  

---

## 🛠 Technical Highlights

🚀 **Mixed UIKit & SwiftUI** – UIKit for core navigation and table views, while SwiftUI enhances smaller, reusable views.  
🚀 **Combine & MVVM Architecture** – Ensures clean, reactive, and maintainable code.  
🚀 **SVG Image Handling** – Efficiently loads and displays cryptocurrency icons using an optimized SVG rendering solution.  
🚀 **Custom Chart Implementation** – Displays cryptocurrency performance using a **dynamic line graph**.  
🚀 **State Management** – Uses `@State` and `@Published` properties for real-time updates.  

---

## ⚡️ Challenges & Solutions

### 1️⃣ Understanding the API & Data Handling  
**Challenge:** The API structure required **parsing nested JSON data** and handling **pagination**.  
**Solution:** Used `Codable` to decode API responses and implemented **offset-based pagination** for seamless data loading.  

### 2️⃣ Graph Implementation  
**Challenge:** Creating a **smooth, interactive line graph** for the detail screen.  
**Solution:** Implemented a **SwiftUI Path-based chart** with animations to visualize coin performance dynamically.  

### 3️⃣ SVG Image Loading  
**Challenge:** Many coin icons were provided in **SVG format**, which `UIImageView` doesn’t natively support.  
**Solution:** Used an **SVG rendering library** to properly decode and display images.  

---

## 📦 Installation & Setup

### 🔹 **Clone the Repository**
```bash
git clone https://github.com/yourusername/CryptoTracker.git
cd CryptoTracker
```

## 🏗 Open the Project in Xcode

1. Ensure **Xcode (Version 16.0+)** is installed.  
2. Open `EquityCoinRanking.xcodeproj` in Xcode.  
3. Make sure you have an **active internet connection** to fetch dependencies.  

---

## 📦 Install Dependencies (if needed)

If dependencies fail to install automatically, run the following command:
```bash
swift package resolve
```

## 🚀 Run the App

Follow these steps to build and run the application successfully:

1️⃣ **Select a Device:**  
   - Open **Xcode** and choose a **simulator** or a **real device**.  

2️⃣ **Build & Run:**  
   - Press **Cmd + R** to compile and launch the app.  

3️⃣ **Launch Experience:**  
   - The app will open with the **Coin List (Dashboard) screen**.  

4️⃣ **Explore Features:**  
   - **Filter** coins by price or performance.  
   - **Swipe left** to favorite/unfavorite a coin.  
   - **View details** with an interactive chart and stats.  

🎉 **You're all set! Enjoy tracking cryptocurrency trends with CryptoTracker!** 🚀  
