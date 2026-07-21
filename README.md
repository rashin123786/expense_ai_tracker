# 💰 Expense Tracker AI

A modern Flutter application that helps users manage daily expenses with **AI-powered receipt scanning** and **AI-generated spending insights**.

---

## ✨ Features

### 📊 Dashboard
- View total expenses
- Category-wise spending breakdown (Pie Chart)
- Quick analytics
  - Average expense
  - Total transactions
  - Highest expense
  - Current month spending

### 💵 Expense Management
- Add expense manually
- AI-powered receipt scanning
- Edit extracted values before saving
- Delete expenses
- View expense history
- Filter expenses by category

### 🤖 AI Receipt Scanner
- Capture or select receipt image
- Extract:
  - Merchant Name
  - Amount
  - Date
  - Category
  - Notes
- Auto-fill expense form
- User can edit extracted data before saving
- Handles AI extraction failures gracefully

### 🧠 AI Spending Insights
Generate an AI-powered spending report including:
- Total spending
- Category-wise breakdown
- Largest expenses
- Spending trends
- Personalized saving recommendations

### 💾 Local Storage
- Hive Database

---

# 🏗️ Architecture

This project follows **Clean Architecture**.

```
lib/
│
├── core/
│
├── features/
│   ├── expense/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── receipt/
│   ├── dashboard/
│   ├── ai/
│   └── splash/
│
├── injection/
├── router/
└── main.dart
```

Architecture Layers

- Presentation
  - Bloc
  - UI
- Domain
  - Entities
  - UseCases
  - Repository Contracts
- Data
  - Local Data Source
  - Remote Data Source
  - Repository Implementation

---

# 🛠️ Tech Stack

- Flutter
- Dart
- flutter_bloc
- GoRouter
- GetIt
- Hive
- Dio
- Gemini AI API
- Image Picker
- fl_chart
- Google Fonts

---

# 📱 Screens

- Splash Screen
- Dashboard
- Expense History
- Add Expense
- AI Spending Insights

---


# 📦 Dependencies

- flutter_bloc
- get_it
- hive
- hive_flutter
- dio
- flutter_dotenv
- image_picker
- fl_chart
- go_router
- google_fonts

---

# 🤖 AI Integration

The application uses **Google Gemini API** for:

### Receipt Scanner
- OCR-like receipt understanding
- Structured JSON extraction

### Spending Insights
- Natural language analysis
- Personalized recommendations

---

# 📸 Receipt Scanner Flow

1. Select image from Camera/Gallery
2. Image sent to Gemini API
3. AI extracts receipt information
4. Expense form is auto-filled
5. User reviews data
6. Save expense locally

---

# 📈 Spending Insights Flow

1. Read all expenses from Hive
2. Generate transaction summary
3. Send summary to Gemini
4. Display AI-generated financial insights

---

# 🧹 State Management

Implemented using **flutter_bloc**.

Separate blocs:

- ExpenseBloc
- DashboardBloc
- ReceiptBloc
- AiBloc
- SplashBloc
- NavigationBloc

---

# 📌 Notes

- Built using Clean Architecture principles.
- Repository Pattern with dependency injection.
- Local-first approach using Hive.
- Responsive UI.
- AI features powered by Gemini API.

---

# 👨‍💻 Developed By

**Rashin K**

Flutter Developer
