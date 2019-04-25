import 'package:flutter/material.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/feedback.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/review/rating_value.dart';
import 'package:madar_booking/review/review_bloc.dart';

class ReviewMain extends StatefulWidget {
  final carId;
  final tripId;

  const ReviewMain({Key key, this.carId, this.tripId})
      : assert(carId != null),
        assert(tripId != null),
        super(key: key);

  @override
  ReviewMainState createState() {
    return new ReviewMainState();
  }
}

class ReviewMainState extends State<ReviewMain>
    with TickerProviderStateMixin, UserFeedback {
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
    bloc = ReviewBloc(
        widget.carId, widget.tripId, BlocProvider.of<AppBloc>(context).token);
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
          begin: Colors.yellow[500],
          end: Colors.lightGreen[700],
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.lightGreen[700],
          end: Colors.lightGreen[800],
        ),
      ),
    ]);
    pageController = PageController();
    badController.forward();
    okController.reverse();
    greatController.reverse();
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

  @override
  Widget build(BuildContext context) {
    final duration = Duration(milliseconds: 200);

    return Scaffold(
        body: StreamBuilder<double>(
            stream: bloc.indexStream,
            initialData: 0,
            builder: (context, snapshot) {
              return StreamBuilder<bool>(
                  stream: bloc.submitStream,
                  builder: (context, submitSnapshot) {
                    if (submitSnapshot.hasData) {
                      if (submitSnapshot.data) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          showInSnackBar('after_rate_msg', context);
                          Navigator.of(context).pop();
                        });
                      } else {}
                    }

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
                                    child: Image.asset(
                                        'assets/images/bad_face.png')),
                                FadeTransition(
                                    opacity: okFace,
                                    child: Image.asset(
                                        'assets/images/ok_face.png')),
                                FadeTransition(
                                    opacity: greatFace,
                                    child: Image.asset(
                                        'assets/images/great_face.png')),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 80.0),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              MadarLocalizations.of(context)
                                  .trans('review_text'),
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
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
                                RatingValue(
                                  value: 1,
                                  onTap: (value) {
                                    pageController.animateToPage(value - 1,
                                        duration: duration,
                                        curve: Curves.linear);
                                  },
                                  selected: snapshot.data.toInt() == 0,
                                ),
                                RatingValue(
                                  value: 2,
                                  onTap: (value) {
                                    pageController.animateToPage(value - 1,
                                        duration: duration,
                                        curve: Curves.linear);
                                  },
                                  selected: snapshot.data.toInt() == 1,
                                ),
                                RatingValue(
                                  value: 3,
                                  onTap: (value) {
                                    pageController.animateToPage(value - 1,
                                        duration: duration,
                                        curve: Curves.linear);
                                  },
                                  selected: snapshot.data.toInt() == 2,
                                ),
                                RatingValue(
                                  value: 4,
                                  onTap: (value) {
                                    pageController.animateToPage(value - 1,
                                        duration: duration,
                                        curve: Curves.linear);
                                  },
                                  selected: snapshot.data.toInt() == 3,
                                ),
                                RatingValue(
                                  value: 5,
                                  onTap: (value) {
                                    pageController.animateToPage(value - 1,
                                        duration: duration,
                                        curve: Curves.linear);
                                  },
                                  selected: snapshot.data.toInt() == 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FlatButton(
                            onPressed: () {
                              bloc.submit();
                            },
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  });
            }));
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
