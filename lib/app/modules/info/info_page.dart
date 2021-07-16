import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:simple_graphql/app/modules/info/info_bloc.dart';

class InfoPage extends StatefulWidget {
  @override
  InfoPageState createState() => InfoPageState();
}

class InfoPageState extends ModularState<InfoPage, InfoBloc> {
  bool loading = false;
  @override
  void initState() {
    super.initState();
    _setupStreams();
    controller.getUsers();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GraphQl'),
        actions: [
          IconButton(
              onPressed: () => Modular.to.navigate('/'),
              icon: Icon(Icons.logout, size: 25)),
        ],
      ),
      body: SafeArea(
        child: loading
            ? Center(child: CircularProgressIndicator())
            : StreamBuilder<List<dynamic>>(
                stream: controller.usersOutput.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: ListView.separated(
                        itemCount: snapshot.data!.length,
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.black,
                        ),
                        itemBuilder: (context, index) {
                          DateTime dateGraphQl = DateTime.parse(
                              snapshot.data![index]['created_at']);

                          return Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: ListTile(
                              title: Text(
                                '${snapshot.data![index]['firstName']} ${snapshot.data![index]['lastName']}',
                                style: TextStyle(fontSize: 18),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${snapshot.data![index]['email']}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    DateFormat('dd/MM/yyyy - hh:mm')
                                        .format(dateGraphQl),
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Fluttertoast.showToast(
                                    msg: '${snapshot.data![index]['id']}',
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              },
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: Text('Vazio'),
                    );
                  }
                }),
      ),
    );
  }

  _setupStreams() {
    controller.showLoadingOutput.listen((value) async {
      if (value) {
        setState(() {
          loading = true;
        });
      } else {
        setState(() {
          loading = false;
        });
      }
    });
  }
}
