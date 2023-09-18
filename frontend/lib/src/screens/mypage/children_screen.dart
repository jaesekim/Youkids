import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youkids/src/models/home_models/child_icon_model.dart';
import 'package:youkids/src/widgets/mypage_widgets/mychildren_widget.dart';
import 'package:youkids/src/widgets/mypage_widgets/mygroup_widget.dart';
import 'package:youkids/src/widgets/footer_widget.dart';

class ChildrenScreen extends StatelessWidget {
  final String childrenName;
  const ChildrenScreen({super.key, required this.childrenName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          childrenName,
          style: const TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: SvgPicture.asset('lib/src/assets/icons/bell_white.svg',
          //       height: 24),
          // ),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade300,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.all(2)),
              child: const Text(
                "수정",
                style: TextStyle(fontSize: 20, color: Colors.white),
              )),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                child: Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(tmpChildStoryIcon[0].imgUrl),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              const Text(
                "사진 변경",
                style: TextStyle(color: Color(0XFF0075FF), fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text("이름"),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              alignment: Alignment.centerLeft,
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0XFFF6766E)),
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Text("은우"),
                            )
                          ],
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text("생년월일"),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              alignment: Alignment.centerLeft,
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0XFFF6766E)),
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Text("1994.08.26"),
                            )
                          ],
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text("성별"),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              alignment: Alignment.centerLeft,
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0XFFF6766E)),
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Text("남"),
                            )
                          ],
                        )),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const FooterWidget(currentIndex: 4),
    );
  }
}
