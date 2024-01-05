class TriggerApp {
  /// Name is final to avoid updates. Otherwise, a recreation of the
  /// corresponding Siri Shortcut on iOS is required which will require multiple
  /// additional user actions
  final String name;

  // iOS properties

  /// UUID is used as triggerShortcutPersistendIdentifier
  String? triggerShortcutPersistentIdentifier;

  String? launchingSiriShortcut;

  TriggerApp({required this.name, this.triggerShortcutPersistentIdentifier});
}
