import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thea/theme/app_theme.dart';
import 'package:thea/models/user.dart';
import 'package:thea/widgets/bottom_navigation_bar.dart';
import 'dart:convert';

import 'my_tickets_screen.dart';

class PreferencesNotifier extends ChangeNotifier {
  bool _isDarkMode = false;
  double _textScale = 1.0;

  bool get isDarkMode => _isDarkMode;
  double get textScale => _textScale;

  PreferencesNotifier() {
    _loadFromSharedPrefs();
  }

  Future<void> _loadFromSharedPrefs() async {
    final preferences = await SharedPreferences.getInstance();
    _isDarkMode = preferences.getBool('isDarkMode') ?? false;
    _textScale = preferences.getDouble('textScale') ?? 1.0;
    notifyListeners();
  }

  Future<void> _saveToSharedPrefs() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isDarkMode', _isDarkMode);
    await preferences.setDouble('textScale', _textScale);
  }

  void toggleTheme(bool darkMode) {
    _isDarkMode = darkMode;
    _saveToSharedPrefs();
    notifyListeners();
  }

  void setTextScale(double scale) {
    _textScale = scale;
    _saveToSharedPrefs();
    notifyListeners();
  }
}

class UserNotifier extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  UserNotifier() {
    _loadUserFromSharedPrefs();
  }

  Future<void> _loadUserFromSharedPrefs() async {
    final preferences = await SharedPreferences.getInstance();
    final userString = preferences.getString('user');
    if (userString != null) {
      _user = User.fromJson(json.decode(userString));
      notifyListeners();
    } else {
      _user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: 'Guest',
        email: '',
      );
      await _saveUserToSharedPrefs();
      notifyListeners();
    }
  }

  Future<void> _saveUserToSharedPrefs() async {
    final preferences = await SharedPreferences.getInstance();
    if (_user != null) {
      final userString = json.encode(_user!.toJson());
      await preferences.setString('user', userString);
    }
  }

  Future<void> updateUser({required String name, required String email}) async {
    if (_user != null) {
      _user = User(id: _user!.id, name: name, email: email);
      _saveUserToSharedPrefs();
      notifyListeners();
    }
  }
}

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});
  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    final userNotifier = context.read<UserNotifier>();
    final user = userNotifier.user;
    nameController = TextEditingController(text: user?.name ?? '');
    emailController = TextEditingController(text: user?.email ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final preferences = context.watch<PreferencesNotifier>();
    final userNotifier = context.watch<UserNotifier>();
    final user = userNotifier.user;

    if (user != null) {
      if (nameController.text != user.name) {
        nameController.text = user.name;
      }
      if (emailController.text != user.email) {
        emailController.text = user.email;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Preferences")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/images/user_avatar.png"),
            ),
            const SizedBox(height: 12),
            Text(
              user?.name ?? 'Guest',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Profile Info',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                await userNotifier.updateUser(
                  name: nameController.text.trim(),
                  email: emailController.text.trim(),
                );
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile updated')),
                  );
                }
              },
              child: const Text('Save Changes'),
            ),
            const SizedBox(height: 32),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'App Customization',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              title: const Text('Dark Mode'),
              secondary: const Icon(Icons.dark_mode_rounded),
              value: preferences.isDarkMode,
              onChanged: (val) => preferences.toggleTheme(val),
              activeColor:
                  preferences.isDarkMode
                      ? AppColorsDark.container
                      : AppColors.container,
              tileColor: (preferences.isDarkMode
                      ? AppColorsDark.background
                      : AppColors.background)
                  .withValues(alpha: 0.15),
              selectedTileColor: (preferences.isDarkMode
                      ? AppColorsDark.container
                      : AppColors.container)
                  .withValues(alpha: 0.15),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Text Size'),
                Slider(
                  min: 1,
                  max: 1.6,
                  divisions: 2,
                  label:
                      preferences.textScale == 1
                          ? 'Normal'
                          : preferences.textScale == 1.25
                          ? 'Large'
                          : 'Extra Large',
                  value: preferences.textScale,
                  onChanged: (val) => preferences.setTextScale(val),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Transform.scale(
              scale: preferences.textScale,
              child: const Text('This is an example text.'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyNavBar(currentIndex: 2),
    );
  }
}
