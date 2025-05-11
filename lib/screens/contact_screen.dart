import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:thea/theme/app_theme.dart';

class ContactUsScreen extends StatelessWidget {
  final String websiteUrl = 'https://www.thea.com';
  final String phoneNumber = '2101234567';
  final String instagramUrl = 'https://www.instagram.com/thea';
  final LatLng location = LatLng(37.9838, 23.7275);

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchPhone(String phoneNumber) async {
    final Uri uri = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us', style: TextStyle(color: Colors.black87)),
        backgroundColor: AppColors.background,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Get in touch with Thea!',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24.0),
            ListTile(
              leading: const Icon(Icons.web),
              title: const Text('Website'),
              subtitle: Text(websiteUrl),
              onTap: () => _launchURL(websiteUrl),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Phone'),
              subtitle: Text(phoneNumber),
              onTap: () => _launchPhone(phoneNumber),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Instagram'),
              subtitle: Text(instagramUrl),
              onTap: () => _launchURL(instagramUrl),
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Our Location',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 200.0,
              width: double.infinity,
              child: FlutterMap(
                options: MapOptions(
                  center: location,
                  zoom: 15.0,
                  interactiveFlags: InteractiveFlag.none, // Disable map interaction
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 40.0,
                        height: 40.0,
                        point: location,
                        child: const Icon(Icons.location_pin, color: Colors.red, size: 40.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: AppColors.container,
        unselectedItemColor: AppColors.darkText,
        backgroundColor: AppColors.background,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home_page');
              break;
            case 1:
              Navigator.pushNamed(context, '/my_tickets');
              break;
            case 2:
            // Current screen
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number),
            label: 'My tickets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_accessibility),
            label: 'Preferences',
          ),
        ],
      ),
    );
  }
}