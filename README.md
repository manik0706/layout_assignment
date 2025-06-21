# Interactive Box Layout - Flutter App

A beautiful and interactive Flutter application that creates dynamic box layouts in the shape of the letter 'C'. Users can tap boxes to change their colors and watch mesmerizing reverse animations.

![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)
![Dart](https://img.shields.io/badge/Dart-2.17+-blue.svg)
![Provider](https://img.shields.io/badge/State%20Management-Provider-green.svg)

## 🎯 Features

- **Dynamic C-Shape Layout**: Creates perfect 'C' patterns with 5-25 boxes
- **Interactive Gameplay**: Tap red boxes to turn them green
- **Reverse Animation**: Automatic reverse sequence when all boxes are green
- **Statistics Tracking**: Rounds completed, total clicks, and best completion time
- **Dark/Light Theme**: Toggle between beautiful themes
- **Haptic Feedback**: Satisfying vibration feedback on interactions
- **Responsive Design**: Adapts to all screen sizes and orientations
- **Smooth Animations**: Entrance animations, pulse effects, and ripple feedback

## 📱 Screenshots

\`\`\`
N = 5          N = 8
██             ███
█              █
██             █
               ███
\`\`\`

## 🚀 Getting Started

### Prerequisites

- Flutter SDK: **3.0.0 or higher**
- Dart SDK: **2.17.0 or higher**
- Android Studio / VS Code with Flutter extensions
- Android device/emulator or iOS device/simulator

### Installation

1. **Clone the repository**
   \`\`\`bash
   git clone https://github.com/your-username/interactive-box-layout.git
   cd interactive-box-layout
   \`\`\`

2. **Install dependencies**
   \`\`\`bash
   flutter pub get
   \`\`\`

3. **Run the app**
   \`\`\`bash
   flutter run
   \`\`\`

### Dependencies

The app uses minimal external dependencies:

\`\`\`yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.1        # State management
  cupertino_icons: ^1.0.2 # iOS-style icons
\`\`\`

## 🏗️ Architecture & Implementation

### Project Structure

\`\`\`
lib/
├── main.dart                    # App entry point with MultiProvider
├── models/                      # Data models
│   ├── box_model.dart          # Box state and properties
│   └── game_stats.dart         # Game statistics
├── providers/                   # State management
│   ├── game_provider.dart      # Game logic and state
│   └── ui_provider.dart        # UI state management
├── screens/
│   └── home_screen.dart        # Main game screen
├── widgets/                     # Reusable components
│   ├── animated_box.dart       # Individual box widget
│   ├── box_layout.dart         # C-shape layout
│   ├── input_section.dart      # Number input
│   ├── instructions_card.dart  # Game instructions
│   ├── reset_button.dart       # Reset functionality
│   ├── shake_widget.dart       # Error animation
│   └── stats_card.dart         # Statistics display
└── utils/                       # Utility classes
    ├── app_theme.dart          # Theme definitions
    └── c_shape_calculator.dart # Layout calculations
\`\`\`

### State Management

The app uses **Provider** for state management with two main providers:

#### GameProvider
- Manages game logic, box states, and animations
- Handles user interactions and game flow
- Tracks statistics and completion times
- Controls reverse animation sequence

#### UIProvider  
- Manages UI state (dark mode, stats visibility)
- Handles theme switching and UI preferences
- Provides clean separation of UI and business logic

### C-Shape Algorithm Implementation

The core logic for creating the 'C' shape is implemented in `CShapeCalculator`:

\`\`\`dart
// Special handling for different numbers
if (numberOfBoxes == 5) {
  topBottomCount = 2;  // Top: 2, Middle: 1, Bottom: 2
  middleCount = 1;
} else if (numberOfBoxes == 6) {
  topBottomCount = 2;  // Top: 2, Middle: 2, Bottom: 2  
  middleCount = 2;
} else if (numberOfBoxes == 8) {
  topBottomCount = 3;  // Top: 3, Middle: 2, Bottom: 3
  middleCount = 2;
} else {
  // Proportional distribution for larger numbers
  topBottomCount = (numberOfBoxes / 3).ceil();
  middleCount = numberOfBoxes - (topBottomCount * 2);
}
\`\`\`

**Layout Pattern:**
1. **Top Row**: Horizontal line of boxes
2. **Middle Rows**: Single boxes on the left (vertical line)
3. **Bottom Row**: Horizontal line matching top row

### Animation System

The app features a sophisticated animation system:

#### Box Animations
- **Entrance Animation**: Staggered scale-in effect when boxes are generated
- **Pulse Animation**: Continuous subtle animation on red boxes
- **Ripple Effect**: Radial animation when boxes are tapped
- **Color Transition**: Smooth gradient transitions between red and green

#### UI Animations  
- **Shake Animation**: Error feedback for invalid input
- **Stats Panel**: Smooth expand/collapse animation
- **Theme Transition**: Seamless dark/light mode switching

### Responsive Design

The layout adapts to different screen sizes:

\`\`\`dart
// Dynamic box sizing based on screen width
double calculatedBoxSize = (availableWidth - (maxBoxes * margin)) / maxBoxes;
double boxSize = calculatedBoxSize.clamp(minSize, maxSize);
\`\`\`

- **Minimum Box Size**: 35px (for small screens)
- **Maximum Box Size**: 80px (for large screens)  
- **Responsive Spacing**: Margins adjust based on available space
- **Overflow Prevention**: Uses Wrap widgets and scroll views

### Game Logic Flow

1. **Input Validation**: Ensures number is between 5-25
2. **Box Generation**: Creates BoxModel instances with initial state
3. **Layout Calculation**: Determines C-shape distribution
4. **User Interaction**: Handles tap events and state updates
5. **Completion Detection**: Checks if all boxes are green
6. **Reverse Animation**: Automatically reverses in click order
7. **Statistics Update**: Tracks performance metrics

### Performance Optimizations

- **Consumer Widgets**: Targeted rebuilds only when specific state changes
- **Animation Controllers**: Proper lifecycle management and disposal
- **Immutable State**: Using copyWith patterns for efficient updates
- **Widget Separation**: Modular components prevent unnecessary rebuilds

## 🎮 How to Play

1. **Enter a number** between 5-25 in the input field
2. **Tap "Generate"** to create the C-shaped box layout
3. **Tap red boxes** to turn them green (remember the order!)
4. **Watch the magic** as boxes automatically turn back to red in reverse order
5. **Track your stats** by tapping the eye icon in the app bar
6. **Reset anytime** using the reset button to start over

## 🎨 Customization

### Themes
The app supports both light and dark themes with custom color schemes:
- Toggle using the theme button in the app bar
- Themes are defined in `utils/app_theme.dart`
- Automatic system theme detection available

### Colors
Box colors can be customized in the `AnimatedBox` widget:
- Red gradient: `[Colors.red[400]!, Colors.red[600]!]`
- Green gradient: `[Colors.green[400]!, Colors.green[600]!]`

## 🧪 Testing

Run tests using:
\`\`\`bash
flutter test
\`\`\`

The modular architecture makes the app highly testable:
- **Unit Tests**: Test providers and utility functions
- **Widget Tests**: Test individual components
- **Integration Tests**: Test complete user flows

## 🚀 Building for Release

### Android
\`\`\`bash
flutter build apk --release
# or
flutter build appbundle --release
\`\`\`

### iOS  
\`\`\`bash
flutter build ios --release
\`\`\`

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (\`git checkout -b feature/amazing-feature\`)
3. Commit your changes (\`git commit -m 'Add amazing feature'\`)
4. Push to the branch (\`git push origin feature/amazing-feature\`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Provider package for clean state management
- Material Design for beautiful UI components
- The Flutter community for inspiration and support

## 📞 Support

If you have any questions or run into issues:

1. Check the [Issues](https://github.com/your-username/interactive-box-layout/issues) page
2. Create a new issue with detailed information
3. Include Flutter version, device info, and error logs

---

**Made with ❤️ and Flutter**

*Enjoy the satisfying experience of interactive box layouts!*
\`\`\`
