import 'package:api_integration/models/posts.dart';
import 'package:api_integration/services/remote_service.dart';
import 'package:flutter/material.dart';

class mainPage extends StatefulWidget {
  const mainPage({Key? key}) : super(key: key);

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  List<Post>? posts;
  var isLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //for getting data from server
    getData();
  }

  getData() async {
    posts = await RemoteService().getPosts();
    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fetch Api integration"),
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
            itemCount: posts?.length,
            itemBuilder: (context, i) {
              return Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          height: 50.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.grey),
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                posts![i].title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                posts![i].body ?? '',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 20.0,
                    color: Colors.red,
                  ),
                ],
              );
            }),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
