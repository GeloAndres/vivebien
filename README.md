
```markdown
# ViveBien ❤️ 

Aplicación móvil diseñada para mejorar la calidad de vida de adultos mayores, con enfoque en accesibilidad y facilidad de uso.

## ✨ Características principales
- Interfaz accesible con tamaños de fuente grandes
- Botones de acción rápida para emergencias
- Recordatorio de medicamentos inteligente
- Sistema de alertas para familiares
- Configuración adaptable a necesidades visuales
- Conexión en tiempo real con cuidadores
- Autenticación segura con Firebase
- Almacenamiento en la nube de datos médicos

## 🛠 Tecnologías utilizadas
Frontend:
- Flutter 3.24.0
- Dart 3.5.0

Backend:  
- Firebase
- Cloud Firestore
- Firebase Auth
- Cloud Messaging


🚀 Instalación

```
1. Clona el repositorio:
```bash
git clone https://github.com/GeloAndres/vivebien.git
```

2. Instala las dependencias:
```bash
flutter clean && flutter pub get
```

3. Ejecuta la aplicación:
```bash
flutter run
```

**Requisitos:**
- Flutter SDK 3.0+
- Dispositivo Android/iOS
- Configuración de Firebase (sigue los pasos en https://firebase.google.com/docs/flutter/setup?hl=es-419&platform=android



## 🏗 Estructura del proyecto
```
lib/
├── main.dart
├── models/
├── services/
│   ├── auth_service.dart
│   └── database_service.dart
├── widgets/
│   └── accessibility_switch.dart
├── screens/
│   ├── home_screen.dart
│   └── medication_screen.dart
firebase/
├── firebase_options.dart
└── service_account.json
```

## 🔥 Configuración Firebase
1. Crea un proyecto en [Firebase Console](https://console.firebase.google.com/)
2. Descarga los archivos de configuración:
   - `android/app/google-services.json`
   - `ios/Runner/GoogleService-Info.plist`
3. Habilita los servicios:
   - Authentication (Email/Phone)
   - Firestore Database
   - Cloud Messaging
   - Storage

## 🤝 Cómo contribuir
1. Haz fork del proyecto (https://github.com/GeloAndres/vivebien/fork)
2. Crea una rama para tu feature (`git checkout -b feature/nueva-funcionalidad`)
3. Realiza tests de accesibilidad
4. Haz commit de tus cambios (`git commit -m 'feat: Agrega sistema de recordatorios'`)
5. Haz push a la rama (`git push origin feature/nueva-funcionalidad`)
6. Abre un Pull Request

---