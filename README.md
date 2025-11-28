# 🟢 Olive Stocks

**Real-time market data & AI-powered insights for smarter investing.**
A multi-platform stock tracking and investment insights app built with **Flutter (mobile)**, **Next.js (web)**, and **Node.js/Express + MongoDB (backend)**.

---

## 🚀 Live Demo

* **Mobile App (Flutter)** – Coming soon / Internal testing
* **Web App (Next.js)** – [https://www.olivestocks.com/]
* **API (Backend)**

---

## 📌 Key Features

* 📈 **Real-time & Historical Market Data** – Powered by Finnhub and other reliable providers.
* 🤖 **AI Insights & Analysis** – Provides actionable insights for smarter investing decisions.
* 📊 **Portfolios & Watchlists** – Track multiple portfolios and maintain custom watchlists.
* 🌟 **Curated Stock Suggestions** – Includes “Quality Stocks” and “Stock of the Month.”
* 📰 **Market News Feed** – Stay updated with the latest market trends and news.
* 💳 **Subscription Plans** – Free and premium tiers with account-based access.
* 🔒 **User Authentication & Data Protection** – Login/signup with secure JWT-based authentication; user data is never sold.
* ⚠️ **Standard Disclaimers** – For informational purposes only; not financial advice.
* 💬 **Real-time Notifications** – Using Socket.io for instant updates.
* 📂 **File Uploads** – Cloudinary integration for user uploads (avatars, documents).
* 💵 **Payment Integration** – Stripe & Braintree supported for subscription plans.

---

## 🛠️ Tech Stack

### Backend

* **Node.js** / **Express**
* **MongoDB** / **Mongoose**
* **Socket.io** (real-time)
* **Braintree** / **Stripe** (payments)
* **Cloudinary** (file storage)
* **Finnhub API** (market data)
* **Other Packages**: Axios, bcrypt, jsonwebtoken, cors, multer, nodemailer

### Mobile (Flutter)

* **Flutter SDK** + Dart
* **State Management**: GetX / Provider
* **HTTP Requests**: http package
* **UI Packages**: carousel_slider, flutter_svg, flutter_rating, smooth_page_indicator
* **Payment**: flutter_stripe
* **Storage**: shared_preferences
* **File Handling**: file_picker, image_picker
* **Charts**: syncfusion_flutter_charts, fl_chart, flutter_echarts
* **Real-time**: socket_io_client

### Web (Next.js)

* **React 18** + Next.js 14
* **UI**: TailwindCSS + Radix UI + Framer Motion
* **State & Data**: React Query, Zod validation, React Hook Form
* **Charts & Visualizations**: Recharts, Echarts, react-gauge-chart
* **Authentication**: next-auth + JWT
* **Payments**: Stripe
* **Socket.io Client** for real-time updates

---

## 📂 Project Structure

### Backend

```
/controllers
/models
/routes
/middlewares
/services
/utils
/config
server.js
```

### Flutter

```
/lib
  /models
  /screens
  /widgets
  /services
  /controllers
/assets
```

### Next.js

```
/app
/components
/hooks
/lib
/utils
/pages
```

---

## ⚙️ Installation & Setup

### Backend

```bash
git clone https://github.com/yourusername/backend_rafi.git
cd backend_rafi
npm install
cp .env.example .env
npm run dev
```

### Flutter Mobile

```bash
git clone https://github.com/yourusername/olive_stocks_flutter.git
cd olive_stocks_flutter
flutter pub get
flutter run
```

### Web Frontend

```bash
git clone https://github.com/yourusername/rafimassarwa.git
cd rafimassarwa
npm install
npm run dev
```

**Environment variables for backend** (`.env`):

```
MONGO_URI=
JWT_SECRET=
CLOUDINARY_CLOUD_NAME=
CLOUDINARY_API_KEY=
CLOUDINARY_API_SECRET=
STRIPE_SECRET=
FINNHUB_API_KEY=
```

---

## 🖼️ Screenshots

*(Add images of mobile app, web dashboard, and key features here)*

---

## 🧠 What I Learned

* Full-stack development with **Flutter + Next.js + Node.js/Express**.
* Secure authentication with JWT and third-party integrations (Google, Stripe, Braintree).
* Real-time features using **Socket.io**.
* Cloud-based file storage & optimized media handling with Cloudinary.
* API integration with **Finnhub** for stock data.
* Charting & data visualization using Flutter and React libraries.
* Clean, scalable folder structures for multi-platform apps.

---

## 📬 Contact

**Rafi Massarwa**
📧 [zihadul708@gmail.com](mailto:zihadul708@gmail.com)
🌐 Portfolio: [http://zihadulislam.me/](http://zihadulislam.me/)
🔗 LinkedIn: [https://www.linkedin.com/in/zihadulislam2](https://www.linkedin.com/in/zihadulislam2)

