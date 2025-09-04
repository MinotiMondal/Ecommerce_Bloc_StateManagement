# 🛒 Mini E-Commerce App

A modern, feature-rich e-commerce mobile application built with Flutter using clean architecture and BLoC state management.

## 📱 Features

### Core Features
- **Product Listing**: Browse products in a responsive grid layout
- **Product Details**: Detailed product view with images, descriptions, and ratings
- **Shopping Cart**: Add, remove, and manage cart items with quantity controls
- **Offline Support**: Cached product data for offline browsing
- **Persistent Cart**: Cart state persists across app restarts
- **Responsive UI**: Optimized for both mobile and tablet devices

### Additional Features
- **Dark Mode**: System-based theme switching
- **Localization**: English and Spanish language support
- **Smooth Animations**: Enhanced user experience with fluid animations
- **Error Handling**: Comprehensive error handling with retry functionality
- **Pull-to-Refresh**: Refresh product data with pull gesture

## 🏗️ Architecture

This project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/                    # Core utilities and shared code
│   ├── constants/          # App constants and API endpoints
│   ├── error/              # Error handling and failure classes
│   ├── network/            # Network connectivity utilities
│   └── di/                 # Dependency injection setup
├── data/                   # Data layer
│   ├── datasources/        # Remote and local data sources
│   ├── models/             # Data models with JSON serialization
│   └── repositories/       # Repository implementations
├── domain/                 # Domain layer (business logic)
│   ├── entities/           # Business entities
│   ├── repositories/       # Repository interfaces
│   └── usecases/           # Use cases (business logic)
├── presentation/           # Presentation layer
│   ├── bloc/               # BLoC state management
│   ├── pages/              # UI screens
│   ├── widgets/            # Reusable UI components
│   └── theme/              # App theming
└── l10n/                   # Localization files
```

### Architecture Benefits
- **Testability**: Each layer can be tested independently
- **Maintainability**: Clear separation makes code easy to maintain
- **Scalability**: Easy to add new features without affecting existing code
- **Reusability**: Business logic is independent of UI framework

## 🛠️ Technologies & Libraries

### State Management
- **flutter_bloc (^8.1.6)**: BLoC pattern for predictable state management
- **equatable (^2.0.5)**: Value equality for BLoC states and events

### Network & Data
- **http (^1.2.2)**: HTTP client for API requests
- **hive (^2.2.3)**: Local database for caching and cart persistence
- **cached_network_image (^3.4.1)**: Efficient image loading and caching
- **connectivity_plus (^6.0.5)**: Network connectivity detection

### UI & UX
- **flutter_screenutil (^5.9.3)**: Responsive UI scaling
- **lottie (^3.1.2)**: Smooth animations
- **Material Design 3**: Modern UI components

### Architecture & Utils
- **get_it (^7.7.0)**: Dependency injection
- **dartz (^0.10.1)**: Functional programming (Either type)
- **json_annotation (^4.9.0)**: JSON serialization

### Testing
- **bloc_test (^9.1.7)**: BLoC testing utilities
- **mocktail (^1.0.4)**: Mocking framework
- **flutter_test**: Unit and widget testing

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.8.1)
- Dart SDK
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/mini-ecommerce-app.git
   cd mini-ecommerce-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Building for Release

**Android APK:**
```bash
flutter build apk --release
```

**Android App Bundle:**
```bash
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

## 🧪 Testing

Run all tests:
```bash
flutter test
```

Run tests with coverage:
```bash
flutter test --coverage
```

View coverage report:
```bash
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

## 📱 Screenshots

| Home Screen | Product Details | Shopping Cart |
|-------------|----------------|---------------|
| ![Home](screenshots/home.png) | ![Details](screenshots/details.png) | ![Cart](screenshots/cart.png) |

## 🌐 API Integration

The app integrates with the [Fake Store API](https://fakestoreapi.com/) for product data:

- **Base URL**: `https://fakestoreapi.com`
- **Products Endpoint**: `/products`
- **Single Product**: `/products/{id}`

### API Features
- Real product data with images
- Product categories
- Ratings and reviews
- No authentication required

## 📦 Project Structure

### Key Components

**BLoC State Management:**
- `ProductBloc`: Manages product listing and details
- `CartBloc`: Handles cart operations and state

**Data Layer:**
- `ProductRepository`: Product data management
- `CartRepository`: Cart data persistence
- Local caching with Hive database

**UI Components:**
- Responsive product grid
- Interactive cart with quantity controls
- Error handling with retry functionality

## 🔧 Configuration

### Environment Setup
The app is configured to work out of the box with the Fake Store API. No additional setup required.

### Customization
- **Theme**: Modify `lib/presentation/theme/app_theme.dart`
- **Constants**: Update `lib/core/constants/`
- **Localization**: Add new languages in `lib/l10n/`

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Style
- Follow Flutter/Dart conventions
- Use meaningful variable names
- Add comments for complex logic
- Write tests for new features

## 📋 TODO / Future Enhancements

- [ ] User authentication
- [ ] Product search and filtering
- [ ] Wishlist functionality
- [ ] Order history
- [ ] Payment integration
- [ ] Push notifications
- [ ] Social sharing
- [ ] Product reviews and ratings

## 🐛 Known Issues

- Image loading may be slow on poor network connections
- Cart animations could be smoother on older devices

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Your Name**
- GitHub: [@yourusername](https://github.com/yourusername)
- LinkedIn: [Your LinkedIn](https://linkedin.com/in/yourprofile)
- Email: your.email@example.com

## 🙏 Acknowledgments

- [Flutter Team](https://flutter.dev) for the amazing framework
- [Fake Store API](https://fakestoreapi.com) for providing test data
- [BLoC Library](https://bloclibrary.dev) for state management patterns
- [Material Design](https://material.io) for design guidelines

---

**Made with ❤️ and Flutter**