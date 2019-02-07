import 'package:flutter/material.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/review/expressions.dart';
import 'package:madar_booking/review/review_bloc.dart';

class ReviewMain extends StatefulWidget {
  @override
  ReviewMainState createState() {
    return new ReviewMainState();
  }
}

class ReviewMainState extends State<ReviewMain> with TickerProviderStateMixin {
  PageController pageController;
  Animatable<Color> background;
  ReviewBloc bloc;
  Animation<double> badFace;
  Animation<double> okFace;
  Animation<double> greatFace;
  AnimationController badController;
  AnimationController okController;
  AnimationController greatController;

  @override
  void initState() {
    bloc = ReviewBloc();
    _initialize();
    super.initState();
  }

  void _initialize() {
    badController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
    okController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
    greatController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );

    badFace = Tween(begin: 0.0, end: 1.0).animate(badController);
    okFace = Tween(begin: 0.0, end: 1.0).animate(okController);
    greatFace = Tween(begin: 0.0, end: 1.0).animate(greatController);

    background = TweenSequence<Color>([
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.red[400],
          end: Colors.orange,
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.orange,
          end: Colors.yellow[700],
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.yellow[700],
          end: Colors.teal[300],
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.teal[300],
          end: Colors.teal[400],
        ),
      ),
    ]);
    pageController = PageController();
    if (pageController.page == 0) {
      badController.forward();
      okController.reverse();
      greatController.reverse();
    }
    pageController.addListener(() {
      bloc.pushIndex(pageController.page);

      if (pageController.page <= 1) {
        badController.forward();
        okController.reverse();
        greatController.reverse();
      }
      if (pageController.page < 3 && pageController.page >= 2) {
        badController.reverse();
        okController.forward();
        greatController.reverse();
      }
      if (pageController.page >= 3) {
        badController.reverse();
        okController.reverse();
        greatController.forward();
      }
    });
  }

//  @override
//  void reassemble() {
//    pageController.dispose();
//    _initialize();
//    super.reassemble();
//  }

  @override
  Widget build(BuildContext context) {
    final duration = Duration(milliseconds: 200);

    return Scaffold(
        body: StreamBuilder<double>(
            stream: bloc.indexStream,
            initialData: 0,
            builder: (context, snapshot) {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[

                  AnimatedBuilder(
                    animation: pageController,
                    builder: (context, child) {
                      if (pageController.hasClients) {
                        print(pageController.page);
                      }

                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: background.evaluate(
                              AlwaysStoppedAnimation(snapshot.data / 5)),
                        ),
                        child: child,
                      );
                    },
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: pageController,
                      children: [
                        Center(child: Text("")),
                        Center(child: Text("")),
                        Center(child: Text("")),
                        Center(child: Text("")),
                        Center(child: Text("")),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.all(32),
                      alignment: Alignment.center,
                      child: Stack(
                        children: <Widget>[
                          FadeTransition(
                              opacity: badFace,
                              child: Image.asset('assets/images/bad_face.png')),
                          FadeTransition(
                              opacity: okFace,
                              child: Image.asset('assets/images/ok_face.png')),
                          FadeTransition(
                              opacity: greatFace,
                              child:
                                  Image.asset('assets/images/great_face.png')),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top:80.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        MadarLocalizations.of(context).trans('review_text'),
                        style: TextStyle(
                          fontSize: 22,
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 60.0),
                    child: Material(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () => pageController.animateToPage(0,
                                duration: duration, curve: Curves.linear),
                            splashColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                '1',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () => pageController.animateToPage(1,
                                duration: duration, curve: Curves.linear),
                            splashColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                '2',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () => pageController.animateToPage(2,
                                duration: duration, curve: Curves.linear),
                            splashColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                '3',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () => pageController.animateToPage(3,
                                duration: duration, curve: Curves.linear),
                            splashColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                '4',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () => pageController.animateToPage(4,
                                duration: duration, curve: Curves.linear),
                            splashColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                '5',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }));
  }
}
