import 'package:flutter/material.dart';
import '../models/onboarding_page.dart';
import 'auth/welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'QueueMate',
      description: 'Skip the wait. Queue smart.',
      icon: Icons.groups,
      color: Color(0xFF5B5FC7),
      isFirst: true,
    ),
    OnboardingPage(
      title: 'Skip the wait.\nQueue smart.',
      description: 'Join queues remotely & save your time',
      icon: Icons.access_time,
      color: Color(0xFF5B5FC7),
      isFirst: false,
    ),
    OnboardingPage(
      title: 'Real-time\nQueue Updates',
      description: 'Track your position and get notified instantly',
      icon: Icons.notifications_active,
      color: Color(0xFFFDB94E),
      isFirst: false,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        ),
      );
    }
  }

  void _skip() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const WelcomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentPage > 0)
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    )
                  else
                    const SizedBox(width: 48),
                  if (_currentPage < _pages.length - 1)
                    TextButton(
                      onPressed: _skip,
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                    )
                  else
                    const SizedBox(width: 48),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(_pages[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => _buildDot(index),
                    ),
                  ),
                  const SizedBox(height: 32),
                  if (_currentPage == _pages.length - 1)
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF5B5FC7),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  else
                    GestureDetector(
                      onTap: _nextPage,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Next',
                            style: TextStyle(
                              color: Color(0xFF5B5FC7),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward,
                            color: Color(0xFF5B5FC7),
                            size: 20,
                          ),
                        ],
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

  Widget _buildPage(OnboardingPage page) {
    if (page.isFirst) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.groups,
              size: 80,
              color: Colors.grey[800],
            ),
            const SizedBox(height: 24),
            Text(
              page.title,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              page.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_currentPage == 1)
            Container(
              width: 280,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1556740758-90de374c12ad?w=400',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            )
          else
            Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                color: page.color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                page.icon,
                size: 100,
                color: Colors.white,
              ),
            ),
          const SizedBox(height: 64),
          Text(
            page.title,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            page.description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: _currentPage == index ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? _pages[_currentPage].color
            : Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
