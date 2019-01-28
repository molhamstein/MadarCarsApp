import 'package:flutter/material.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/app_text_style.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:madar_booking/madar_colors.dart';
import 'package:madar_booking/models/Invoice.dart';
import 'package:madar_booking/models/MyTrip.dart';
import 'package:madar_booking/profile_bloc.dart';
import 'madar_fonts.dart';

class InvoicePage extends StatefulWidget {
  final MyTrip trip;
  InvoicePage({Key key, this.title, this.trip}) : super(key: key);
  final String title;

  @override
  _InvoicePageState createState() => _InvoicePageState(trip);
}

class _InvoicePageState extends State<InvoicePage> {
  ProfileBloc profileBloc;
  static AppBloc appBloc;
  static final token = appBloc.token;
  final MyTrip trip;
  _InvoicePageState(this.trip);

  @override
  initState() {
    appBloc = BlocProvider.of<AppBloc>(context);
    profileBloc = ProfileBloc(token);
    profileBloc.invoice(trip.id);
    super.initState();
  }

  Widget costWidget(String cost) {
    return Container(
        height: 100,
        child: Row(
          children: <Widget>[
            Expanded(
              // estim cost container
              child: Container(
                alignment: Alignment(0, 0),
                child: Text(MadarLocalizations.of(context).trans('total_cost'),
                    style: AppTextStyle.normalTextStyleBlack),
              ),
            ),
            Expanded(
              // cost container
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          textAlign: TextAlign.end,
                          text: TextSpan(
                              text: cost,
                              style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 65,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            alignment: Alignment(0, -1),
                            height: 75,
                            width: 20,
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                  text: "\$",
                                  style: TextStyle(
                                      color: Colors.grey.shade900,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  getInvoice() {
    return StreamBuilder<Invoice>(
      stream: profileBloc.invoiceStream,
      builder: (context, snapshot) {
        print(snapshot.data);
        if (snapshot.hasData) {
          return Table(
            columnWidths: {
              1: FractionColumnWidth(.2),
              2: FractionColumnWidth(.2),
              3: FractionColumnWidth(.2),
              4: FractionColumnWidth(.2)
            },
            children: snapshot.data.bills
                .map(
                  (bill) => TableRow(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                '${bill.titleEn}',
                                style: TextStyle(
                                    fontSize: AppFonts.medium_font_size,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )),
                          Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                '${bill.pricePerUnit}',
                                style: TextStyle(
                                    fontSize: AppFonts.medium_font_size,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )),
                          Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                '${bill.quantity}',
                                style: TextStyle(
                                    fontSize: AppFonts.medium_font_size,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )),
                          Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                '${bill.totalPrice}',
                                style: TextStyle(
                                    fontSize: AppFonts.medium_font_size,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                )
                .toList(),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: profileBloc,
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                color: Colors.grey.shade200,
                height: 190,
              ),
              Expanded(
                child: Container(color: Colors.grey.shade200),
              ),
            ],
          ),
          //  ProfileHeader(),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Center(
                                child: Text(
                                  MadarLocalizations.of(context)
                                      .trans('invoice'),
                                  style: TextStyle(
                                      fontSize: AppFonts.large_font_size,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: ListTile(
                                  title: Text(
                                    trip.car.brand.name(
                                        MadarLocalizations.of(context).locale),
                                    style: AppTextStyle.largeTextStyleBlack,
                                  ),
                                  subtitle: Text(
                                    trip.location.name(
                                        MadarLocalizations.of(context).locale),
                                    style: TextStyle(
                                        fontSize: AppFonts.medium_font_size,
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: StreamBuilder<Invoice>(
                      stream: profileBloc.invoiceStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                width: 350,
                                decoration: BoxDecoration(
                                  boxShadow: [MadarColors.shadow],
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/invoice-01.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 16.0),
                                                child: ListTile(
                                                  title: Text(
                                                      MadarLocalizations.of(
                                                              context)
                                                          .trans('date'),
                                                      style: TextStyle(
                                                        fontSize: AppFonts
                                                            .medium_font_size,
                                                        color: Colors
                                                            .grey.shade600,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                  subtitle: Text(
                                                    trip.startDateFromated(),
                                                    style: TextStyle(
                                                      fontSize: AppFonts
                                                          .large_font_size,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 16.0),
                                                child: ListTile(
                                                  title: Text(
                                                      MadarLocalizations.of(
                                                              context)
                                                          .trans('invoice'),
                                                      style: TextStyle(
                                                        fontSize: AppFonts
                                                            .medium_font_size,
                                                        color: Colors
                                                            .grey.shade600,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                  subtitle: Text(
                                                    snapshot.data.id
                                                        .substring(17),
                                                    style: TextStyle(
                                                      fontSize: AppFonts
                                                          .large_font_size,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              child: Table(
                                                columnWidths: {
                                                  1: FractionColumnWidth(.2),
                                                  2: FractionColumnWidth(.2),
                                                  3: FractionColumnWidth(.2),
                                                  4: FractionColumnWidth(.2)
                                                },
                                                children: [
                                                  TableRow(children: [
                                                    Text(
                                                      MadarLocalizations.of(
                                                              context)
                                                          .trans('item'),
                                                      style: TextStyle(
                                                          fontSize: AppFonts
                                                              .small_font_size,
                                                          color: Colors
                                                              .grey.shade400,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      MadarLocalizations.of(
                                                              context)
                                                          .trans('price'),
                                                      style: TextStyle(
                                                          fontSize: AppFonts
                                                              .small_font_size,
                                                          color: Colors
                                                              .grey.shade400,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      MadarLocalizations.of(
                                                              context)
                                                          .trans('quantity'),
                                                      style: TextStyle(
                                                          fontSize: AppFonts
                                                              .small_font_size,
                                                          color: Colors
                                                              .grey.shade400,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      MadarLocalizations.of(
                                                              context)
                                                          .trans('subtotal'),
                                                      style: TextStyle(
                                                          fontSize: AppFonts
                                                              .small_font_size,
                                                          color: Colors
                                                              .grey.shade400,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ]),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Table(
                                                columnWidths: {
                                                  1: FractionColumnWidth(.2),
                                                  2: FractionColumnWidth(.2),
                                                  3: FractionColumnWidth(.2),
                                                  4: FractionColumnWidth(.2)
                                                },
                                                children: snapshot.data.bills
                                                    .map(
                                                      (bill) => TableRow(
                                                            children: [
                                                              Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 8.0),
                                                                  child: Text(
                                                                    '${bill.titleEn}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            AppFonts
                                                                                .medium_font_size,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )),
                                                              Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 8.0),
                                                                  child: Text(
                                                                    '${bill.pricePerUnit}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            AppFonts
                                                                                .medium_font_size,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )),
                                                              Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 8.0),
                                                                  child: Text(
                                                                    '${bill.quantity}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            AppFonts
                                                                                .medium_font_size,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )),
                                                              Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 8.0),
                                                                  child: Text(
                                                                    '${bill.totalPrice}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            AppFonts
                                                                                .medium_font_size,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )),
                                                            ],
                                                          ),
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                    Container(
                                      height: 100,
                                      margin: EdgeInsets.only(
                                          left: 16.0, right: 16.0, top: 8.0),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      child: costWidget(trip.cost.toString()),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              actions: <Widget>[],
            ),
          )
        ],
      ),
    );
  }
}
