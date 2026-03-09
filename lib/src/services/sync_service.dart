import '../domain/models/sync_room.dart';

class SyncService {
  SyncRoom createRoom(String hostName) {
    return SyncRoom(code: 'BF24A7', hostName: hostName, participants: 1);
  }
}
