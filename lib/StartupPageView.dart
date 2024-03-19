import 'package:flutter/material.dart';
import 'package:exploro/loginPage.dart';
import 'page_route.dart';


class StartupPageView extends StatefulWidget {
  const StartupPageView({Key? key}) : super(key: key);

  @override
  State<StartupPageView> createState() => _StartupPageViewState();
}

class _StartupPageViewState extends State<StartupPageView> {
  final PageController _pageController = PageController(initialPage: 0);
  int activePage = 0;
  List<StartupCard> _startupCard = [
    StartupCard(
        imageUrl: "images/plumber.jpg",
        description: "Welcome to At Snap!"
            "Find services, and get your work done."),
    StartupCard(
        imageUrl: "images/mechanic.jpg",
        description:
            "Save time and money"),
    StartupCard(
        imageUrl: "images/electrician.jpg",
        description:
            "Get started"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 150,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  activePage = page;
                });
              },
              itemCount: _startupCard.length,
              itemBuilder: (BuildContext context, int index) {
                return _startupCard[index % _startupCard.length];
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(
                _startupCard.length,
                (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          _pageController.animateToPage(index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                        child: CircleAvatar(
                            radius: 6,
                            backgroundColor: activePage == index
                                ? Color(0xffFEBD2F)
                                : Colors.black.withOpacity(0.1)),
                      ),
                    )),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 50, 0, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                      40, 0, 40, 10), // Adjust horizontal margin as needed
                  child: ElevatedButton(
                    onPressed: () {
                      activePage == 2
                          ? Navigator.of(context).pushReplacement(
                              HorizontalSlideRoute(
                                builder: (_, __, ___) {
                                  return const LoginPage();
                                },
                              ),
                            )
                          : _pageController.animateToPage(
                              activePage + 1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 0),
                    ),
                    child: Text(activePage == 2 ? "Get Started" : 'Next', style: TextStyle(
                      fontFamily: "ColabRegular",
                      color: Colors.white,
                      fontSize: 18
                    ),),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class StartupCard extends StatelessWidget {
  final String imageUrl;
  final String description;
  StartupCard({Key? key, required this.imageUrl, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset("images/Rectangle.png", fit: BoxFit.fill),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(100, 80, 0, 0),
                child: Image.asset(imageUrl, fit: BoxFit.fill),
              ),
            ],
          ),
        )), // Full-screen ad at the top

        SizedBox(height: 40), // Adjust spacing as needed
        Expanded(
          child: Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(70, 0, 70, 0),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontFamily: "ColabRegular"),
                maxLines: 5,
              ),
            ),
          ), // Full-screen ad in the middle
        ),

        // Full-screen ad at the bottom
      ],
    );
  }
}
