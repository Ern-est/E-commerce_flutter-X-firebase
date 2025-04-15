import 'package:flutter/material.dart';
import 'package:mara_pub/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<String> imagePaths = [
    'lib/images/onboarding/bartender_dark_skinn.png',
    'lib/images/onboarding/fruit_mojito.png',
    'lib/images/onboarding/fancy_drink_1.png',
  ];

  final List<String> titles = [
    'Meet Your Personal Bartender',
    'Crafted Just for You',
    'Sip the Freshness',
    'Raise the Bar with Every Order',
  ];

  final List<String> descriptions = [
    'Discover expertly crafted cocktails made by our skilled bartenders, ready to serve your cravings.',
    'Select your perfect drink from a curated menu based on your taste and vibe.',
    'Enjoy freshly mixed fruit mojitos and more, all delivered with care.',
    'Top-shelf spirits and fast service – experience premium ordering like never before.',
  ];

  void _nextPage() {
    if (_currentIndex < imagePaths.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  Widget _buildDotIndicator(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: _currentIndex == index ? 16 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: _currentIndex == index ? Colors.orangeAccent : Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: imagePaths.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.asset(
                          imagePaths[index],
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        titles[index],
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12),
                      Text(
                        descriptions[index],
                        style: TextStyle(fontSize: 16, color: Colors.grey[300]),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    imagePaths.length,
                    _buildDotIndicator,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: _nextPage,
                  child: Text(
                    _currentIndex == imagePaths.length - 1
                        ? 'Get Started'
                        : 'Next',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
