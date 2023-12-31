import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youkids/src/screens/course/course_screen.dart';
import 'package:youkids/src/screens/shop/shop_detail_screen.dart';
import 'package:http/http.dart' as http;

class CoursePostScreen extends StatefulWidget {
  final List<Map<String, dynamic>> coursePlacesInfo;
  final List<NMarker> coursePlaces;

  CoursePostScreen({
    required this.coursePlacesInfo,
    required this.coursePlaces,
  });

  @override
  _CoursePostScreenState createState() => _CoursePostScreenState();
}

class _CoursePostScreenState extends State<CoursePostScreen> {
  bool _isLoggedIn = false;
  NaverMapController? _controller;
  TextEditingController _courseNameController = TextEditingController();
  String? userId;
  Future? loadDataFuture;
  List<Map<String, dynamic>> placesData = [];

  Future<void> infoToData() async {
    placesData = widget.coursePlacesInfo.asMap().entries.map((entry) {
      final int order = entry.key + 1;
      final int placeId = entry.value['placeId'];
      return {
        'placeId': placeId,
        'order': order,
      };
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    loadDataFuture = _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    userId = await getUserId();

    setState(() {
      _isLoggedIn = userId != null; // 이메일이 null이 아니면 로그인된 것으로 판단
    });
  }

  Future<void> showSuccessDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('알림'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('코스가 성공적으로 등록되었습니다.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        CourseScreen(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showErrorDialog(
      BuildContext context, String errorMessage) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('알림'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('코스 등록 실패'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(
      'userId',
    );
  }

  void _onMapReady(NaverMapController controller) {
    setState(() {
      _controller = controller;
      _initData();
      infoToData();
    });
  }

  Future<void> _initData() async {
    setState(() {
      _renderBookmark(widget.coursePlaces);
    });
  }

  Future _renderBookmark(List? bookmarks) async {
    if (bookmarks != null) {
      List<NLatLng> bound = [];
      for (var place in widget.coursePlaces) {
        bound.add(place.position);
      }

      var bounds = NLatLngBounds.from(bound);

      _controller!.updateCamera(
        NCameraUpdate.fitBounds(bounds, padding: EdgeInsets.all(50)),
      );
      // 해당 코스 마커 렌더링
      int i = 0;
      for (var place in widget.coursePlaces) {
        final marker = NMarker(
          icon: NOverlayImage.fromAssetImage(
              "lib/src/assets/icons/mark" + (i + 1).toString() + ".png"),
          size: NMarker.autoSize,
          id: i.toString(),
          position: place.position,
        );
        i++;

        // 마커 지도 위에 렌더링
        await _controller!.addOverlay(marker);
      }
    }
  }

  Future postCourse(String courseName) async {
    String api = dotenv.get("api_key");
    Uri uri = Uri.parse(api + "/course");
    Map data = {
      "courseName": courseName,
      "userId": userId,
      "places": placesData,
    };

    var body = json.encode(data);

    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        showSuccessDialog(context);
      } else {
        showErrorDialog(context, '오류가 발생했습니다.');
      }
    } catch (error) {
      showErrorDialog(context, '오류가 발생했습니다.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '코스',
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        actions: [],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: NaverMap(
                  options: NaverMapViewOptions(
                    initialCameraPosition: NCameraPosition(
                      target: NLatLng(37.5110317, 127.0602133),
                      zoom: 15,
                    ),
                    locale: Locale.fromSubtags(languageCode: 'Ko'),
                    rotationGesturesEnable: false,
                    scrollGesturesEnable: false,
                    tiltGesturesEnable: false,
                    zoomGesturesEnable: false,
                    stopGesturesEnable: false,
                    contentPadding: EdgeInsets.only(bottom: 10),
                  ),
                  onMapReady: _onMapReady,
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 70,
                        ),
                        ...widget.coursePlacesInfo.asMap().entries.map((entry) {
                          final int index = entry.key;
                          final Map<String, dynamic> coursePlace = entry.value;
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          ShopDetailScreen(
                                              placeId: coursePlace['placeId']),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.0),
                                        child: Image.asset(
                                          "lib/src/assets/icons/mark" +
                                              (index+1)
                                                  .toString() +
                                              ".png",
                                          height: 35,
                                          alignment:
                                          AlignmentDirectional
                                              .center,
                                        ),
                                      ),
                                      SizedBox(width: 12.0),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            SizedBox(height: 10.0),
                                            Text(
                                              coursePlace['name'],
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                              overflow: TextOverflow
                                                  .ellipsis,
                                            ),
                                            Text(
                                              coursePlace['address'],
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors
                                                    .grey[700],
                                              ),
                                              overflow: TextOverflow
                                                  .ellipsis,
                                            ),
                                            SizedBox(height: 10.0)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Divider(
                                      color: Color(0xFF949494),
                                      thickness: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.28,
            left: 0,
            right: 0,
            child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, right:10.0),
                          child: TextFormField(
                            controller: _courseNameController,
                            decoration: InputDecoration(
                              hintText: '코스 명',
                              hintStyle: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFF6766E),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFF6766E),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 16),
                            ),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: TextButton(
                          onPressed: () {
                            String courseName = _courseNameController.text;
                            if (courseName.isEmpty) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("알림"),
                                    content: Text("코스 명을 입력해주세요."),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("확인"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                            if(courseName.isNotEmpty && courseName.length<= 10){
                              postCourse(courseName);
                            }
                            if(courseName.isNotEmpty && courseName.length> 10){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("알림"),
                                    content: Text("코스 명은 10자 이내로 입력해주세요."),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("확인"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          style: ButtonStyle(
                            side: MaterialStateProperty.all(
                              BorderSide(
                                color: Color(0xFFF6766E),
                                width: 2.0,
                              ),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            backgroundColor:
                                MaterialStatePropertyAll(Color(0xFFF6766E)),
                          ),
                          child: Text(
                            '등록',
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
