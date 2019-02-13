import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madar_booking/MainButton.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/madar_colors.dart';
import 'package:madar_booking/main.dart';
import 'package:madar_booking/models/TripModel.dart';
import 'package:madar_booking/trip_planning/bloc/trip_planing_bloc.dart';
import 'package:madar_booking/trip_planning/final_step.dart';
import 'package:madar_booking/trip_planning/need_help_page.dart';
import 'package:madar_booking/trip_planning/step_choose_city.dart';
import 'package:madar_booking/trip_planning/step_choose_date_page.dart';
import 'package:madar_booking/trip_planning/step_choose_sub_city.dart';
import 'package:madar_booking/trip_planning/step_chosse_car.dart';
import 'package:madar_booking/trip_planning/step_trip_type.dart';
import 'package:madar_booking/feedback.dart';

class TripPlanningPage extends StatefulWidget {
  final TripModel tripModel;

  const TripPlanningPage({Key key, this.tripModel}) : super(key: key);

  @override
  TripPlanningPageState createState() {
    return new TripPlanningPageState();
  }
}

class TripPlanningPageState extends State<TripPlanningPage> with UserFeedback {
  final steps = [
    ChooseCityStep(),
    TripTypeStep(),
    StepChooseDatePage(),
    StepChooseCar(),
    StepChooseSubCity(),
    FinalStep(),
  ];

  TripPlaningBloc bloc;
  TextEditingController _noteController;

