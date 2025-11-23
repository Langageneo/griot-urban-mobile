# griot-urban-mobile
App mobile/desktop  Flutter
# Griot Urban Mobile (Flutter)

**Application mobile cross-platform** pour Griot Urban Culture, intégrant YouTube, Twitter et Instagram via un backend Node.js.

---

## 📌 Fonctionnalités
✅ **Flux unifié** : Agrège les contenus YouTube, Twitter et Instagram.
✅ **Design urbain** : Logo animé (SVG), thème sombre/clair, effets visuels.
✅ **Performances** : Chargement optimisé, cache local, APK/IPA légers.
✅ **Cross-platform** : Android, iOS, et potentiellement Web/Desktop.

---

## 🛠 Configuration

### 1. Prérequis
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (≥ 3.10.0)
- Android Studio / Xcode (pour les émulateurs)
- Un backend Node.js fonctionnel (voir [griot-urban-culture](https://github.com/langageneo/griot-urban-culture))

### 2. Variables d'environnement
Crée un fichier `.env` à la racine :
```env
API_BASE_URL=http://ton-ip-local:5000/api  # Remplace par l'URL de ton backend
