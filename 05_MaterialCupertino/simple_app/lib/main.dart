import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Homework 5'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  PersistentBottomSheetController _controller;
  TabController _tabController;
  int _selectedPage = 0;

  void toggleBottomSheet() {
    if (_controller == null) {
      _controller = scaffoldKey.currentState.showBottomSheet(
        (context) => Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.payment),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text('Сумма'),
                    ),
                    Text('200 руб.'),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Оплатить'),
              ),
            ],
          ),
        ),
      );
    } else {
      _controller.close();
      _controller = null;
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedPage = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: Icon(Icons.person),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              DrawerHeader(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blue,
                  backgroundImage: NetworkImage(
                      'https://cdn-icons-png.flaticon.com/512/147/147133.png'),
                ),
              ),
              ListTile(
                title: Text('Home'),
                leading: Icon(Icons.home),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                title: Text('Profile'),
                leading: Icon(Icons.person),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                title: Text('Images'),
                leading: Icon(Icons.image),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(onPressed: () {}, child: Text('Выход')),
                      ElevatedButton(
                          onPressed: () {}, child: Text('Регистрация')),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),
            ],
          ),
        ),
        endDrawer: Drawer(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blue,
                  backgroundImage: NetworkImage(
                      'https://cdn-icons-png.flaticon.com/512/147/147133.png'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Text('Username'),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          // shape: CircularNotchedRectangle(),
          // clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            currentIndex: _selectedPage,
            onTap: (int index) {
              setState(() {
                _tabController.index = index;
                _selectedPage = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.photo),
                label: 'Photo',
                backgroundColor: Colors.blue,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Chat',
                backgroundColor: Colors.blue,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.album),
                label: 'Albums',
                backgroundColor: Colors.blue,
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: toggleBottomSheet,
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Container(
              color: Colors.green,
              child: Center(child: Text('Screen Photo')),
            ),
            Container(
              color: Colors.red,
              child: Center(child: Text('Screen Chat')),
            ),
            Container(
              color: Colors.yellow,
              child: Center(child: Text('Screen Albums')),
            ),
          ],
        ));
  }
}
