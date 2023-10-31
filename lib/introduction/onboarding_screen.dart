import 'package:flutter/material.dart';
import 'onboard_content.dart';
import 'size_config.dart';
import 'package:pkl_demeter_mobile/auth/screens/login_page.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  late PageController _pageController;

// Initializing Page once Widget tree is built.
  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

// The initial default value of current page.
  int currentPage = 0;

// Listing colors for each page.
  List colors = const [
    Color(0xffDAD3C8),
    Color(0xffFFE5DE),
    Color(0xffDCF6E6),
  ];

// Animation for Container, holding index as paremeter then returning AnimatedContainer.
  AnimatedContainer _buildDots({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Color(0xFF000000)),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: currentPage == index ? 10 : 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    DataScreenConfig().init(context);
    double? width = DataScreenConfig.screenW;
    double? height = DataScreenConfig.screenH;

    return Scaffold(
      backgroundColor: colors[currentPage],
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Expanded(
              flex: 3,
              child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: contents.length,
                  onPageChanged: (value) => setState(() {
                        currentPage = value;
                      }),
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            contents[index].image,
                            height: DataScreenConfig.blockV! * 35,
                          ),
                          SizedBox(
                            height: (height! >= 840) ? 60 : 30,
                          ),
                          Text(
                            contents[index].title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: (width! <= 550) ? 30 : 35),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            contents[index].desc,
                            style: TextStyle(
                                fontFamily: "MontSerrat",
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: (width <= 550) ? 17 : 25),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    );
                  })),
          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(contents.length,
                        (int index) => _buildDots(index: index)),
                  ),
                  currentPage + 1 == contents.length
                      ? Padding(
                          padding: const EdgeInsets.all(30),
                          child: ElevatedButton(
                            onPressed: () {
                              final navigator = Navigator.of(context);
                              navigator.pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                  (route) => false);
                            },
                            child: Text("BEGIN"),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: (width! <= 550)
                                    ? const EdgeInsets.symmetric(
                                        horizontal: 35, vertical: 20)
                                    : EdgeInsets.symmetric(
                                        horizontal: width * 0.2, vertical: 20),
                                textStyle: TextStyle(
                                    fontSize: (width <= 550) ? 13 : 17)),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(30),
                          child: Row(children: [
                            TextButton(
                              onPressed: () {
                                _pageController.jumpTo(3);
                              },
                              child: Text(
                                "SKIP",
                                style: TextStyle(color: Colors.black),
                              ),
                              style: TextButton.styleFrom(
                                  elevation: 0,
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: (width! <= 550) ? 13 : 17)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn,
                                );
                              },
                              child: const Text("NEXT"),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  elevation: 0,
                                  padding: (width <= 550)
                                      ? const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 20)
                                      : const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 25),
                                  textStyle: TextStyle(
                                      fontSize: (width <= 550) ? 13 : 17)),
                            ),
                          ]),
                        ),
                ],
              )),
        ],
      )),
    );
  }
}
