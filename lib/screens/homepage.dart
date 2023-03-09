import 'package:flutter/material.dart';
import 'package:wallpaper_app/widgets/category.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/widgets/mainlist.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List categoryimg = [
    'https://images.pexels.com/photos/2449600/pexels-photo-2449600.png?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/15286/pexels-photo.jpg?auto=compress&cs=tinysrgb&w=600&lazy=load',
    'https://images.pexels.com/photos/337909/pexels-photo-337909.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/1413412/pexels-photo-1413412.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/92248/pexels-photo-92248.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/2471234/pexels-photo-2471234.jpeg?auto=compress&cs=tinysrgb&w=6',
    'https://images.pexels.com/photos/2245436/pexels-photo-2245436.png?auto=compress&cs=tinysrgb&w=600',
  ];
  List names = [
    'Dark',
    'Nature',
    'Cars',
    'Bikes',
    'Street',
    'Abstract',
    'Travel'
  ];
  int page = 1;
  List images = [];
  bool _isloading = true, _isTap = true;
  String query = '';
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchapi();
  }

  Future fetchapi() async {
    await http.get(
        Uri.parse(_isTap
            ? 'https://api.pexels.com/v1/curated?per_page=80'
            : 'https://api.pexels.com/v1/search?query=$query&per_page=80'),
        headers: {
          'Authorization':
              'V5xdFc5AzilQgdIJLRS2VADnDwpsSMvR5CZxa4eKUFk4HwoyMkEOwwIl'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
        _isloading = false;
      });
    });
  }

  loadmore() async {
    setState(() {
      page++;
    });
    String url = _isTap
        ? 'https://api.pexels.com/v1/curated?per_page=80&page=$page'
        : 'https://api.pexels.com/v1/search?query=?$query&per_page=80&page=$page';
    await http.get(Uri.parse(url), headers: {
      'Authorization':
          'V5xdFc5AzilQgdIJLRS2VADnDwpsSMvR5CZxa4eKUFk4HwoyMkEOwwIl'
    }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const MenuBars(),
        centerTitle: true,
        title: const Text(
          'LIVE WALLPAPERS',
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),
              child: Container(
                width: 40,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(234, 255, 255, 100),
                      Color.fromARGB(212, 250, 86, 141)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(Icons.workspace_premium_rounded),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
              child: SizedBox(
                height: 40,
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    hintText: 'Search',
                    suffixIcon: IconButton(
                      onPressed: () {
                        _isTap = false;
                        setState(() {
                          query = _textController.text;
                          _isloading = true;
                          fetchapi();
                        });
                      },
                      icon: const Icon(Icons.search_rounded),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: const Text(
                'Categories',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: 7,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      _isTap = false;
                      setState(() {
                        query = names[index];
                        _isloading = true;
                        fetchapi();
                      });
                    },
                    child: Categorys(
                      image: categoryimg[index],
                      text: names[index],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: _isloading
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height - 150,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : GridView.builder(
                      itemCount: images.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 250,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        return MainList(
                          imageUrl: images[index]['src']['tiny'],
                          fullscreenUrl: images[index]['src']['large2x'],
                          images1: images,
                          index1: index,
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: _isloading
                  ? null
                  : ElevatedButton(
                      onPressed: () {
                        loadmore();
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.black87,
                          minimumSize: const Size(double.infinity, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: const Text('Load More'),
                    ),
            )
          ],
        ),
      ),
    );
  }
}

class MenuBars extends StatelessWidget {
  const MenuBars({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              color: Colors.black,
              height: 2.5,
              width: 18,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                color: Colors.black,
                height: 2.5,
                width: 18,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              color: Colors.black,
              height: 2.5,
              width: 8,
            ),
          )
        ],
      ),
    );
  }
}
