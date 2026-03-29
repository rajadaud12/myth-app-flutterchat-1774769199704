import 'package:flutter/material.dart';
import 'package:flutterchat_app/utils/colors.dart'; 
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: Text(
          'Status',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          IconButton(icon: Icon(Icons.search, color: AppColors.grey), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMyStatus(),
            Divider(height: 1, indent: 88, color: AppColors.divider),
            _buildStatusSection('Recent updates', AppColors.accent),
            _buildStatusList(),
            Divider(height: 1, indent: 88, color: AppColors.divider),
            _buildStatusSection('Viewed updates', AppColors.grey),
            _buildStatusList(isViewed: true),
            SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.inputBackground,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: FloatingActionButton.small(
              heroTag: 'edit',
              onPressed: () {},
              backgroundColor: AppColors.surface,
              foregroundColor: AppColors.primary,
              elevation: 0,
              child: Icon(Icons.edit, size: 20),
            ),
          ),
          SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.4),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: FloatingActionButton(
              heroTag: 'camera',
              onPressed: () {},
              elevation: 0,
              child: Icon(Icons.camera_alt, size: 24),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyStatus() {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            _buildAvatarWithAdd(),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My status',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Tap to add status update',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarWithAdd() {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.accent, width: 3),
          ),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.lightGrey,
            backgroundImage: CachedNetworkImageProvider('https://randomuser.me/api/portraits/men/10.jpg'),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.surface, width: 2),
            ),
            child: Icon(
              Icons.add,
              size: 14,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusSection(String title, Color dotColor) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusList({bool isViewed = false}) {
    final statuses = [
      {'name': 'John Doe', 'image': 'https://randomuser.me/api/portraits/men/1.jpg'},
      {'name': 'Sarah Smith', 'image': 'https://randomuser.me/api/portraits/women/2.jpg'},
      {'name': 'Mike Johnson', 'image': 'https://randomuser.me/api/portraits/men/3.jpg'},
      {'name': 'Emily Davis', 'image': 'https://randomuser.me/api/portraits/women/4.jpg'},
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: statuses.length,
      itemBuilder: (context, index) {
        final status = statuses[index];
        return _buildStatusTile(status, isViewed);
      },
    );
  }

  Widget _buildStatusTile(Map<String, String> status, bool isViewed) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isViewed ? AppColors.grey : AppColors.accent,
                width: 3,
              ),
            ),
            child: CircleAvatar(
              radius: 26,
              backgroundColor: AppColors.lightGrey,
              backgroundImage: CachedNetworkImageProvider(status['image']!),
            ),
          ),
        ],
      ),
      title: Text(
        status['name']!,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
      ),
      subtitle: Text(
        isViewed ? 'Today, 2:30 PM' : 'Today, 10:30 AM',
        style: GoogleFonts.inter(
          fontSize: 13,
          color: AppColors.grey,
        ),
      ),
      onTap: () {},
    );
  }
}