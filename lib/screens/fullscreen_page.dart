import 'package:flutter/material.dart';

class FullScreen extends StatelessWidget {
  final List image2;
  final int index2;
  const FullScreen({super.key, required this.image2, required this.index2});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PageView.builder(
              itemCount: image2.length,
              itemBuilder: (context, index) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    image: DecorationImage(
                        image: NetworkImage(image2[index2 + index]
                            ['src']['large2x']),
                        fit: BoxFit.cover),
                  ),
                );
              },
            ),
            Column(
              children: [
                Container(
                  height: 50,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(8),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Colors.white38,
                      )),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      height: 200,
                      width: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(Icons.cloud_download_outlined),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(Icons.favorite_border),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    colors: [
                                      Color.fromARGB(214, 255, 255, 100),
                                      Color.fromARGB(197, 250, 86, 141)
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Icon(
                                Icons.download_done_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
