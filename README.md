# 🟩 **Olive Stocks — Full Stack Project (Backend + Web Frontend + Mobile App)**

A real-time market intelligence platform providing stock data, AI-powered insights, curated recommendations, watchlists, portfolio tracking, and premium subscription features — built with **Node.js**, **Next.js**, and **Flutter**.

---

## 📌 **Overview**

Olive Stocks is a multi-platform financial analytics system providing:

* **Real-time stock market data**
* **Historical price charts & analysis**
* **AI-powered investment insights**
* **Watchlists & portfolio tracking**
* **Curated stock suggestions** (Stock of the Month, Quality Picks)
* **Market news feed**
* **User accounts & authentication**
* **Subscription plans** (Free + Paid tiers)
* **Secure payment processing** (Stripe, Braintree)
* **Flutter mobile app + Next.js website + Node backend**

---

# 📁 **Project Structure**

```
/olivestocks-backend       → Node.js + Express + MongoDB API
/olivestocks-flutter → Flutter mobile app (Android/iOS)
/olivestocks-frontend → Next.js 14 web application
```

---

# 🚀 **Features**

### 📈 **Market Data**

* Real-time stock prices (via Finnhub API)
* Historical OHLC data
* Technical indicators
* Charts on Web + Mobile

### 🤖 **AI-Powered Insights**

* Automated stock summaries
* Market trend detection
* Smart suggestions for investors

### 🧺 **Portfolios & Watchlists**

* Manage multiple portfolios
* Add/remove stocks
* Gain/loss calculations

### ⭐ **Curated Stock Lists**

* *Quality Stocks*
* *Stock of the Month*
* *Top Gainers / Losers*

### 📰 **Market News**

* News feed integrated from external APIs
* Categorized finance updates

### 👤 **User Accounts**

* JWT authentication
* Google login (Flutter + Web)
* Secure password management
* Cloudinary for image uploads

### 💳 **Subscriptions**

* Free & paid tiers
* Stripe + Braintree payment integration
* Subscription validation middleware

### 🔄 **Real-Time Functionality**

* Socket.io for notifications
* Live stock updates
* Real-time chat/events where needed

---

# 🛠️ **Tech Stack**

## **Backend — Node.js / Express / MongoDB**

* Express 5
* Mongoose 8
* JWT Auth
* bcrypt password hashing
* Multer file uploads
* Cloudinary media storage
* Stripe + Braintree payments
* Socket.io real-time events
* Finnhub API for market data

### **Backend Package.json**

Contains:

```
start: node server.js
dev: nodemon server.js
```

---

## **Web Frontend — Next.js 14 (App Router)**

Features:

* Authentication (NextAuth)
* Dashboard + charts
* Stock pages & news
* Stripe integration
* Analytics & real-time UI
* Modern UI using Tailwind + Radix UI + Shadcn components

Dependencies include:

* React 18
* Next 14
* TanStack Query
* Radix UI
* Stripe
* ECharts & Recharts
* Framer Motion
* Zod validation

---

## 📱 **Mobile App — Flutter**

Built with:

* Dart SDK ^3.7
* HTTP requests
* Shared Preferences (local storage)
* File & image picker
* Charts (fl_chart, Syncfusion)
* Carousel slider
* Flutter Stripe
* Google Sign-In
* Socket.io client
* XML parser
* Flutter SVG + Cached Images

Supports:

* Login & Registration
* Browse stocks
* Charts + analysis
* Manage watchlists
* Market news
* Payments
* Notifications UI

---

# ⚙️ **Backend Setup**

### 1. Install dependencies

```
cd backend_rafi
npm install
```

### 2. Create `.env`

```
PORT=4000
MONGO_URI=your_mongo_connection
JWT_SECRET=your_secret_key
FINNHUB_API_KEY=your_key
CLOUDINARY_CLOUD_NAME=...
CLOUDINARY_API_KEY=...
CLOUDINARY_API_SECRET=...
STRIPE_SECRET_KEY=...
BRAINTREE_MERCHANT_ID=...
BROKER_ENV=production
```

### 3. Start server

```
npm run dev
```

---

# 🌐 **Web Frontend Setup (Next.js)**

```
cd rafimassarwa
npm install
npm run dev
```

Env variables may include:

```
NEXT_PUBLIC_API_URL=
GOOGLE_CLIENT_ID=
STRIPE_PUBLIC_KEY=
NEXTAUTH_SECRET=
```

---

# 📱 **Flutter App Setup**

```
cd olive_stocks_flutter
flutter pub get
flutter run
```

Update API base URL in:

```
lib/constants/api.dart
```

---

# 🛡️ **Security & Disclaimers**

The platform provides **informational stock analysis only**.
It does **not** provide investment advice.
User data is protected and **never sold or rented**.

---

# 📦 **Deployment Notes**

### Backend (Node)

Render or Vercel — requires:

```
npm run build
npm start
```

### Next.js Web

Deployed via Vercel or Render.

### Flutter App

Deploy to Play Store + App Store (manual CI/CD optional).

---

# 📝 **License**

This project is protected; redistribution requires permission.

---

# 👨‍💻 **Contributors**

* Backend Developer
* Frontend Developer
* Mobile App Developer
* AI/Market Data Integrations

---
