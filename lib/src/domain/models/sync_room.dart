class SyncRoom {
  const SyncRoom({
    required this.code,
    required this.hostName,
    required this.participants,
  });

  final String code;
  final String hostName;
  final int participants;
}
