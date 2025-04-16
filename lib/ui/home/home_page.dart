import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_map_app/data/repository/geolocator.dart';
import 'package:flutter_map_app/ui/detail/detail_page.dart';
import 'package:flutter_map_app/ui/home/home_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    HomeState homeState = ref.watch(homeViewModelProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          title: TextField(
            onSubmitted: (text) {
              ref.read(homeViewModelProvider.notifier).search(text);
            },
            decoration: InputDecoration(
              hintText: '주소를 입력해 주세요',
              border: WidgetStateInputBorder.resolveWith(
                (state) {
                  if (state.contains(WidgetState.focused)) {
                    return OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    );
                  } else {
                    return OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                Position pos = await getCurrentLocation();
                print('${pos.longitude}, ${pos.latitude}');
                ref
                    .read(homeViewModelProvider.notifier)
                    .searchByLatLng(pos.longitude, pos.latitude);
              },
              child: Container(
                padding: EdgeInsets.only(right: 15),
                alignment: Alignment.center,
                width: 50,
                height: 50,
                color: Colors.transparent,
                child: Icon(
                  Icons.gps_fixed,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: homeState.locations?.length ?? 0,
          itemBuilder: (context, index) {
            final location = homeState.locations?[index];
            if (location == null) {
              return Container();
            }
            return Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: GestureDetector(
                onTap: () {
                  if (location.link != null &&
                      location.link!.trim().isNotEmpty &&
                      location.link!.contains('http')) {
                    print('링크: ${location.link}');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return DetailPage(
                            link: location.link,
                          );
                        },
                      ),
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Html(
                          data: location.title ?? '',
                          style: {
                            "*": Style(
                              padding: HtmlPaddings.zero,
                              margin: Margins.zero,
                              fontSize: FontSize(18),
                              fontWeight: FontWeight.bold,
                              maxLines: 1,
                              textOverflow: TextOverflow.ellipsis,
                            )
                          },
                        ),
                        Spacer(),
                        Text(
                          location.category ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          location.roadAddress ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
