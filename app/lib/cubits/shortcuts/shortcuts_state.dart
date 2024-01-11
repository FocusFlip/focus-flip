part of 'shortcuts_cubit.dart';

@immutable
sealed class ShortcutsState {}

final class ShortcutsNotInitialized extends ShortcutsState {}

final class ShortcutsInitialized extends ShortcutsState {}

final class TriggerAppOpenedShortcut extends ShortcutsState {
  final String appName;

  TriggerAppOpenedShortcut(this.appName);
}
