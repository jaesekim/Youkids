import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youkids/src/screens/shop/create_shop_review_screen.dart';
import 'package:youkids/src/widgets/footer_widget.dart';

class ShopDetailScreen extends StatelessWidget {
  const ShopDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text(
          'YouKids',
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('lib/src/assets/icons/bell_white.svg',
                height: 24),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 지도 들어올 자리
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 1.2,
              color: const Color(0xffF5EEEC),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  shopInfo(
                    imgUrl: 'lib/src/assets/icons/shop_address.png',
                    info: '대전광역시 중구 대종로 373(부사동, 한밭야구장 1루내야측)',
                  ),
                  shopInfo(
                    imgUrl: 'lib/src/assets/icons/shop_phone.png',
                    info: '010-0123-4567',
                  ),
                  shopInfo(
                    imgUrl: 'lib/src/assets/icons/shop_url.png',
                    info: 'http://www.naver.com',
                  ),
                  shopInfo(
                    imgUrl: 'lib/src/assets/icons/shop_info.png',
                    info: '불곱창 전문점 오픈시간: 매일 09:00 ~ 18:00',
                  ),
                  const Divider(
                    thickness: 1,
                    color: Color(0xff707070),
                  ),
                  const Divider(
                    thickness: 1,
                    color: Color(0xff707070),
                  ),
                  const Divider(
                    thickness: 1,
                    color: Color(0xff707070),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const FooterWidget(
        currentIndex: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateShopReviewScreen(),
            ),
          );
        },
        backgroundColor: const Color(0xffF6766E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Icon(
          Icons.create,
          color: Color(0xffFFFFFF),
        ),
      ),
    );
  }

  Padding shopInfo({required String imgUrl, required String info}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(imgUrl),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              info,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}