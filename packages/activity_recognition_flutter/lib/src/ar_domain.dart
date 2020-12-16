part of activity_recognition;

enum ActivityType {
  IN_VEHICLE,
  ON_BICYCLE,
  ON_FOOT,
  RUNNING,
  STILL,
  TILTING,
  UNKNOWN,
  WALKING,
  INVALID // Used for parsing errors
}

Map<String, ActivityType> _activityMap = {
  /// Android
  'IN_VEHICLE': ActivityType.IN_VEHICLE,
  'ON_BICYCLE': ActivityType.ON_BICYCLE,
  'ON_FOOT': ActivityType.ON_FOOT,
  'RUNNING': ActivityType.RUNNING,
  'STILL': ActivityType.STILL,
  'TILTING': ActivityType.TILTING,
  'UNKNOWN': ActivityType.UNKNOWN,
  'WALKING': ActivityType.WALKING,

  /// iOS
  'automotive': ActivityType.IN_VEHICLE,
  'cycling': ActivityType.ON_BICYCLE,
  'running': ActivityType.RUNNING,
  'stationary': ActivityType.STILL,
  'unknown': ActivityType.UNKNOWN,
  'walking': ActivityType.WALKING,
};

class ActivityEvent {
  ActivityType _type;
  int _confidence;
  DateTime _timeStamp;

  ActivityEvent(this._type, this._confidence) {
    this._timeStamp = DateTime.now();
  }

  factory ActivityEvent.empty() => ActivityEvent(ActivityType.UNKNOWN, 100);

  factory ActivityEvent.fromJson(Map<String, dynamic> jsonData) {
    /// Set activity to Invalid by default
    ActivityType activityType = ActivityType.INVALID;

    /// Parse JSON data
    String key = jsonData['type'];

    /// If parsing was successful, decode the activity type
    if (_activityMap.containsKey(key)) {
      activityType = _activityMap[key];
    }

    /// Parse the confidence
    int confidence = jsonData['confidence'];
    return ActivityEvent(activityType, confidence);
  }

  @override
  String toString() {
    String typeString = type.toString().split('.').last;
    return 'Activity: $typeString, (Confidence: $confidence)';
  }

  ActivityType get type => _type;

  DateTime get timeStamp => _timeStamp;

  int get confidence => _confidence;
}
