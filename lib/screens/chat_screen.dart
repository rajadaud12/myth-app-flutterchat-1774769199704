import 'package:flutter/material.dart';
import 'package:flutterchat_app/utils/colors.dart'; 

class ChatScreen extends StatefulWidget {
  final String name;
  final String imageUrl;
  final bool isOnline;

  const ChatScreen({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.isOnline,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  List<Message> messages = [
    Message(text: 'Hey there!', isMe: false, time: DateTime.now().subtract(Duration(hours: 2)), status: MessageStatus.delivered),
    Message(text: 'Hi! How are you?', isMe: true, time: DateTime.now().subtract(Duration(hours: 2, minutes: 1)), status: MessageStatus.read),
    Message(text: 'I am good, thanks for asking! 😊', isMe: false, time: DateTime.now().subtract(Duration(hours: 1, minutes: 55)), status: MessageStatus.delivered),
    Message(text: 'What have you been up to?', isMe: true, time: DateTime.now().subtract(Duration(hours: 1, minutes: 50)), status: MessageStatus.read),
    Message(text: 'Just working on some projects. Been pretty busy lately!', isMe: false, time: DateTime.now().subtract(Duration(hours: 1, minutes: 45)), status: MessageStatus.delivered),
    Message(text: 'That sounds great! Let me know if you need any help.', isMe: true, time: DateTime.now().subtract(Duration(hours: 1)), status: MessageStatus.read),
    Message(text: 'Sure, will do! 👍', isMe: false, time: DateTime.now().subtract(Duration(minutes: 30)), status: MessageStatus.delivered),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 24,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(widget.imageUrl),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.isOnline ? 'online' : 'offline',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.videocam_outlined), onPressed: () {}),
          IconButton(icon: Icon(Icons.call_outlined), onPressed: () {}),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(value: 'contact', child: Text('View contact')),
              PopupMenuItem(value: 'media', child: Text('Media, links, and docs')),
              PopupMenuItem(value: 'search', child: Text('Search')),
              PopupMenuItem(value: 'mute', child: Text('Mute notifications')),
              PopupMenuItem(value: 'wallpaper', child: Text('Wallpaper')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://user-images.githubusercontent.com/15075759/28719144-86dc0f70-73b1-11e7-911d-60d70fcded21.png'),
                  fit: BoxFit.cover,
                  opacity: 0.3,
                ),
              ),
              child: ListView.builder(
                controller: scrollController,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return MessageBubble(message: messages[index]);
                },
              ),
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: AppColors.white,
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.emoji_emotions_outlined, color: AppColors.grey),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.attach_file, color: AppColors.grey),
              onPressed: () {},
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                    hintText: 'Message',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.mic,
                color: AppColors.white,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: message.isMe ? AppColors.chatBubble : AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(message.isMe ? 16 : 4),
            bottomRight: Radius.circular(message.isMe ? 4 : 16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.text,
              style: TextStyle(
                fontSize: 15,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${message.time.hour.toString().padLeft(2, '0')}:${message.time.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.grey,
                  ),
                ),
                if (message.isMe) ...[
                  SizedBox(width: 4),
                  Icon(
                    message.status == MessageStatus.read ? Icons.done_all : Icons.done,
                    size: 16,
                    color: message.status == MessageStatus.read ? AppColors.unread : AppColors.grey,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Message {
  String text;
  bool isMe;
  DateTime time;
  MessageStatus status;

  Message({
    required this.text,
    required this.isMe,
    required this.time,
    required this.status,
  });
}

enum MessageStatus {
  sent,
  delivered,
  read,
}