# ⚽ Football Matches App - Real-Time Sports Trackers

A professional Flutter application showcasing **Clean Architecture**, **Real-time WebSocket Integration**, and **Enterprise-level Development Practices**.

## 🏆 Project Overview

This Flutter application demonstrates advanced mobile development skills through a comprehensive football matches tracking system with real-time score updates.

### 🎯 Key Features

- **📱 Cross-Platform Support**: iOS, Android, Web, macOS, Linux, Windows
- **🔄 Real-Time Updates**: Live match scores via WebSocket (Pusher protocol)
- **🌍 Multi-Language Support**: English & Arabic with RTL support
- **🎨 Modern UI/UX**: Beautiful animations with flutter_animate
- **📊 Professional Data Management**: RESTful API integration with Dio
- **🏗️ Clean Architecture**: Domain-driven design with separation of concerns
- **⚡ State Management**: BLoC pattern with real-time data flow
- **🛡️ Enterprise Security**: Bearer token authentication
- **📱 Responsive Design**: Adaptive layouts for all screen sizes

### 🚀 Technical Highlights

#### **Architecture & Design Patterns**
- ✅ **Clean Architecture** (Domain/Data/Presentation layers)
- ✅ **BLoC State Management** with reactive programming
- ✅ **Dependency Injection** with GetIt service locator
- ✅ **Repository Pattern** for data abstraction
- ✅ **Use Cases** for business logic encapsulation

#### **Real-Time Features**
- ✅ **WebSocket Integration** with Pusher protocol support
- ✅ **Smart Fallback System** with mock data for demo purposes
- ✅ **Connection Status Monitoring** with visual indicators
- ✅ **Automatic Reconnection** with exponential backoff
- ✅ **Error Recovery** with graceful degradation

#### **API Integration**
- ✅ **Professional API Service** with Dio HTTP client
- ✅ **Comprehensive Error Handling** (Network/Auth/Server errors)
- ✅ **Retry Logic** for failed requests
- ✅ **Request/Response Logging** for debugging
- ✅ **Type-Safe Data Models** with JSON serialization

#### **UI/UX Excellence**
- ✅ **Custom Theme System** with dark/light mode support
- ✅ **Smooth Animations** using flutter_animate
- ✅ **Responsive Design** with ScreenUtil
- ✅ **Professional Typography** with Chakra Petch font
- ✅ **Accessibility Support** with proper semantics

## 🛠️ Technology Stack

### **Frontend**
- **Flutter 3.x** - Cross-platform framework
- **Dart 3.x** - Programming language
- **flutter_bloc** - State management
- **flutter_animate** - Animation library
- **flutter_screenutil** - Responsive design

### **Networking & Data**
- **Dio** - HTTP client with interceptors
- **web_socket_channel** - WebSocket communication
- **dartz** - Functional programming (Either types)
- **get_it** - Dependency injection
- **shared_preferences** - Local storage

### **Development Tools**
- **flutter_gen** - Code generation
- **flutter_localizations** - Internationalization
- **connectivity_plus** - Network monitoring

## 📋 API Integration

### **REST Endpoints**
```
GET /api/v1/home/todayMatches     - Today's matches
GET /api/v1/home/yesterdayMatches - Yesterday's matches  
GET /api/v1/home/tomorrowMatches  - Tomorrow's matches
```

### **WebSocket Integration**
```
URL: wss://mqtt.staging.torliga.com/app/4bae652d93c285868d11
Channel: "thesports-football.matchs"
Event: "score-event"
```

### **Authentication**
- Bearer Token authentication
- Automatic token inclusion in headers
- Comprehensive auth error handling

## 🏗️ Project Structure

```
lib/
├── core/                          # Core functionality
│   ├── constants/                 # App constants & API config
│   ├── di/                        # Dependency injection
│   ├── errors/                    # Error handling & failures
│   ├── network/                   # Network utilities
│   ├── routing/                   # App navigation & routing
│   ├── services/                  # Core services (API, WebSocket)
│   ├── storage/                   # Local storage abstraction
│   ├── theme/                     # App theming system
│   ├── usecases/                  # Base use case classes
│   ├── utils/                     # Utility functions
│   └── widgets/                   # Reusable widgets
├── features/                      # Feature modules
│   └── matches/                   # Matches feature
│       ├── data/                  # Data layer
│       │   ├── datasources/       # Remote & WebSocket data sources
│       │   ├── models/            # Data models & DTOs
│       │   └── repositories/      # Repository implementations
│       ├── domain/                # Domain layer
│       │   ├── entities/          # Business entities
│       │   ├── repositories/      # Repository abstractions
│       │   └── usecases/          # Business use cases
│       └── presentation/          # Presentation layer
│           ├── bloc/              # BLoC state management
│           ├── pages/             # UI pages
│           └── widgets/           # Feature-specific widgets
├── generated/                     # Generated code
└── l10n/                         # Localization files
```

## 🚀 Getting Started

### **Prerequisites**
- Flutter 3.0+ 
- Dart 3.0+
- iOS Simulator / Android Emulator / Physical Device

### **Installation**

1. **Clone the repository**
```bash
git clone https://github.com/YOUR_USERNAME/tornet_task.git
cd tornet_task
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Generate code**
```bash
flutter packages pub run build_runner build
```

4. **Run the application**
```bash
# Development mode
flutter run

# Web
flutter run -d chrome

# iOS
flutter run -d ios

# Android
flutter run -d android
```

### **Configuration**

The app supports multiple environments:

- **Demo Mode**: Mock data with simulated real-time updates
- **Staging**: Real API with staging endpoints
- **Production**: Production endpoints (when available)

Environment can be configured in `lib/core/constants/api_constants.dart`

## 📱 Features Demonstration

### **Real-Time Match Updates**
- Live score updates via WebSocket
- Status indicators (Live/Demo)
- Automatic reconnection handling
- Graceful fallback to mock data

### **Multi-Tab Interface**
- Yesterday's matches
- Today's matches (with live updates)
- Tomorrow's matches
- Smooth tab transitions with animations

### **Professional UI Components**
- Collapsible competition cards
- Animated match cards with score updates
- Status indicators with pulsing animations
- Responsive design for all screen sizes

### **Internationalization**
- English and Arabic language support
- RTL (Right-to-Left) text support
- Localized date and time formatting
- Cultural-appropriate number formatting

## 🧪 Testing & Quality

### **Code Quality**
- Static analysis with strict linting rules
- Clean code principles
- SOLID design patterns
- Comprehensive error handling

### **Performance**
- Optimized animations with 60fps
- Efficient state management
- Memory leak prevention
- Battery usage optimization

## 🚀 Deployment

The application is configured for deployment to:
- **Google Play Store** (Android)
- **Apple App Store** (iOS) 
- **Web** (GitHub Pages / Firebase Hosting)
- **Desktop** (Windows/macOS/Linux)

## 🤝 Development Practices

This project demonstrates:
- **Git Flow** with feature branches
- **Conventional Commits** for clear history
- **Code Review** best practices
- **Continuous Integration** readiness
- **Documentation** as code philosophy

## 📄 License

This project is created for demonstration purposes and job application showcase.

## 👨‍💻 Developer

**Qasim Abbas**
- Professional Flutter Developer
- Clean Architecture Advocate  
- Real-time Systems Specialist

---

*This project showcases enterprise-level Flutter development skills including Clean Architecture, real-time data integration, professional UI/UX design, and modern development practices.*
