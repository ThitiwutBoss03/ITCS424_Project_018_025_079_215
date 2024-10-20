# MUICT Connect 🎓📱

MUICT Connect is designed to enhance communication within the Faculty of ICT by providing a centralized platform for distributing academic and extracurricular information efficiently. This platform aims to support students in staying organized and informed about upcoming events and opportunities. 🚀🎉

## Prerequisites ✅

- Flutter installed on your system 🛠️
- Firebase account setup 🔥
- Access to Firebase and Google Cloud services ☁️

## Installation ⚙️

1. Clone the project repository:
   ```bash
   git clone https://github.com/ThitiwutBoss03/ITCS424_Project_018_025_079_215.git
   ```
2. Navigate to the project directory:
   ```bash
   cd MUICT-Connect
   ```

## Setup 🔧

1. Install required Flutter plugins:
   ```bash
   flutter pub add firebase_core
   flutter pub add cloud_firestore
   ```

2. Setup Firebase:
   - Configure your Firebase project in the Firebase console.
   - Download `google-services.json` and place it in your project's `app` directory.

3. Setup OpenWeather API:
   - Obtain an API key from OpenWeather 🌦️.
   - Store the API key in your Flutter environment or configuration file.
   - API Key (OpenWeather): ```86fb463f2dc2a3f8797be6018610d38a``` or ```3d5ea248b7dc3061d739255f5a6cb50e```

4. Initialize Firebase and OpenWeather API in your Flutter application:
   - Import `firebase_core` and add Firebase initialization code in `main.dart`.
   - Configure API calls to OpenWeather to fetch and display weather data.

## Running the Application ▶️

To run the application, use the following Flutter command:
```bash
flutter run
```

This command compiles the application and launches it on a connected device or emulator.

## Features 🌟

- User registration and login 🔐
- Real-time weather updates using OpenWeather API ☁️🌡️
- Calendar integration for event management 📅
- Post creation and management with bookmark features 📌📝

## Contributing 🙌

Contributions are welcome! 🎉 Please fork the repository and submit pull requests to the development branch.

## License 📜

This project is licensed under the MIT License - see the LICENSE.md file for details.

## Contact Information 📧

For further inquiries or issues, please contact us through our GitHub repository or email the project maintainers directly.
