import 'package:flutter/material.dart';
import 'package:Holy_Bible/custom_drawer.dart';
import 'genesis_questions_page.dart';
import 'exodus_questions_page.dart';
import 'leviticus_questions_page.dart';
import 'numbers_questions_page.dart';
import 'deuteronomy_questions_page.dart';
import 'joshua_questions_page.dart';
import 'judges_questions_page.dart';
import 'ruth_questions_page.dart';
import 'firstSamuel_questions_page.dart';
import 'secondSamuel_questions_page.dart';
import 'firstKings_questions_page.dart';
import 'secondKings_questions_page.dart';
import 'firstChronicles_questions_page.dart';
import 'secondChronicles_questions_page.dart';
import 'ezra_questions_page.dart';
import 'nehemiah_questions_page.dart';
import 'tobit_questions_page.dart';
import 'judith_questions_page.dart';
import 'esther_questions_page.dart';
import 'job_questions_page.dart';
import 'psalms_questions_page.dart';
import 'proverbs_questions_page.dart';
import 'ecclesiastes_questions_page.dart';
import 'songOfSolomon_questions_page.dart';
import 'wisdom_questions_page.dart';
import 'sirach_questions_page.dart';
import 'isaiah_questions_page.dart';
import 'jeremiah_questions_page.dart';
import 'lamentations_questions_page.dart';
import 'baruch_questions_page.dart';
import 'ezekiel_questions_page.dart';
import 'daniel_questions_page.dart';
import 'hosea_questions_page.dart';
import 'joel_questions_page.dart';
import 'amos_questions_page.dart';
import 'obadiah_questions_page.dart';
import 'jonah_questions_page.dart';
import 'micah_questions_page.dart';
import 'nahum_questions_page.dart';
import 'habakkuk_questions_page.dart';
import 'zephaniah_questions_page.dart';
import 'haggai_questions_page.dart';
import 'zechariah_questions_page.dart';
import 'malachi_questions_page.dart';
import 'firstMaccabees_questions_page.dart';
import 'secondMaccabees_questions_page.dart';

class OldTestamentQuestionsPage extends StatelessWidget {
  final List<Map<String, dynamic>> _questionsPages = [
    {'title': 'سفر التكوين', 'page': const GenesisQuestionsPage()},
    {'title': 'سفر الخروج', 'page': const ExodusQuestionsPage()},
    {'title': 'سفر اللاويين', 'page': const LeviticusQuestionsPage()},
    {'title': 'سفر العدد', 'page': const NumbersQuestionsPage()},
    {'title': 'سفر التثنية', 'page': const DeuteronomyQuestionsPage()},
    {'title': 'سفر يشوع', 'page': const JoshuaQuestionsPage()},
    {'title': 'سفر القضاة', 'page': const JudgesQuestionsPage()},
    {'title': 'سفر راعوث', 'page': const RuthQuestionsPage()},
    {'title': 'سفر صموئيل الأول', 'page': const FirstSamuelQuestionsPage()},
    {'title': 'سفر صموئيل الثاني', 'page': const SecondSamuelQuestionsPage()},
    {'title': 'سفر الملوك الأول', 'page': const FirstKingsQuestionsPage()},
    {'title': 'سفر الملوك الثاني', 'page': const SecondKingsQuestionsPage()},
    {
      'title': 'سفر أخبار الأيام الأول',
      'page': const FirstChroniclesQuestionsPage()
    },
    {
      'title': 'سفر أخبار الأيام الثاني',
      'page': const SecondChroniclesQuestionsPage()
    },
    {'title': 'سفر عزرا', 'page': const EzraQuestionsPage()},
    {'title': 'سفر نحميا', 'page': const NehemiahQuestionsPage()},
    {'title': 'سفر طوبيا', 'page': const TobitQuestionsPage()},
    {'title': 'سفر يهوديت', 'page': const JudithQuestionsPage()},
    {'title': 'سفر أستير', 'page': const EstherQuestionsPage()},
    {'title': 'سفر أيوب', 'page': const JobQuestionsPage()},
    {'title': 'سفر المزامير', 'page': const PsalmsQuestionsPage()},
    {'title': 'سفر أمثال سليمان', 'page': const ProverbsQuestionsPage()},
    {'title': 'سفر الجامعة', 'page': const EcclesiastesQuestionsPage()},
    {'title': 'سفر نشيد الأنشاد', 'page': const SongOfSolomonQuestionsPage()},
    {'title': 'سفر الحكمة', 'page': const WisdomQuestionsPage()},
    {'title': 'سفر يشوع ابن سيراخ', 'page': const SirachQuestionsPage()},
    {'title': 'سفر إشعياء', 'page': const IsaiahQuestionsPage()},
    {'title': 'سفر إرميا', 'page': const JeremiahQuestionsPage()},
    {'title': 'سفر مراثي إرميا', 'page': const LamentationsQuestionsPage()},
    {'title': 'سفر باروخ', 'page': const BaruchQuestionsPage()},
    {'title': 'سفر حزقيال', 'page': const EzekielQuestionsPage()},
    {'title': 'سفر دانيال', 'page': const DanielQuestionsPage()},
    {'title': 'سفر هوشع', 'page': const HoseaQuestionsPage()},
    {'title': 'سفر يوئيل', 'page': const JoelQuestionsPage()},
    {'title': 'سفر عاموس', 'page': const AmosQuestionsPage()},
    {'title': 'سفر عوبديا', 'page': const ObadiahQuestionsPage()},
    {'title': 'سفر يونان', 'page': const JonahQuestionsPage()},
    {'title': 'سفر ميخا', 'page': const MicahQuestionsPage()},
    {'title': 'سفر ناحوم', 'page': const NahumQuestionsPage()},
    {'title': 'سفر حبقوق', 'page': const HabakkukQuestionsPage()},
    {'title': 'سفر صفنيا', 'page': const ZephaniahQuestionsPage()},
    {'title': 'سفر حجي', 'page': const HaggaiQuestionsPage()},
    {'title': 'سفر زكريا', 'page': const ZechariahQuestionsPage()},
    {'title': 'سفر ملاخي', 'page': const MalachiQuestionsPage()},
    {
      'title': 'سفر المكابيين الأول',
      'page': const FirstMaccabeesQuestionsPage()
    },
    {
      'title': 'سفر المكابيين الثاني',
      'page': const SecondMaccabeesQuestionsPage()
    },
  ];

  OldTestamentQuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('أسئلة العهد القديم'),
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
