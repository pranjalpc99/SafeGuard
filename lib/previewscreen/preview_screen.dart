/*
 * Copyright (c) 2019 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import 'dart:io';
import 'dart:typed_data';
import 'package:Humanely/models/scroll_behaviour.dart';
import 'package:Humanely/utils/app_theme.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class PreviewImageScreen extends StatefulWidget {
  final String imagePath;

  PreviewImageScreen({this.imagePath});

  @override
  _PreviewImageScreenState createState() => _PreviewImageScreenState();
}

class _PreviewImageScreenState extends State<PreviewImageScreen> {

  List<String> _tags;
  int _defaultTagIndex;


  @override
  void initState() {
    _defaultTagIndex = 0;
    _tags = [
      'Fire',
      'Accident',
      'Flood'
    ];
  }

  Widget choiceChips() {
    return Expanded(
      flex: 1,
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 8.0),
          scrollDirection: Axis.horizontal,
          itemCount: _tags.length,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              children: <Widget>[
                ChoiceChip(
                  label: Text(_tags[index]),
                  selected: _defaultTagIndex == index,
                  selectedColor: Colors.blue,
                  onSelected: (bool selected) {
                    setState(() {
                      _defaultTagIndex = selected ? index : 0;
                    });
                  },
                  backgroundColor: Colors.black45,
                  labelStyle: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 10.0,
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _postTopBar() {
    return Container(
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Card(
              color: Colors.white38,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Icon(Icons.chevron_left),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text("New Post"),
          Expanded(
            child: Text(
              "POST",
              textAlign: TextAlign.end,
              style: TextStyle(color: AppTheme.darkTheme.colorScheme.secondary),
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: _postTopBar(),
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.file(
                        File(widget.imagePath),
                        fit: BoxFit.fill,
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width / 5,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                          fontSize: 18,
                      ),
                      decoration: InputDecoration(
                          hintText: "Title",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.only(left:20.0),
                child: Text(
                  "Add Description",
                  style: TextStyle(color: Colors.white,
                  fontSize: 18),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left:20.0),
                child: Text(
                  "Add Tags",
                  style: TextStyle(color: Colors.white,fontSize: 18),
                ),
              ),
              choiceChips(),
              Spacer(flex: 3,),
//              Flexible(
//                flex: 1,
//                child: Container(
//                  padding: EdgeInsets.all(60.0),
//                  child: RaisedButton(
//                    onPressed: () {
//                      getBytesFromFile().then((bytes) {
//                        Share.file('Share via:', basename(widget.imagePath),
//                            bytes.buffer.asUint8List(), 'image/png');
//                      });
//                    },
//                    child: Text('Share'),
//                  ),
//                ),
//              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<ByteData> getBytesFromFile() async {
    Uint8List bytes = File(widget.imagePath).readAsBytesSync() as Uint8List;
    return ByteData.view(bytes.buffer);
  }
}