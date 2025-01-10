import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'filter.dart';

void main() => runApp(TrainingApp());

class TrainingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trainings',
      theme: ThemeData(primaryColor: Colors.red, fontFamily: 'Arial'),
      home: TrainingsPage(),
    );
  }
}

class TrainingsPage extends StatefulWidget {
  @override
  _TrainingsPageState createState() => _TrainingsPageState();
}

class _TrainingsPageState extends State<TrainingsPage> {
  final CarouselSliderController _controller = CarouselSliderController();

  int _currentIndex = 0;

  List<Map<String, String>> filteredHighlights = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredHighlights = highlights; // Initialize with the full list
  }

  void updateSearchQuery(String query) {
    setState(() {
      print("query $query");
      searchQuery = query;
      filteredHighlights = highlights
          .where((highlight) => highlight['title']!
              .toLowerCase()
              .contains(searchQuery.toLowerCase()))
          .toList();
    });
  }

  final List<Map<String, String>> highlights = [
    {
      'title': 'Safe Scrum Master',
      'location': 'West Des Moines,',
      'image': 'assets/images/a.jpg',
      'price': '\$825',
      'originalPrice': '\$975',
      'date': 'Oct 11 - 13, 2019',
      'time': '08:30 - 12:30 pm',
      'tag': 'Filling Fast!',
      'speakerTitle': 'Keynote Speaker',
      'speaker': 'Helen Gribble',
    },
    {
      'title': 'Agile Coach Mastery',
      'location': 'Online - 5 Nov',
      'image': 'assets/images/b.jpg',
      'price': '\$725',
      'originalPrice': '\$850',
      'date': 'Oct 15 - 19, 2019',
      'time': '09:30 - 11:30 pm',
      'tag': 'Filling Fast!',
      'speakerTitle': 'Keynote Speaker',
      'speaker': 'Helen Gribble',
    },
    {
      'title': 'Project Management',
      'location': 'Online ',
      'image': 'assets/images/b.jpg',
      'price': '\$725',
      'originalPrice': '\$850',
      'date': 'Oct 13 - 15, 2019',
      'time': '06:30 - 12:30 pm',
      'tag': 'Filling Fast!',
      'speakerTitle': 'Keynote Speaker',
      'speaker': 'John Depp',
    }
  ];

  // Apply filters based on the selected checkboxes
  void applyFilters(List<String> selectedLocations,
      List<String> selectedSpeakerTitles, List<String> selectedSpeakers) {
    setState(() {
      filteredHighlights = highlights.where((highlight) {
        bool matchesLocation = selectedLocations.isEmpty ||
            selectedLocations.contains(highlight['location']);
        bool matchesSpeakerTitle = selectedSpeakerTitles.isEmpty ||
            selectedSpeakerTitles.contains(highlight['speakerTitle']);
        bool matchesSpeaker = selectedSpeakers.isEmpty ||
            selectedSpeakers.contains(highlight['speaker']);
        return matchesLocation && matchesSpeakerTitle && matchesSpeaker;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Trainings',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 165,
                      color: Colors.red,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Highlights',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Left Navigation Button
                            GestureDetector(
                              onTap: () => _controller.previousPage(),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 20.0),
                                child: Icon(Icons.keyboard_arrow_left,
                                    color: Colors.white),
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Stack(
                                children: [
                                  CarouselSlider(
                                    carouselController: _controller,
                                    items: highlights.map((item) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            child: Stack(
                                              children: [
                                                // Background image
                                                Stack(children: [
                                                  Image.asset(
                                                    item['image']!,
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Container(
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                    color: Colors.black
                                                        .withOpacity(0.6),
                                                  ),
                                                ]),
                                                Column(
                                                  children: [
                                                    Spacer(),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            item['title']!,
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .white, // Adjust text color for contrast
                                                            ),
                                                          ),
                                                          SizedBox(height: 4),
                                                          Text(
                                                            item['location']!,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white70),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    item[
                                                                        'originalPrice']!,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      decorationColor:
                                                                          Colors
                                                                              .red,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .lineThrough,
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          8.0),
                                                                  Text(
                                                                    item[
                                                                        'price']!,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child:
                                                                    TextButton(
                                                                  onPressed:
                                                                      () {},
                                                                  child: Text(
                                                                    'View Details ->',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .white70),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),
                                    options: CarouselOptions(
                                      height: 190,
                                      // Adjusted height for a smaller carousel
                                      enlargeCenterPage: false,
                                      viewportFraction: 1.0,
                                      enableInfiniteScroll: true,
                                      autoPlay: true,

                                      autoPlayInterval: Duration(seconds: 5),
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _currentIndex = index;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Spacer between the carousel and the right arrow
                            SizedBox(width: 8),

                            // Right Navigation Button
                            GestureDetector(
                              onTap: () => _controller.nextPage(),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(
                                      2.0), // Slightly rounded corners
                                ),
                                padding: EdgeInsets.symmetric(vertical: 20.0),
                                // Padding for the icon
                                child: Icon(Icons.keyboard_arrow_right,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          _showFilterDialog(context);
                        },
                        icon: Icon(Icons.tune, color: Colors.grey),
                        label: Text(
                          'Filter',
                          style: TextStyle(color: Colors.grey),
                        ),
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side:
                                BorderSide(color: Colors.grey), // Border color
                          ),
                          backgroundColor: Colors.white, // Background color
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Color(0xFFf2f2f2),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: highlights.length,
                  itemBuilder: (context, index) {
                    final highlight = highlights[index];
                    return highlight != null
                        ? TrainingCard(
                            date: highlight['date']!,
                            time: highlight['time']!,
                            location: highlight['location']!,
                            title: highlight['title']!,
                            tag: highlight['tag']!,
                            price: highlight['price']!,
                            speakerTitle: highlight['speakerTitle']!,
                            speaker: highlight['speaker']!,
                            onEnrollPressed: () {},
                          )
                        : SizedBox();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FilterDialog(
          highlights: highlights,
          updateSearchQuery: (query) {
            setState(() {
              searchQuery = query;
              // Logic for updating the list based on the search query
            });
          },
        );
      },
    );
  }
}

class TrainingCard extends StatelessWidget {
  final String date;
  final String time;
  final String location;
  final String title;
  final String tag;
  final String price;
  final String speaker;
  final String speakerTitle;
  final VoidCallback onEnrollPressed;

  TrainingCard({
    required this.date,
    required this.time,
    required this.location,
    required this.title,
    required this.tag,
    required this.price,
    required this.speaker,
    required this.speakerTitle,
    required this.onEnrollPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.only(top: 20),
        color: Colors.white,
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Left section
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      date,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 22),
                    Text(
                      location,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              // Divider

              CustomPaint(
                size: Size(1, 130), // Width of the line is 1, height is 80
                painter: DashedLinePainter(),
              ),
              // Right section
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tag,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 16,
                            backgroundImage: AssetImage(
                                'assets/images/c.jpg'), // Add your image here
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                speakerTitle,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                speaker,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Spacer(),
                          Container(
                            margin: EdgeInsets.only(left: 16.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red, // Button color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                              ),
                              child: Text(
                                "Enrol Now",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Enroll Now Button
            ],
          ),
        ),
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[400]!
      ..strokeWidth = size.width
      ..style = PaintingStyle.stroke;

    double startY = 0;
    const double dashHeight = 5; // Height of each dash
    const double spaceHeight = 3; // Space between dashes

    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashHeight),
        paint,
      );
      startY += dashHeight + spaceHeight;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
