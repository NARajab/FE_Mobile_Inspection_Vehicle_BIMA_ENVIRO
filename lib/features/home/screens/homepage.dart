import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:myapp/features/Setting/screens/setting.dart';
import 'package:myapp/features/history/screens/history.dart';
import 'package:myapp/features/home/screens/kkh.dart';
import 'package:myapp/features/home/screens/p2h/pph.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePageContent(),
    const HistoryScreen(),
    const SettingScreen(),
    // Container()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: Image.asset('assets/images/appbar.png', height: 35),
            automaticallyImplyLeading: false,
            toolbarHeight: 35,
            actions: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              iconSize: 30,
              color: Colors.black,
              onPressed: () {
                // Aksi ketika ikon notifikasi diklik
              },
            ),
          ],
          ),
        ),
      ),
      body:_pages[_currentIndex],
      bottomNavigationBar: FlashyTabBar(
          selectedIndex: _currentIndex,
          showElevation: true,
          height: 55,
          backgroundColor: Colors.white,
          onItemSelected: (index) => setState(() {
            _currentIndex = index;
            
          }),
          items: [
              FlashyTabBarItem(
                icon: const Icon(Icons.dashboard),
                title: const Text('Dashboard'),
                activeColor: Colors.blue,
                inactiveColor: Colors.grey,
              ),
              FlashyTabBarItem(
                icon: const Icon(Icons.history),
                title: const Text('History'),
                activeColor: Colors.blue,
                inactiveColor: Colors.grey
              ),
              FlashyTabBarItem(
                icon: const Icon(Icons.settings),
                title: const Text('Settings'),
                activeColor: Colors.blue,
                inactiveColor: Colors.grey
              ),
            ],
      ),
    );
  }
}

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // Initialize date formatting for 'id_ID' locale
    initializeDateFormatting('id_ID');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(),
          _buildWidgetOptions(context),
          _buildSubmissionList(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    String formattedDate = DateFormat('EEEE, d MMMM y', 'id_ID').format(DateTime.now());

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0, top: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1.0,
                    initialPage: _currentPage,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                  items: [
                    'assets/images/header_image1.png',
                    'assets/images/header_image2.jpg',
                    'assets/images/header_image3.png',
                  ].map((imagePath) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCounter('Total Submisi P2H Saat Ini', '100 KALI'),
                _buildCounter('Total Submisi KKH Saat Ini', '100 KALI'),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }

  Widget _buildCounter(String title, String count) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.black54,
          ),
        ),
        Text(
          count,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildWidgetOptions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildOptionCard(context, 'P2H', Icons.settings),
          _buildOptionCard(context, 'KKH', Icons.work),
        ],
      ),
    );
  }

  Widget _buildOptionCard(BuildContext context, String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        if (title == 'P2H') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => p2hScreen()),
          );
        } else if (title == 'KKH') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const KkhScreen()),
          );
        }
      },
      child: Card(
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(0.5),
        child: Container(
          width: 170,
          height: 170,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                color: title == 'P2H' ? Colors.green : Colors.blue,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmissionList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Submission Terakhir',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          _buildSubmissionItem('P2H Submission Data', '2 April 2024', Icons.settings, Colors.green),
          _buildSubmissionItem('KKH Submission Data', '2 April 2024', Icons.work, Colors.blue),
        ],
      ),
    );
  }

  Widget _buildSubmissionItem(String title, String subtitle, IconData icon, Color iconColor) {
    return Card(
      elevation: 4,
      shadowColor: Colors.grey.withOpacity(0.7),
      child: ListTile(
        leading: Icon(icon, size: 35, color: iconColor),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
