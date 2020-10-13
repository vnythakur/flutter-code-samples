import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';

enum DownloadStatus { initialized, downloading, finished }

/**
 * CUSTOM COMPONENT FOR CREATING DOWNLOAD COMPONENT
 */
class DownloadFile extends StatefulWidget {
  final String url;
  final String localPath;
  final Function downloadCallback;

  DownloadFile({this.url, this.localPath, this.downloadCallback});

  @override
  _DownloadFileState createState() => _DownloadFileState();
}

class _DownloadFileState extends State<DownloadFile> {
  TargetPlatform platform;
  String _localPath;
  String _filePath;

  DownloadStatus status = DownloadStatus.initialized;
  String progressString = '';

  @override
  void initState() {
    super.initState();

    if (widget.localPath == null) {
      Future.delayed(Duration(seconds: 2), () {
        _getLocalDir();
      });
    } else {
      setState(() {
        _localPath = widget.localPath;
        _checkDirExists();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    platform = Theme.of(context).platform;

    return _getCorrectButton();
  }

  _getCorrectButton() {
    if (status == DownloadStatus.initialized) {
      return FlatButton(
          onPressed: downloadFile, child: new Icon(Icons.file_download));
    } else if (status == DownloadStatus.downloading) {
      return FlatButton(onPressed: () {}, child: Text(progressString));
    } else if (status == DownloadStatus.finished) {
      return FlatButton(onPressed: openFile, child: Text('Open'));
    } else {
      return Container();
    }
  }

  Future<Null> _getLocalDir() async {
    _localPath = (await _findLocalPath()) + '/Download';
    await _checkDirExists();
  }

  Future<Null> _checkDirExists() async {
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String> _findLocalPath() async {
    final directory = platform == TargetPlatform.android
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> downloadFile() async {
    Dio dio = Dio();

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    try {
      await dio.download(widget.url, "${_localPath}/$fileName.jpg",
          onReceiveProgress: (rec, total) {
        print("Rec: $rec , Total: $total");

        setState(() {
          status = DownloadStatus.downloading;
          progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
          _filePath = "${_localPath}/$fileName.jpg";
        });
      });
    } catch (e) {
      print(e);
    }

    setState(() {
      status = DownloadStatus.finished;
      progressString = "";
    });
    if (widget.downloadCallback != null) widget.downloadCallback(_filePath);
    print("Download completed");
  }

  openFile() {
    print('Opening File : $_filePath');
    OpenFile.open(_filePath);
  }
}
