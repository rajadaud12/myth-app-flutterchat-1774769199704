import 'package:flutter/material.dart';
import 'package:flutterchat_app/utils/colors.dart'; 

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Status',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMyStatus(),
            Divider(height: 1),
            _buildStatusSection('Recent updates'),
            _buildStatusList(),
            Divider(height: 1),
            _buildStatusSection('Viewed updates'),
            _buildStatusList(isViewed: true),
            SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            heroTag: 'edit',
            onPressed: () {},
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.primary,
            child: Icon(Icons.edit),
          ),
          SizedBox(height: 12),
          FloatingActionButton(
            heroTag: 'camera',
            onPressed: () {},
            child: Icon(Icons.camera_alt),
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
            Stack(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: AppColors.grey,
                  backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/10.jpg'),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 2),
                    ),
                    child: Icon(
                      Icons.add,
                      size: 16,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My status',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Tap to add status update',
                    style: TextStyle(
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

  Widget _buildStatusSection(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.grey,
        ),
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
        return ListTile(
          leading: Stack(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: isViewed ? AppColors.grey : AppColors.accent,
                backgroundImage: NetworkImage(status['image']!),
              ),
              if (!isViewed)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          title: Text(
            status['name']!,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
          subtitle: Text(
            isViewed ? 'Today, 2:30 PM' : 'Today, 10:30 AM',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.grey,
            ),
          ),
          onTap: () {},
        );
      },
    );
  }
}