import 'package:flutter/material.dart';
import 'package:flutterchat_app/utils/colors.dart'; 
import 'package:flutterchat_app/screens/chat_screen.dart'; 
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  List<ChatContact> chats = [
    ChatContact(
      name: 'John Doe',
      lastMessage: 'Hey, how are you doing?',
      time: DateTime.now().subtract(Duration(minutes: 5)),
      imageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
      unreadCount: 2,
      isOnline: true,
    ),
    ChatContact(
      name: 'Sarah Smith',
      lastMessage: 'See you tomorrow! 🎉',
      time: DateTime.now().subtract(Duration(hours: 2)),
      imageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
      unreadCount: 0,
      isOnline: false,
    ),
    ChatContact(
      name: 'Mike Johnson',
      lastMessage: 'Thanks for the help!',
      time: DateTime.now().subtract(Duration(hours: 5)),
      imageUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
      unreadCount: 5,
      isOnline: true,
    ),
    ChatContact(
      name: 'Emily Davis',
      lastMessage: 'Can you send me the file?',
      time: DateTime.now().subtract(Duration(days: 1)),
      imageUrl: 'https://randomuser.me/api/portraits/women/4.jpg',
      unreadCount: 0,
      isOnline: false,
    ),
    ChatContact(
      name: 'Family Group',
      lastMessage: 'Mom: Happy birthday!',
      time: DateTime.now().subtract(Duration(days: 1)),
      imageUrl: 'https://randomuser.me/api/portraits/lego/1.jpg',
      unreadCount: 3,
      isOnline: false,
      isGroup: true,
    ),
    ChatContact(
      name: 'David Wilson',
      lastMessage: '👍',
      time: DateTime.now().subtract(Duration(days: 2)),
      imageUrl: 'https://randomuser.me/api/portraits/men/5.jpg',
      unreadCount: 0,
      isOnline: true,
    ),
    ChatContact(
      name: 'Lisa Brown',
      lastMessage: 'Let me know when you are free',
      time: DateTime.now().subtract(Duration(days: 3)),
      imageUrl: 'https://randomuser.me/api/portraits/women/6.jpg',
      unreadCount: 1,
      isOnline: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FlutterChat',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(icon: Icon(Icons.camera_alt_outlined), onPressed: () {}),
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(value: 'new_group', child: Text('New group')),
              PopupMenuItem(value: 'new_broadcast', child: Text('New broadcast')),
              PopupMenuItem(value: 'settings', child: Text('Settings')),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ChatListTile(chat: chat);
        },
      ),
    );
  }
}

class ChatListTile extends StatelessWidget {
  final ChatContact chat;

  const ChatListTile({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              name: chat.name,
              imageUrl: chat.imageUrl,
              isOnline: chat.isOnline,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.grey,
                  backgroundImage: NetworkImage(chat.imageUrl),
                ),
                if (chat.isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: AppColors.online,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        chat.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: chat.unreadCount > 0 ? FontWeight.bold : FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                      Text(
                        _formatTime(chat.time),
                        style: TextStyle(
                          fontSize: 12,
                          color: chat.unreadCount > 0 ? AppColors.accent : AppColors.grey,
                          fontWeight: chat.unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      if (chat.isGroup) ...[
                        Icon(Icons.group, size: 16, color: AppColors.grey),
                        SizedBox(width: 4),
                      ],
                      Expanded(
                        child: Text(
                          chat.lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.grey,
                            fontWeight: chat.unreadCount > 0 ? FontWeight.w500 : FontWeight.normal,
                          ),
                        ),
                      ),
                      if (chat.unreadCount > 0) ...[
                        SizedBox(width: 8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            chat.unreadCount.toString(),
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays == 0) {
      return DateFormat('HH:mm').format(time);
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return DateFormat('EEE').format(time);
    } else {
      return DateFormat('dd/MM/yy').format(time);
    }
  }
}

class ChatContact {
  String name;
  String lastMessage;
  DateTime time;
  String imageUrl;
  int unreadCount;
  bool isOnline;
  bool isGroup;

  ChatContact({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.imageUrl,
    required this.unreadCount,
    required this.isOnline,
    this.isGroup = false,
  });
}