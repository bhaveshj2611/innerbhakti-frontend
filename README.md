# Inner Bhakti

Inner Bhakti is a spiritual wellness application that connects users to meditation and mindfulness practices through an intuitive interface. This repository contains both the **Frontend** (Flutter) and **Backend** (API) components.

---

## **Frontend (Flutter)**

### **Setup Instructions**

#### **Prerequisites**

Before running the Flutter app, ensure you have the following installed on your system:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/)
- [Dart SDK](https://dart.dev/get-dart)
- A device or emulator (Android/iOS)

#### **Clone the Repository**

```
git clone https://github.com/bhaveshj2611/inner-bhakti.git
cd inner-bhakti
```

Install Dependencies
To install the required dependencies for the Flutter project, run the following command:

```
flutter pub get
```
Create .env File
Create a .env file in the root of the Flutter project directory and define your API URL:

```
BASE_URL=https://innerbhakti-backend-production.up.railway.app/api
```
Ensure that .env is properly loaded in the app (see the flutter_dotenv package setup).

Run the App
For Android:

```
flutter run --release
```

For iOS:

```
flutter run
```


Setup Instructions
Prerequisites
Before setting up the backend, make sure you have the following:

Node.js (or your backend's tech stack)
MongoDB or another database (ensure MongoDB Atlas or a local database is set up)
AWS for file hosting (if applicable)
Clone the Repository

```
git clone https://github.com/your-username/inner-bhakti-backend.git
cd inner-bhakti-backend
```
Install Dependencies
Install required dependencies:
```
npm install
```

Set Up Environment Variables
Create a .env file in the root directory and set up your environment variables for database access, API keys, etc.

Example .env file:
```
MONGO_URI=mongodb://your_mongo_uri
BASE_URL=https://innerbhakti-backend-production.up.railway.app/api
```

Run the Backend
Start the backend server:
```
npm start
```
Or if you are using nodemon for hot reloading:

```
npm run dev
```

