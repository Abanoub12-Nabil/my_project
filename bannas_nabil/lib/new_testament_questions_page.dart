import 'package:flutter/material.dart';
import 'package:Holy_Bible/custom_drawer.dart';
import 'matthew_questions_page.dart';
import 'mark_questions_page.dart';
import 'luke_questions_page.dart';
import 'john_questions_page.dart';
import 'acts_questions_page.dart';
import 'romans_questions_page.dart';
import 'firstCorinthians_questions_page.dart';
import 'secondCorinthians_questions_page.dart';
import 'galatians_questions_page.dart';
import 'ephesians_questions_page.dart';
import 'philippians_questions_page.dart';
import 'colossians_questions_page.dart';
import 'firstThessalonians_questions_page.dart';
import 'secondThessalonians_questions_page.dart';
import 'firstTimothy_questions_page.dart';
import 'secondTimothy_questions_page.dart';
import 'titus_questions_page.dart';
import 'philemon_questions_page.dart';
import 'hebrews_questions_page.dart';
import 'james_questions_page.dart';
import 'firstPeter_questions_page.dart';
import 'secondPeter_questions_page.dart';
import 'firstJohn_questions_page.dart';
import 'secondJohn_questions_page.dart';
import 'thirdJohn_questions_page.dart';
import 'jude_questions_page.dart';
import 'revelation_questions_page.dart';

class NewTestamentQuestionsPage extends StatelessWidget {
  final List<Map<String, dynamic>> _questionsPages = [
    {'title': 'انجيل متي', 'page': const MatthewQuestionsPage()},
    {'title': 'انجيل مرقس', 'page': const MarkQuestionsPage()},
    {'title': 'انجيل لوقا', 'page': const LukeQuestionsPage()},
    {'title': 'انجيل يوحنا', 'page': const JohnQuestionsPage()},
    {'title': 'سفر أعمال الرسل', 'page': const ActsQuestionsPage()},
    {'title': 'الرسالة إلي رومية', 'page': const RomansQuestionsPage()},
    {
      'title': 'الرسالة الأولي إلي كورنثوس',
      'page': const FirstCorinthiansQuestionsPage()
    },
    {
      'title': 'الرسالة الثانية إلي كورنثوس',
      'page': const SecondCorinthiansQuestionsPage()
    },
    {'title': 'الرسالة إلي غلاطية', 'page': const GalatiansQuestionsPage()},
    {'title': 'الرسالة إلي أفسس', 'page': const EphesiansQuestionsPage()},
    {'title': 'الرسالة إلي فيلبي', 'page': const PhilippiansQuestionsPage()},
    {'title': 'الرسالة إلي كولوسي', 'page': const ColossiansQuestionsPage()},
    {
      'title': 'الرسالة الأولي إلي تسالونيكي',
      'page': const FirstThessaloniansQuestionsPage()
    },
    {
      'title': 'الرسالة الثانية إلي تسالونيكي',
      'page': const SecondThessaloniansQuestionsPage()
    },
    {
      'title': 'الرسالة الأولي إلي تيموثاوس',
      'page': const FirstTimothyQuestionsPage()
    },
    {
      'title': 'الرسالة الثانية إلي تيموثاوس',
      'page': const SecondTimothyQuestionsPage()
    },
    {'title': 'الرسالة إلي تيطس', 'page': const TitusQuestionsPage()},
    {'title': 'الرسالة إلي فليمون', 'page': const PhilemonQuestionsPage()},
    {'title': 'الرسالة إلي العبرانيين', 'page': const HebrewsQuestionsPage()},
    {'title': 'رسالة يعقوب', 'page': const JamesQuestionsPage()},
    {'title': 'رسالة بطرس الأولي', 'page': const FirstPeterQuestionsPage()},
    {'title': 'رسالة بطرس الثانية', 'page': const SecondPeterQuestionsPage()},
    {'title': 'رسالة يوحنا الأولي', 'page': const FirstJohnQuestionsPage()},
    {'title': 'رسالة يوحنا الثانية', 'page': const SecondJohnQuestionsPage()},
    {'title': 'رسالة يوحنا الثالثة', 'page': const ThirdJohnQuestionsPage()},
    {'title': 'رسالة يهوذا', 'page': const JudeQuestionsPage()},
    {'title': 'رؤيا يوحنا اللاهوتي', 'page': const RevelationQuestionsPage()},
  ];

  NewTestamentQuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('أسئلة العهد الجديد'),
        backgroundColor:  Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: _QuestionsSearchDelegate(_questionsPages),
              );
            },
          ),
        ],
      ),
      drawer: CustomDrawer(),
    body: Container(
    decoration: BoxDecoration(
    image: DecorationImage(
    image: const AssetImage('assets/images/back.jpg'),
    fit: BoxFit.fill,
    colorFilter: ColorFilter.mode(
    Colors.black.withOpacity(0.3), // اللون الذي تريده
    BlendMode.darken, // وضع المزج لدمج اللون مع الصورة
    ),
    ),
    ),
      child: ListView(
        padding: const EdgeInsets.all(8.0),
        children: _questionsPages.map((item) {
          return _buildListTile(
              context, item['title'], Icons.book, item['page']);
        }).toList(),
      ),
    )
    );
  }

  Widget _buildListTile(
      BuildContext context, String title, IconData icon, Widget page) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: const Icon(Icons.book,color: Color(0xff769590)),
        title: Text(title,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ),
          );
        },
      ),
    );
  }
}

class _QuestionsSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> questionsPages;

  _QuestionsSearchDelegate(this.questionsPages);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = questionsPages.where((page) {
      return page['title'].toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView(
      children: results.map((item) {
        return ListTile(
          leading: const Icon(
            Icons.book,
            color: Color(0xff769590),
          ),
          title: Text(item['title']),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => item['page'],
              ),
            );
          },
        );
      }).toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = questionsPages.where((page) {
      return page['title'].toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView(
      children: suggestions.map((item) {
        return ListTile(
          leading: const Icon(
            Icons.book,
            color: Color(0xff769590),
          ),
          title: Text(item['title']),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => item['page'],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
