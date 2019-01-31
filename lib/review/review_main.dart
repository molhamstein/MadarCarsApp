import 'package:flutter/material.dart';
import 'package:madar_booking/review/review_bloc.dart';

class ReviewMain extends StatefulWidget {
  @override
  ReviewMainState createState() {
    return new ReviewMainState();
  }
}

class ReviewMainState extends State<ReviewMain> {
  PageController pageController;
  Animatable<Color> background;
  ReviewBloc bloc;

  @override
  void initState() {
    bloc = ReviewBloc();
    _initialize();
    super.initState();
  }

  void _initialize() {
    background = TweenSequence<Color>([
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.red,
          end: Colors.orange,
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.orange,
          end: Colors.yellow,
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.yellow,
          end: Colors.greenAccent,
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.greenAccent,
          end: Colors.green,
        ),
      ),
    ]);
    pageController = PageController();
    pageController.addListener((){
      bloc.pushIndex(pageController.page);
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

                      if(pageController.hasClients) {
                        print(pageController.page);
                      }

                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: background
                              .evaluate(AlwaysStoppedAnimation(snapshot.data / 4)),
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 60.0),
                    child: Material(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () => pageController.animateToPage(0, duration: duration, curve: Curves.linear),
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
                            onTap: () => pageController.animateToPage(1, duration: duration, curve: Curves.linear),
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
                            onTap: () => pageController.animateToPage(2, duration: duration, curve: Curves.linear),
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
                            onTap: () => pageController.animateToPage(3, duration: duration, curve: Curves.linear),
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
                            onTap: () {
                              print('asdasdads');
                            },
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
