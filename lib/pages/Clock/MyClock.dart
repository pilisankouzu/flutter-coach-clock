import 'dart:async';
import 'package:coach/common/service/coachClub.dart';
import 'package:coach/model/CoachClubEntity.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:coach/fonts/iconfont.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:amap_location_flutter_plugin/amap_location_flutter_plugin.dart';

class MyClock extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyClockState();
}

class MyClockState extends State<MyClock> {
  //初始化时间
  Timer _timer;
  String _Date = new DateFormat('yyyy.MM.dd').format(DateTime.now());
  String _Time = new DateFormat('HH:mm:ss').format(DateTime.now());

  //初始化位置信息
  Map<String, Object> _loationResult;
  StreamSubscription<Map<String, Object>> _locationListener;
  AmapLocationFlutterPlugin _locationPlugin = new AmapLocationFlutterPlugin();
  List<String> list = new List<String>();

  //教练俱乐部信息
  String coachNmae = '';
  String coachlogo = "https://qiniu.langjukeji.com/roller/20190808/49bcefabe7bc4d3083d3c534c6a818e0.jpg";
  //打卡和查看记录切换
  bool _ClockState=true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: new Column(
        children: <Widget>[
          new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                width: 40.0,
                height: 40.0,
                margin: EdgeInsets.only(right: 10.0),
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    image: new DecorationImage(
                        image: new NetworkImage(
                            coachlogo
                            ),
                        fit: BoxFit.cover),
                    border: new Border.all(color: Colors.white, width: 1.0)),
              ),
              new Expanded(
                  child: new Text(
                    coachNmae,
                    style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w600,
                        fontSize: 17.0),
                  )),
              new Container(
                child: new Text(
                  _Date,
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 15.0),
                ),
              ),
            ],
          ),
          new Expanded(
            child: _ClockState ? new Column(
              children: <Widget>[
                new Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                    child: new Container(
                      padding: EdgeInsets.only(left: 10),
                      child: ListView(
//                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: new Text(
                              "上班打卡时间：",
                              style: TextStyle(
                                  color: Color(0xFFFEFEFE), fontSize: 15.0),
                            ),
                          ),
                          new Container(
                            padding: EdgeInsets.only(left: 5.0, bottom: 10.0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Container(
                                  child: new Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: <Widget>[
                                      new Icon(
                                        Icons.access_alarm,
                                        color: Color(0xFFFEFEFE),
                                        size: 13.0,
                                      ),
                                      new Padding(
                                        padding: EdgeInsets.only(left: 3.0),
                                        child: new Text(
                                          "09:00",
                                          style: TextStyle(
                                              color: Color(0xFFFEFEFE),
                                              fontSize: 15.0),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                new Container(
                                  child: new Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        padding: EdgeInsets.only(top: 3.0),
                                        child: new Icon(
                                          Icons.room,
                                          color: Color(0xFFFEFEFE),
                                          size: 14.0,
                                        ),
                                      ),
                                      new Expanded(
                                          child: new Padding(
                                            padding: EdgeInsets.only(left: 3.0),
                                            child: new Text(
                                              "河南省郑州市荥阳市中原西路55号靠近荥阳市公安局出入境接待大厅",
                                              style: TextStyle(
                                                  color: Color(0xFFFEFEFE),
                                                  fontSize: 14.0),
                                            ),
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          new Container(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: new Text(
                              "下班打卡时间：",
                              style: TextStyle(
                                  color: Color(0xFFFEFEFE), fontSize: 15.0),
                            ),
                          ),
                          new Container(
                            padding: EdgeInsets.only(left: 5.0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Container(
                                  child: new Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: <Widget>[
                                      new Icon(
                                        Icons.access_alarm,
                                        color: Color(0xFFFEFEFE),
                                        size: 13.0,
                                      ),
                                      new Padding(
                                        padding: EdgeInsets.only(left: 3.0),
                                        child: new Text(
                                          "09:00",
                                          style: TextStyle(
                                              color: Color(0xFFFEFEFE),
                                              fontSize: 15.0),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                new Container(
                                  child: new Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        padding: EdgeInsets.only(top: 3.0),
                                        child: new Icon(
                                          Icons.room,
                                          color: Color(0xFFFEFEFE),
                                          size: 14.0,
                                        ),
                                      ),
                                      new Expanded(
                                          child: new Padding(
                                            padding: EdgeInsets.only(left: 3.0),
                                            child: new Text(
                                              "河南省郑州市荥阳市中原西路55号靠近荥阳市公安局出入境接待大厅",
                                              style: TextStyle(
                                                  color: Color(0xFFFEFEFE),
                                                  fontSize: 14.0),
                                            ),
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  width: 1, color: Color(0xFFFFFFFF)))),
                    ),
                  ),
                  flex: 2,
                ),
                new Expanded(
                  child: new Card(
                    elevation: 10.0,
                    shape: CircleBorder(
                      side: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    child: new CircleAvatar(
                      backgroundColor: Color(0xFFFFFFFF),
                      radius: 60.0,
                      child: new Center(
                        child: new GestureDetector(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text(
                                "上课打卡",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF29CCCC),
                                    fontSize: 16.0),
                              ),
                              new Text(
                                _Time,
                                style: TextStyle(
                                    color: Color(0xFF29CCCC), fontSize: 14.0),
                              )
                            ],
                          ),
                          onTap: () {
                            print("点击打卡");
                          },
                        ),
                      ),
                    ),
                  ),
                  flex: 3,
                ),
                new Expanded(
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        child: new Icon(
                          Icons.room,
                          size: 18.0,
                          color: Color(0xFF29CCCC),
                        ),
                      ),
                      new Expanded(
                          child: new Text(
                            _loationResult == null ? "定位失败" : list[list.length - 1],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style:
                            TextStyle(color: Color(0xFF333333), fontSize: 14.0),
                          )),
                      new InkWell(
                        child: new Text(
                          "重新定位",
                          style: TextStyle(
                              color: Color(0xFF29CCCC), fontSize: 16.0),
                        ),
                        onTap: () {
                          if (list[list.length - 3] == '12') {
                            //获取位置权限
                            requestPermission();
                            onceLocation();
                          } else {
                            onceLocation();
                          }
                        },
                      )
                    ],
                  ),
                  flex: 1,
                )
              ],
            ): new Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.only(top: 20.0),
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 60.0),
                child: new Column(children: <Widget>[
                  new Container(
                    child: Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Container(
                            padding: EdgeInsets.all(10),
                            child: new Text(
                              "时间",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF29CCCC), fontSize: 15.0),
                            ),
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        width: 1,
                                        color: Color.fromRGBO(0, 0, 0, 0.1)))),
                          ),
                        ),
                        new Expanded(
                          child: new Container(
                            padding: EdgeInsets.all(10),
                            child: new Text(
                              "地点",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF29CCCC), fontSize: 15.0),
                            ),
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        width: 1,
                                        color: Color.fromRGBO(0, 0, 0, 0.1)))),
                          ),
                        ),
                        new Expanded(
                            child: new Text(
                              "出勤天数",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF29CCCC), fontSize: 15.0),
                            ))
                      ],
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: Color.fromRGBO(0, 0, 0, 0.1)))),
                  ),
                  new Expanded(
                    child: ListView(
                      children: <Widget>[
                        new Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Expanded(
                                child: new Container(
                                  height: 50.0,
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(
                                        "2019.07.08",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 14.0),
                                      ),
                                      new Text(
                                        "09:00:00",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 14.0),
                                      )
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 1,
                                              color: Color.fromRGBO(
                                                  0, 0, 0, 0.1)))),
                                ),
                              ),
                              new Expanded(
                                child: new Container(
                                  height: 50.0,
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(
                                        "轮滑俱乐部",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 1,
                                              color: Color.fromRGBO(
                                                  0, 0, 0, 0.1)))),
                                ),
                              ),
                              new Expanded(
                                child: new Container(
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  child: new Text(
                                    "267课时",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 14.0),
                                  ),
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Color(0xffe5e5e5)))),
                        ),
                        new Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Expanded(
                                child: new Container(
                                  height: 50.0,
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(
                                        "2019.07.08",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 14.0),
                                      ),
                                      new Text(
                                        "09:00:00",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 14.0),
                                      )
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 1,
                                              color: Color.fromRGBO(
                                                  0, 0, 0, 0.1)))),
                                ),
                              ),
                              new Expanded(
                                child: new Container(
                                  height: 50.0,
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(
                                        "轮滑俱乐部",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 1,
                                              color: Color.fromRGBO(
                                                  0, 0, 0, 0.1)))),
                                ),
                              ),
                              new Expanded(
                                child: new Container(
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  child: new Text(
                                    "267课时",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 14.0),
                                  ),
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Color(0xffe5e5e5)))),
                        ),
                        new Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Expanded(
                                child: new Container(
                                  height: 50.0,
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(
                                        "2019.07.08",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 14.0),
                                      ),
                                      new Text(
                                        "09:00:00",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 14.0),
                                      )
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 1,
                                              color: Color.fromRGBO(
                                                  0, 0, 0, 0.1)))),
                                ),
                              ),
                              new Expanded(
                                child: new Container(
                                  height: 50.0,
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(
                                        "轮滑俱乐部",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 1,
                                              color: Color.fromRGBO(
                                                  0, 0, 0, 0.1)))),
                                ),
                              ),
                              new Expanded(
                                child: new Container(
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  child: new Text(
                                    "267课时",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 14.0),
                                  ),
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Color(0xffe5e5e5)))),
                        ),
                        new Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Expanded(
                                child: new Container(
                                  height: 50.0,
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(
                                        "2019.07.08",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 14.0),
                                      ),
                                      new Text(
                                        "09:00:00",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 14.0),
                                      )
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 1,
                                              color: Color.fromRGBO(
                                                  0, 0, 0, 0.1)))),
                                ),
                              ),
                              new Expanded(
                                child: new Container(
                                  height: 50.0,
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(
                                        "轮滑俱乐部",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 1,
                                              color: Color.fromRGBO(
                                                  0, 0, 0, 0.1)))),
                                ),
                              ),
                              new Expanded(
                                child: new Container(
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  child: new Text(
                                    "267课时",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 14.0),
                                  ),
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Color(0xffe5e5e5)))),
                        ),
                        new Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Expanded(
                                child: new Container(
                                  height: 50.0,
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(
                                        "2019.07.08",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 14.0),
                                      ),
                                      new Text(
                                        "09:00:00",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 14.0),
                                      )
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 1,
                                              color: Color.fromRGBO(
                                                  0, 0, 0, 0.1)))),
                                ),
                              ),
                              new Expanded(
                                child: new Container(
                                  height: 50.0,
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(
                                        "轮滑俱乐部",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 1,
                                              color: Color.fromRGBO(
                                                  0, 0, 0, 0.1)))),
                                ),
                              ),
                              new Expanded(
                                child: new Container(
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  child: new Text(
                                    "267课时",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 14.0),
                                  ),
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Color(0xffe5e5e5)))),
                        ),
                        new Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Expanded(
                                child: new Container(
                                  height: 50.0,
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(
                                        "2019.07.08",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 14.0),
                                      ),
                                      new Text(
                                        "09:00:00",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 14.0),
                                      )
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 1,
                                              color: Color.fromRGBO(
                                                  0, 0, 0, 0.1)))),
                                ),
                              ),
                              new Expanded(
                                child: new Container(
                                  height: 50.0,
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(
                                        "轮滑俱乐部",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 1,
                                              color: Color.fromRGBO(
                                                  0, 0, 0, 0.1)))),
                                ),
                              ),
                              new Expanded(
                                child: new Container(
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  child: new Text(
                                    "267课时",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 14.0),
                                  ),
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Color(0xffe5e5e5)))),
                        ),
                        new Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Expanded(
                                child: new Container(
                                  height: 50.0,
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(
                                        "2019.07.08",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 14.0),
                                      ),
                                      new Text(
                                        "09:00:00",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 14.0),
                                      )
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 1,
                                              color: Color.fromRGBO(
                                                  0, 0, 0, 0.1)))),
                                ),
                              ),
                              new Expanded(
                                child: new Container(
                                  height: 50.0,
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(
                                        "轮滑俱乐部",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 1,
                                              color: Color.fromRGBO(
                                                  0, 0, 0, 0.1)))),
                                ),
                              ),
                              new Expanded(
                                child: new Container(
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  child: new Text(
                                    "267课时",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 14.0),
                                  ),
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Color(0xffe5e5e5)))),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            )
          ),
          new Container(
            padding: EdgeInsets.only(bottom: 20.0, top: 10.0),
            child: new Row(
              children: <Widget>[
                Expanded(
                  child:new InkWell(
                    child:  Column(
                      children: <Widget>[
                        new Icon(
                          IconFont.icon_daqia,
                          color: _ClockState ? Color(0xFF29CCCC): Color(0xFF999999),
                        ),
                        new Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: new Text(
                            "打卡",
                            style: new TextStyle(
                                fontSize: 16.0,
                                color: _ClockState ? Color(0xFF29CCCC): Color(0xFF999999),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    onTap: (){
                      setState(() {
                        _ClockState=true;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: new InkWell(
                    child: Column(
                      children: <Widget>[
                        new Icon(
                          IconFont.icon_daqiajilu,
                          color: _ClockState ? Color(0xFF999999): Color(0xFF29CCCC),
                        ),
                        new Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: new Text(
                            "打卡记录",
                            style: new TextStyle(
                                fontSize: 16.0,
                                color: _ClockState ? Color(0xFF999999):  Color(0xFF29CCCC),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        _ClockState=false;
                      });
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  //获取位置
  Future startLocation() async {
    _locationListener = _locationPlugin
        .onLocationChanged()
        .listen((Map<String, Object> result) {
      setState(() {
        _loationResult = result;
        _loationResult.forEach((key, value) {
          list.add('$value');
        });
      });
    });
  }

  //重新获取位置
  Future onceLocation() async {
    //获取位置信息
    startLocation();
    _locationPlugin.startLocation();
    new Future.delayed(
        const Duration(seconds: 30), () => _locationPlugin.stopLocation());
  }

  //获取时间
  Future startTimer() async {
    //设置 1 秒回调一次
    const period = const Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      //更新界面
      setState(() {
        _Time = new DateFormat('HH:mm:ss').format(DateTime.now());
      });
    });
  }

  //取消获取时间
  Future cancelTimer() async {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  //获取教练在俱乐部的信息
  _getcoachClub() async {
    await CoachClubService.getCoachClub().then((CoachClubEntity v) {
      if (v != null) {
        setState(() {
          coachNmae = v.coachName ?? "";
          coachlogo = v.showImg ?? "";
        });
      }
      print(v);
    });
  }

  @override
  void initState() {
    super.initState();
    _getcoachClub();
    //获取位置权限
    requestPermission();
    //获取当期时间
    startTimer();
    //获取位置信息
    startLocation();
    _locationPlugin.startLocation();
    new Future.delayed(
        const Duration(seconds: 30), () => _locationPlugin.stopLocation());
  }

  @override
  void dispose() {
    super.dispose();
    cancelTimer();
    if (null != _locationListener) {
      _locationListener.cancel();
    }
  }
}

//获取权限
Future requestPermission() async {
  // 申请权限

  Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler()
      .requestPermissions([PermissionGroup.locationWhenInUse]);

  // 申请结果

//  PermissionStatus permission =
//
//  await PermissionHandler().checkPermissionStatus(PermissionGroup.locationWhenInUse);
//
//  if (permission == PermissionStatus.granted) {
//
//    Fluttertoast.showToast(msg: "权限申请通过");
//
//  } else {
//
//    Fluttertoast.showToast(msg: "权限申请被拒绝");
//
//  }
}
