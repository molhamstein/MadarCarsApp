import 'dart:async';
import 'package:flutter/material.dart';
import 'package:madar_booking/app_bloc.dart';
import 'package:madar_booking/bloc_provider.dart';
import 'package:madar_booking/invoice_page.dart';
import 'package:madar_booking/models/Invoice.dart';
import 'package:madar_booking/models/MyTrip.dart';
import 'package:madar_booking/models/TripModel.dart';
import 'package:madar_booking/my_flutter_app_icons.dart';
import 'package:madar_booking/profile_bloc.dart';
import 'package:madar_booking/rate_widget.dart';
import 'package:madar_booking/settings_page.dart';
import 'madar_colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
                child: Text("Total Cost",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
                          Text('${bill.titleEn}'),
                          Text('${bill.pricePerUnit}'),
                          Text('${bill.quantity}'),
                          Text('${bill.totalPrice}'),
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
                                  "Invoice",
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
                                    "Mercides E16",
                                    style: TextStyle(
                                        fontSize: AppFonts.large_font_size,
                                        color: Colors.grey.shade800,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    "Istanbul",
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
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            width: 350,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/invoice-01.png'),
                                fit: BoxFit.cover,
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
                                              title: Text("Date",
                                                  style: TextStyle(
                                                    fontSize: AppFonts
                                                        .medium_font_size,
                                                    color: Colors.grey.shade600,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              subtitle: Text(
                                                "12/12/2018",
                                                style: TextStyle(
                                                  fontSize:
                                                      AppFonts.large_font_size,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
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
                                              title: Text("Invoice",
                                                  style: TextStyle(
                                                    fontSize: AppFonts
                                                        .medium_font_size,
                                                    color: Colors.grey.shade600,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              subtitle: Text(
                                                "Qtqtfaqc23",
                                                style: TextStyle(
                                                  fontSize:
                                                      AppFonts.large_font_size,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
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
                                                "item",
                                                style: TextStyle(
                                                    fontSize: AppFonts
                                                        .small_font_size,
                                                    color: Colors.grey.shade400,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "Price",
                                                style: TextStyle(
                                                    fontSize: AppFonts
                                                        .small_font_size,
                                                    color: Colors.grey.shade400,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "Quantity",
                                                style: TextStyle(
                                                    fontSize: AppFonts
                                                        .small_font_size,
                                                    color: Colors.grey.shade400,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "subtotal",
                                                style: TextStyle(
                                                    fontSize: AppFonts
                                                        .small_font_size,
                                                    color: Colors.grey.shade400,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ]),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: getInvoice(),
                                      ),
                                    ],
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
                                  child: costWidget("210"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
            appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
          )
        ],
      ),
    );
  }
}
