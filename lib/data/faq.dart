
class FAQItem {
  final String question;
  final String answer;

  const FAQItem({required this.question, required this.answer});
}

final List<FAQItem> faqItems = [
  FAQItem(
    question: 'What types of plays do you offer?',
    answer: 'We offer a wide variety of plays, including musicals, dramas, comedies, and experimental theatre.',
  ),
  FAQItem(
    question: 'How can I book tickets?',
    answer: 'You can book tickets through our website or directly at the theatre box office during opening hours.',
  ),
  FAQItem(
    question: 'What payment methods do you accept?',
    answer: 'We accept major credit cards (Visa, Mastercard, American Express) and debit cards. Online payments are processed securely.',
  ),
  FAQItem(
    question: 'Can I cancel or exchange my tickets?',
    answer: 'Our cancellation and exchange policy varies depending on the production and the time before the performance. Please refer to our terms and conditions or contact our customer service for specific details.',
  ),
  FAQItem(
    question: 'Is the theatre accessible for people with disabilities?',
    answer: 'Yes, our theatre is equipped with facilities to accommodate guests with disabilities. Please contact us in advance to arrange any necessary assistance.',
  ),
  FAQItem(
    question: 'Are there any age restrictions for performances?',
    answer: 'Age restrictions vary by production. Please check the specific play\'s information page for details on age limits or recommendations.',
  ),
  FAQItem(
    question: 'How early should I arrive for a performance?',
    answer: 'We recommend arriving at least 30 minutes before the scheduled start time to allow for seating and any potential delays.',
  ),
  // Add more FAQ items here
];