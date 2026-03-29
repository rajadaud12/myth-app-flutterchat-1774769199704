import 'package:flutter/material.dart';
import 'package:flutterchat_app/utils/colors.dart'; 

class CallsScreen extends StatelessWidget {
  const CallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calls',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(value: 'clear', child: Text('Clear call log')),
              PopupMenuItem(value: 'settings', child: Text('Settings')),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildCallSection('Recent', [
            CallData(
              name: 'John Doe',
              imageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
              time: 'Today, 9:30 AM',
              callType: CallType.outgoing,
              isVideo: true,
            ),
            CallData(
              name: 'Sarah Smith',
              imageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
              time: 'Today, 8:15 AM',
              callType: CallType.missed,
              isVideo: false,
            ),
            CallData(
              name: 'Mike Johnson',
              imageUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
              time: 'Yesterday, 6:45 PM',
              callType: CallType.incoming,
              isVideo: true,
            ),
            CallData(
              name: 'Emily Davis',
              imageUrl: 'https://randomuser.me/api/portraits/women/4.jpg',
              time: 'Yesterday, 3:20 PM',
              callType: CallType.missed,
              isVideo: false,
            ),
            CallData(
              name: 'David Wilson',
              imageUrl: 'https://randomuser.me/api/portraits/men/5.jpg',
              time: 'Yesterday, 11:00 AM',
              callType: CallType.outgoing,
              isVideo: false,
            ),
          ]),
          SizedBox(height: 80),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add_call),
      ),
    );
  }

  Widget _buildCallSection(String title, List<CallData> calls) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.grey,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: calls.length,
          itemBuilder: (context, index) {
            final call = calls[index];
            return _buildCallTile(call);
          },
        ),
      ],
    );
  }

  Widget _buildCallTile(CallData call) {
    IconData callIcon;
    Color iconColor;

    switch (call.callType) {
      case CallType.outgoing:
        callIcon = Icons.call_made;
        iconColor = AppColors.accent;
        break;
      case CallType.incoming:
        callIcon = Icons.call_received;
        iconColor = AppColors.accent;
        break;
      case CallType.missed:
        callIcon = Icons.call_missed;
        iconColor = AppColors.red;
        break;
    }

    return ListTile(
      leading: CircleAvatar(
        radius: 28,
        backgroundColor: AppColors.grey,
        backgroundImage: NetworkImage(call.imageUrl),
      ),
      title: Text(
        call.name,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
      ),
      subtitle: Row(
        children: [
          Icon(callIcon, size: 16, color: iconColor),
          SizedBox(width: 4),
          Text(
            call.time,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            call.isVideo ? Icons.videocam : Icons.call,
            color: AppColors.primary,
          ),
        ],
      ),
      onTap: () {},
    );
  }
}

class CallData {
  String name;
  String imageUrl;
  String time;
  CallType callType;
  bool isVideo;

  CallData({
    required this.name,
    required this.imageUrl,
    required this.time,
    required this.callType,
    required this.isVideo,
  });
}

enum CallType {
  outgoing,
  incoming,
  missed,
}