import 'package:flutter/material.dart';
import 'package:flutterchat_app/utils/colors.dart'; 
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

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
  final FocusNode focusNode = FocusNode();
  bool showSendButton = false;

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
  void initState() {
    super.initState();
    messageController.addListener(_updateSendButton);
  }

  void _updateSendButton() {
    setState(() {
      showSendButton = messageController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.background.withOpacity(0.0),
                    AppColors.background,
                  ],
                  stops: [0.0, 0.1],
                ),
              ),
              child: ListView.builder(
                controller: scrollController,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 1,
      shadowColor: AppColors.cardShadow,
      leadingWidth: 32,
      leading: Padding(
        padding: EdgeInsets.only(left: 8),
        child: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      title: Row(
        children: [
          _buildProfileAvatar(),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  widget.isOnline ? 'online' : 'offline',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: widget.isOnline ? AppColors.accent : AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(icon: Icon(Icons.videocam_outlined, color: AppColors.grey), onPressed: () {}),
        IconButton(icon: Icon(Icons.call_outlined, color: AppColors.grey), onPressed: () {}),
        PopupMenuButton(
          icon: Icon(Icons.more_vert, color: AppColors.grey),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          itemBuilder: (context) => [
            PopupMenuItem(value: 'contact', child: Text('View contact')),
            PopupMenuItem(value: 'media', child: Text('Media, links, and docs')),
            PopupMenuItem(value: 'search', child: Text('Search')),
            PopupMenuItem(value: 'mute', child: Text('Mute notifications')),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileAvatar() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: AppColors.lightGrey,
          backgroundImage: CachedNetworkImageProvider(widget.imageUrl),
        ),
        if (widget.isOnline)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: AppColors.online,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.surface, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 12),
      color: AppColors.surface,
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
                  color: AppColors.inputBackground,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: messageController,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    hintText: 'Message',
                    hintStyle: GoogleFonts.inter(
                      color: AppColors.grey,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                  textInputAction: TextInputAction.send,
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      _sendMessage();
                    }
                  },
                ),
              ),
            ),
            SizedBox(width: 8),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: showSendButton
                  ? Container(
                      key: ValueKey('send'),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.accent.withOpacity(0.4),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.send,
                        color: AppColors.white,
                        size: 20,
                      ),
                    )
                  : Container(
                      key: ValueKey('mic'),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.mic,
                        color: AppColors.white,
                        size: 20,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    setState(() {
      messages.add(Message(
        text: messageController.text,
        isMe: true,
        time: DateTime.now(),
        status: MessageStatus.sent,
      ));
      messageController.clear();
    });
    focusNode.unfocus();
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
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.78),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: message.isMe ? AppColors.chatBubble : AppColors.surface,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(message.isMe ? 20 : 4),
            bottomRight: Radius.circular(message.isMe ? 4 : 20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.text,
              style: GoogleFonts.inter(
                fontSize: 15,
                color: AppColors.textPrimary,
                height: 1.3,
              ),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${message.time.hour.toString().padLeft(2, '0')}:${message.time.minute.toString().padLeft(2, '0')}',
                  style: GoogleFonts.inter(
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