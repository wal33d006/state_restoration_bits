import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:state_restoration_bits/search_page.dart';

void main() {
  runApp(
    RootRestorationScope(
      child: MyApp(),
      restorationId: 'root',
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'State restoration'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with RestorationMixin {
  final RestorableInt _scrollIndex = RestorableInt(0);

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  final List<Email> users = [
    Email(
      title: 'Flutter Karachi',
      day: 'Friday',
      subject: 'Fluttering',
      description: 'Let\'s get into code with Flutter',
    ),
    Email(
      title: 'Google',
      day: 'Monday',
      subject: 'Security alert',
      description: 'New device signed in to your google account',
    ),
    Email(
      title: 'Waleed',
      day: 'Saturday',
      subject: 'State restoration',
      description: 'Some tips and tricks regarding state restoration',
    ),
    Email(
      title: 'Amazon',
      day: 'Tuesday',
      subject: 'Order update',
      description: 'Your order has been confirmed',
    ),
    Email(
      title: 'Daraz',
      day: 'Wednesday',
      subject: 'Refund successful',
      description:
          'You have been refunded your order against the tracking number 456635872354.',
    ),
    Email(
      title: 'Netflix',
      day: 'Saturday',
      subject: 'Coming soon!',
      description:
          'Blacklist season 8, and 6 other shows are coming soon on Netflix',
    ),
    Email(
      title: 'Adobe',
      day: 'Sunday',
      subject: 'Security profile changed',
      description:
          'Your security profile has been changed. A new phone number has been added to your profile.',
    ),
    Email(
      title: 'Azure DevOps',
      day: 'Monday',
      subject: 'Build failed',
      description:
          'Your build named Flutter Karachi has failed. Click here to view the details.',
    ),
    Email(
      title: 'GitHub',
      day: 'Tuesday',
      subject: 'New comment on issue',
      description: 'Issue 2343 has a new comment on your repository.',
    ),
    Email(
      title: 'TestFlight',
      day: 'Friday',
      subject: 'Flutter Pakistan (early access) 1.0.5',
      description:
          'Flutter Pakistan is available to test on your Test Flight application',
    ),
    Email(
      title: 'App Center Team',
      day: 'Saturday',
      subject: 'Build successful',
      description:
          'A new version of Flutter Pakistan is available on the Play Store to test.',
    ),
  ];

  @override
  void initState() {
    _scrollToIndex();
    super.initState();
  }

  void _scrollToIndex() async {
    await Future.delayed(Duration(milliseconds: 500));
    itemScrollController.scrollTo(
      index: _scrollIndex.value,
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
    itemPositionsListener.itemPositions.addListener(() {
      _scrollIndex.value =
          itemPositionsListener.itemPositions.value.first.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SearchPage(),
                  ),
                );
              }),
        ],
      ),
      body: ScrollablePositionedList.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          var user = users[index];
          String initials = '';
          if (user.title.contains(' ')) {
            initials =
                user.title.split(' ')[0][0] + user.title.split(' ')[1][0];
          } else {
            initials = user.title[0];
          }
          return Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  child: Text(
                    initials.toUpperCase(),
                  ),
                ),
                title: Text(user.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.subject,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user.description,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                trailing: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2)),
                  child: Text(
                    user.day,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
//            isThreeLine: true,
              ),
              Divider(),
            ],
          );
        },
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
      ),
    );
  }

  @override
  // TODO: implement restorationId
  String get restorationId => 'scroll_view';

  @override
  void restoreState(RestorationBucket oldBucket, bool initialRestore) {
    registerForRestoration(_scrollIndex, 'scroll_index');
  }
}

class Email {
  final String title;
  final String description;
  final String subject;
  final String day;

  Email({
    this.title,
    this.day,
    this.subject,
    this.description,
  });
}
