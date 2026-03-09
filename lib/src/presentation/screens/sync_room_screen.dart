import 'package:flutter/material.dart';

class SyncRoomScreen extends StatelessWidget {
  const SyncRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        ListTile(
          leading: Icon(Icons.meeting_room),
          title: Text('Create Sync Room'),
          subtitle: Text('Generate 6-digit room code, invite by link/QR.'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.hub),
          title: Text('Room controls'),
          subtitle: Text('Host playback, DJ permissions, queue voting, chat.'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.timelapse),
          title: Text('Latency target < 500ms'),
          subtitle: Text('NTP offset + timestamp correction model.'),
        ),
      ],
    );
  }
}
