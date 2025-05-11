import 'package:flutter/material.dart';
import 'package:thea/theme/app_theme.dart';

import '../data/faq.dart' as faq;

class FAQScreen extends StatefulWidget {
  final List<faq.FAQItem> faqItems = faq.faqItems;

  FAQScreen({Key? key}) : super(key: key);

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final List<bool> _isExpanded = [];

  @override
  void initState() {
    super.initState();
    _isExpanded.addAll(List.generate(widget.faqItems.length, (index) => false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frequently Asked Questions', style: TextStyle(color: Colors.black87)),
        backgroundColor: AppColors.background,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: widget.faqItems.length,
        separatorBuilder: (BuildContext context, int index) => Divider(color: AppColors.container.withOpacity(0.5), thickness: 1, indent: 20, endIndent: 20),
        itemBuilder: (BuildContext context, int index) {
          final faqItem = widget.faqItems[index];
          return Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              key: PageStorageKey<faq.FAQItem>(faqItem),
              title: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: _isExpanded[index] ? AppColors.container.withOpacity(0.3) : AppColors.coral.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  faqItem.question,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.darkText),
                ),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_down, // Using a question mark icon
                color: AppColors.blue,
              ),
              initiallyExpanded: _isExpanded[index],
              onExpansionChanged: (bool expanded) {
                setState(() {
                  _isExpanded[index] = expanded;
                });
              },
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(faqItem.answer, style: const TextStyle(fontSize: 14, color: AppColors.darkText)),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
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
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
