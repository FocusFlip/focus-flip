# Project Structure

- app: Flutter app


# Hive
Generate the Models  
flutter packages pub run build_runner build


# How to add Trigger Apps

1. In the iOS project -> Runner -> Shortcuts -> Intents: add an option in the enum type TriggerApp
2. In the iOS project -> Runner -> Shortcuts -> TriggerAppIntentHandler.handle: add a case
3. In dart project -> lib/repositories/predefined_app_list_repository.dart: add the app data