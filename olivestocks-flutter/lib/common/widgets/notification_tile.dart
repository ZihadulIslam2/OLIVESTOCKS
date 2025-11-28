
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../features/portfolio/domains/notification_response_model.dart';

class NotificationTile extends StatelessWidget {
  final NotificationResponseModel notification;

  NotificationTile({super.key, required this.notification});

  String formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    return DateFormat('MMM d, yyyy – h:mm a').format(dateTime.toLocal());
  }

  final Uri _url = Uri.parse('https://flutter.dev');
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
    }
  }
  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String avatar = 'assets/images/avatar_notification/avatar1.png';
    

    return Column(
      children: [
        const SizedBox(height: 5),
        ListTile(
          onTap: () {
            _launchUrl(notification.link!);
          },
          // leading: Image.asset(
          //   avatar,
          //   width: 40,
          //   height: 40,
          //   fit: BoxFit.cover,
          // ),
          title: Text(notification.message ?? "No message",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatDateTime(notification.createdAt),
                style: const TextStyle(fontSize: 12),
              ),
              Container(
                width: size.width * .15,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                     " ${notification.related!}",
                    style: const TextStyle(fontSize: 12,color: Colors.blue,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),

          trailing: const Icon(Icons.more_horiz),
        ),
        const Divider(),
      ],
    );
  }
}