  @override
  void initState() {
    _noteController = TextEditingController();
    bloc = TripPlaningBloc(
      BlocProvider.of<AppBloc>(context).token,
      BlocProvider.of<AppBloc>(context).userId,
      tripModel: widget.tripModel,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: WillPopScope(
        onWillPop: () async {
          if (bloc.index == 0 || bloc.index == 5) {
            Navigator.of(context).pop();
            return false;
          } else {
            bloc.navBackward;
            return false;
          }
        },
        child: Scaffold(
            resizeToAvoidBottomPadding: false,
            backgroundColor: Colors.transparent,
            body: Builder(builder: (scaffoldContext) {
              return StreamBuilder<bool>(
                  stream: bloc.loadingStream,
                  initialData: false,
                  builder: (context, loadingSnapshot) {
                    return Scaffold(
                      resizeToAvoidBottomPadding: false,
                      body: StreamBuilder<String>(
                        stream: bloc.feedbackStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasError && bloc.showFeedback) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              showInSnackBar(snapshot.error, context,
                                  color: Colors.redAccent);
                              bloc.showFeedback = false;
                            });
                          }
                          if (snapshot.hasData && bloc.showFeedback) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              showInSnackBar(snapshot.data, context);
                              bloc.showFeedback = false;
                            });
                          }
                          return Stack(
                            children: <Widget>[
                              Hero(
                                tag: "header_container",
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient:
                                          MadarColors.gradiant_decoration),
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                // decoration: BoxDecoration(
                                //     gradient: MadarColors.gradiant_decoration),
                                child: StreamBuilder<int>(
                                    stream: bloc.navigationStream,
                                    initialData: 0,
                                    builder: (context, snapshot) {
                                      return Scaffold(
                                          backgroundColor: Colors.transparent,
                                          appBar: AppBar(
                                            iconTheme: IconThemeData(
                                                color: Colors.black87),
                                            backgroundColor: Colors.transparent,
                                            centerTitle: true,
                                            elevation: 0,
                                            title: Text(
                                              title(snapshot.data),
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            actions: <Widget>[
                                              IconButton(
                                                icon: Icon(
                                                    FontAwesomeIcons.filter),
                                                onPressed: () {
                                                  showModal(scaffoldContext);
                                                },
                                              )
                                            ],
                                          ),
                                          body: steps[snapshot.data]);
                                    }),
                              ),
                              StreamBuilder<bool>(
                                  stream: bloc.helpStream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData && snapshot.data)
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    NeedHelpPage()));
                                      });
                                    return Container();
                                  }),
                            ],
                          );
                        },
                      ),
                      floatingActionButton: StreamBuilder<String>(
                        stream: bloc.changeTextStream,
                        initialData: 'next',
                        builder: (context, snapshot) {
                          return StreamBuilder<bool>(
                              stream: bloc.noteButtonStream,
                              builder: (context, noteSnapshot) {
                                return Hero(
                                  tag: 'tripButton',
                                  child: MainButton(
                                    width: isScreenLongEnough ? 150 : 120,
                                    height: isScreenLongEnough ? 50 : 40,
                                    miniButton: noteSnapshot.hasData &&
                                        noteSnapshot.data,
                                    text: MadarLocalizations.of(context)
                                        .trans(snapshot.data),
                                    loading: loadingSnapshot.data,
                                    onPressed: () {
                                      if (bloc.index == 5) {
                                        Navigator.of(context).pop();
                                      } else if (bloc.done) {
                                        bloc.submitTrip();
                                      } else
                                        bloc.navForward;
                                    },
                                    onMiniBtnPressed: () =>
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              padding: EdgeInsets.all(16),
                                              color: Colors.white,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(
                                                                context)
                                                            .viewInsets
                                                            .bottom),
                                                    child: TextField(
                                                      controller:
                                                          _noteController,
                                                      onSubmitted: (s) {
                                                        bloc.trip.note = s;
                                                        Navigator.pop(context);
                                                      },
                                                      autofocus: true,
                                                      decoration:
                                                          InputDecoration(
                                                        hasFloatingPlaceholder:
                                                            true,
                                                        hintText:
                                                            MadarLocalizations
                                                                    .of(context)
                                                                .trans(
                                                                    'your_note'),
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                  ),
                                );
                              });
                        },
                      ),
                    );
                  });
            })),
      ),
    );
  }

  title(i) {
    if (i == 0) {
      return MadarLocalizations.of(context).trans('choose_city');
    } else if (i == 1) {
      return MadarLocalizations.of(context).trans('choose_type');
    } else if (i == 2) {
      return MadarLocalizations.of(context).trans('choose_date');
    } else if (i == 3) {
      return MadarLocalizations.of(context).trans('choose_car');
    } else if (i == 4) {
      return MadarLocalizations.of(context).trans('extend_your_trip');
    } else {
      return '';
    }
  }

  showModal(context) {
    final titleStyle = TextStyle(
      color: MadarColors.gradientDown,
      fontWeight: FontWeight.w600,
    );

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(right: 16, left: 16),
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.only(top: 30, left: 16, right: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Filters',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Show VIP cars only',
                          style: titleStyle,
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16, bottom: 16),
                      child: StreamBuilder<Object>(
                        stream: bloc.carTypeStream,
                        builder: (context, snapshot) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SquareFilterButton(
                                child: Text(
                                  'VIP cars',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      height: 0.8),
                                ),
                                selected: snapshot.data == Type.vip,
                                onTap: () {
                                  bloc.selectCarType(Type.vip);
                                },
                              ),
                              Container(
                                width: 8,
                              ),
                              SquareFilterButton(
                                child: Text(
                                  'All cars',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      height: 0.8),
                                ),
                                selected: snapshot.data == Type.normal,
                                onTap: () {
                                  bloc.selectCarType(Type.normal);
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Text(
                          'Number of seats',
                          style: titleStyle,
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      margin: EdgeInsets.only(top: 16, bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RoundFilterButton(
                            child: Icon(
                              FontAwesomeIcons.plus,
                              color: Colors.white,
                              size: 16,
                            ),
                            onTap: (){
                              bloc.plusSeat();
                            },
                          ),
                          StreamBuilder(
                            stream: bloc.numberOfSeatsStream,
                            initialData: '-',
                            builder: (context, snapshot) {
                              return Text(
                                snapshot.data.toString(),
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w800,
                                ),
                              );
                            }
                          ),
                          RoundFilterButton(
                            child: Icon(
                              FontAwesomeIcons.minus,
                              color: Colors.white,
                              size: 16,
                            ),
                            onTap: () {
                              bloc.minusSeat();
                            },
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Text(
                          'Driver gender',
                          style: titleStyle,
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      margin: EdgeInsets.only(top: 16, bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GenderFilterButton(
                            child: Icon(
                              FontAwesomeIcons.male,
                              color: Colors.white,
                              size: 20,
                            ),
                            padding: 16,
                          ),
                          GenderFilterButton(
                            child: Icon(
                              FontAwesomeIcons.female,
                              color: Colors.white,
                              size: 20,
                            ),
                            padding: 16,
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Text(
                          'Driver language',
                          style: titleStyle,
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16, bottom: 16),
                      child: Row(
                        children: <Widget>[
                          FilterChip(label: Text('Arabic'), onSelected: (_) {}),
                          FilterChip(
                              label: Text('English'), onSelected: (_) {}),
                          FilterChip(
                              label: Text('Turkish'), onSelected: (_) {}),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class RoundFilterButton extends StatelessWidget {
  final Widget child;
  final Function onTap;
  final double padding;

  const RoundFilterButton({Key key, this.child, this.onTap, this.padding = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: Colors.black87,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 16,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

class GenderFilterButton extends StatefulWidget {
  final Widget child;
  final Function(bool) onTap;
  final double padding;
  final bool selected;

  const GenderFilterButton({Key key, this.child, this.onTap, this.padding = 10, this.selected = false})
      : super(key: key);

  @override
  _GenderFilterButtonState createState() => _GenderFilterButtonState();
}

class _GenderFilterButtonState extends State<GenderFilterButton> {

  bool selected;

  @override
  void initState() {
    selected = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
          if(widget.onTap != null) {
            widget.onTap(selected);
          }
        });
      },
      child: selected ? Container(
        padding: EdgeInsets.all(widget.padding),
        decoration: BoxDecoration(
          color: Colors.black87,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 16,
            ),
          ],
        ),
        child: widget.child,
      ) : Container(
        padding: EdgeInsets.all(widget.padding),
        decoration: BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
        child: widget.child,
      ),
    );
  }
}

class SquareFilterButton extends StatefulWidget {
  final Widget child;
  final Function() onTap;
  final double padding;
  final bool selected;

  const SquareFilterButton(
      {Key key,
      this.child,
      this.onTap,
      this.padding = 10,
      this.selected = false})
      : super(key: key);

  @override
  _SquareFilterButtonState createState() => _SquareFilterButtonState();
}

class _SquareFilterButtonState extends State<SquareFilterButton> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          setState(() {
            if (widget.onTap != null) widget.onTap();
          });
        },
        child: widget.selected
            ? Container(
                padding: EdgeInsets.all(widget.padding),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: widget.child,
              )
            : Container(
                padding: EdgeInsets.all(widget.padding),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: widget.child,
              ),
      ),
    );
  }
}
