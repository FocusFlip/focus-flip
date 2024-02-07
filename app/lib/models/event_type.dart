class EventType {
  final int _value;

  const EventType(this._value);

  operator ==(dynamic other) {
    if (other is int) {
      return _value == other;
    } else if (other is EventType) {
      return _value == other._value;
    } else {
      return false;
    }
  }

  // ToString method to convert the enum to a string
  @override
  String toString() {
    return _value.toString();
  }

  static const EventType ACTIVITY_PAUSED = EventType(2);
  static const EventType ACTIVITY_RESUMED = EventType(1);
  static const EventType ACTIVITY_STOPPED = EventType(23);
  static const EventType CONFIGURATION_CHANGE = EventType(5);
  static const EventType DEVICE_SHUTDOWN = EventType(26);
  static const EventType DEVICE_STARTUP = EventType(27);
  static const EventType FOREGROUND_SERVICE_START = EventType(19);
  static const EventType FOREGROUND_SERVICE_STOP = EventType(20);
  static const EventType KEYGUARD_HIDDEN = EventType(18);
  static const EventType KEYGUARD_SHOWN = EventType(17);
  static const EventType MOVE_TO_BACKGROUND = EventType(2);
  static const EventType MOVE_TO_FOREGROUND = EventType(1);
  static const EventType NONE = EventType(0);
  static const EventType SCREEN_INTERACTIVE = EventType(15);
  static const EventType SCREEN_NON_INTERACTIVE = EventType(16);
  static const EventType SHORTCUT_INVOCATION = EventType(8);
  static const EventType STANDBY_BUCKET_CHANGED = EventType(11);
  static const EventType USER_INTERACTION = EventType(7);
}
