import 'dart:io';
import 'dart:math';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdf_renderer/flutter_pdf_renderer.dart';
import 'package:madar_booking/feedback.dart';
import 'package:madar_booking/madarLocalizer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zoom_widget/zoom_widget.dart';

class PdfPreview extends StatefulWidget {
  final String pdfLink;

  PdfPreview(this.pdfLink);

  @override
  _PdfPreviewState createState() => _PdfPreviewState();
}

class _PdfPreviewState extends State<PdfPreview> with UserFeedback {
  String filePath;
  File pdfFile;
  final _showLoading = BehaviorSubject<bool>();
  final _showSaving = BehaviorSubject<bool>();

  @override
  initState() {
    super.initState();
    _showLoading.sink.add(false);
    _showSaving.sink.add(false);
    downloadPdfFile(widget.pdfLink, GetFileType.READ);
  }

  static final Random random = Random();
  PermissionStatus checkPermission1;

  checkPermission() async {
    checkPermission1 = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    if (checkPermission1 != PermissionStatus.granted) {
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      checkPermission1 = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
      if (checkPermission1 == PermissionStatus.granted) {
        downloadPdfFile(widget.pdfLink, GetFileType.SAVE);
      } else {
        showInSnackBar('need_permission', context);
      }
    } else {
      downloadPdfFile(widget.pdfLink, GetFileType.SAVE);
    }
  }

  Future<String> downloadPdfFile(String pdfUrl, GetFileType fileType) async {
    if (fileType == GetFileType.READ) {
      _showLoading.sink.add(true);
    } else {
      _showSaving.sink.add(true);
    }
    String dirloc = "";

    if (Platform.isAndroid) {
      if (fileType == GetFileType.READ) {
        dirloc = (await getTemporaryDirectory()).path;
      } else {
        dirloc = "/sdcard/download/";
      }
    } else {
      dirloc = (await getApplicationDocumentsDirectory()).path;
    }

    var randid = random.nextInt(10000);
    FileUtils.mkdir([dirloc]);
    File file = new File(dirloc + randid.toString() + ".pdf");
    try {
      HttpClient client = new HttpClient();
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      HttpClientRequest request = await client.getUrl(Uri.parse(pdfUrl));
      request.headers.set('content-type', 'application/json');
      HttpClientResponse response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      await file.writeAsBytes(bytes);
      _showLoading.sink.add(false);
      _showSaving.sink.add(false);
      setState(() {
        filePath = file.path;
        pdfFile = file;
        print(filePath);
      });
    } catch (e) {
      print(e);
    }
  }

  shareFile() async {
    final ByteData bytes =
        await pdfFile.readAsBytes().then((data) => ByteData.view(data.buffer));
    await Share.file(
        'Jawolatcom', 'trip.pdf', bytes.buffer.asUint8List(), 'application/pdf',
        text: 'Jawolatcom');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          MadarLocalizations.of(context).trans('Summary'),
        ),
        actions: <Widget>[
          StreamBuilder<bool>(
              stream: _showSaving,
              initialData: false,
              builder: (context, snapshot) {
                if (snapshot.data == false) {
                  return InkWell(
                    onTap: () async {
                      checkPermission();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.file_download),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                shareFile();
              }),
          SizedBox(
            width: 8,
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder<bool>(
            stream: _showLoading,
            initialData: false,
            builder: (context, snapshot) {
              if (snapshot.data == true) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Center(
                  child: Column(
                    children: <Widget>[
                      (filePath != null)
                          ? Container(
                              height: MediaQuery.of(context).size.height / 1.2,
                              child: Zoom(
                                initZoom: 0.2,
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: PdfRenderer(
                                  pdfFile: filePath,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}

enum GetFileType { READ, SAVE }
