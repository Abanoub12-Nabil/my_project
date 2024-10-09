import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotebookPage extends StatefulWidget {
  const NotebookPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotebookPageState createState() => _NotebookPageState();
}

class _NotebookPageState extends State<NotebookPage> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _savedTexts = [];
  List<Map<String, String>> _filteredTexts = [];
  double _fontSize = 16.0;
  final String _fontFamily = 'Roboto';
  String _currentText = '';
  Color _fontColor = Colors.black;

  @override
  void initState() {
    super.initState();
    _loadSavedTexts();
  }

  Future<void> _loadSavedTexts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedData = prefs.getStringList('notebookTexts');
    if (savedData != null) {
      setState(() {
        _savedTexts = savedData.map((entry) {
          List<String> parts = entry.split('|');
          return {
            'text': parts[0],
            'date': parts[1],
            'time': parts[2],
          };
        }).toList();
        _filteredTexts = List.from(_savedTexts);
      });
    }
  }

  Future<void> _saveText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_currentText.isNotEmpty) {
      DateTime now = DateTime.now().toLocal();
      String saveDate = now.toString().split(' ')[0];
      String saveTime = _formatTime(now);
      setState(() {
        _savedTexts.add({
          'text': _currentText,
          'date': saveDate,
          'time': saveTime,
        });
        _filteredTexts =
            List.from(_savedTexts); // Update filtered list immediately
      });
      List<String> savedData = _savedTexts.map((entry) {
        return '${entry['text']}|${entry['date']}|${entry['time']}';
      }).toList();
      prefs.setStringList('notebookTexts', savedData);
      _controller.clear();
      _currentText = '';
    }
  }

  Future<void> _clearText() async {
    setState(() {
      _controller.clear();
      _currentText = '';
    });
  }

  Future<void> _removeSavedText(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedTexts.removeAt(index);
      _filteredTexts.removeAt(index); // Remove from filtered list as well
      List<String> savedData = _savedTexts.map((entry) {
        return '${entry['text']}|${entry['date']}|${entry['time']}';
      }).toList();
      prefs.setStringList('notebookTexts', savedData);
    });
  }

  void _viewTextDetails(Map<String, String> entry) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TextDetailsPage(
          text: entry['text']!,
          date: entry['date']!,
          time: entry['time']!,
          initialFontSize: _fontSize,
        ),
      ),
    ).then((newFontSize) {
      if (newFontSize != null) {
        setState(() {
          _fontSize = newFontSize;
        });
      }
    });
  }

  void _searchText(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredTexts = List.from(_savedTexts);
      } else {
        _filteredTexts = _savedTexts
            .where((entry) =>
            entry['text']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  String _formatTime(DateTime dateTime) {
    int hour = dateTime.hour;
    String period = hour >= 12 ? 'مساءً' : 'صباحًا';
    hour = hour % 12;
    hour = hour == 0 ? 12 : hour;
    String minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المفكرة'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value.startsWith('color_')) {
                setState(() {
                  _fontColor = Color(int.parse(value.split('_')[1]));
                });
              } else if (value.startsWith('fontSize_')) {
                setState(() {
                  _fontSize = double.parse(value.split('_')[1]);
                });
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'color_0xFF000000', // black
                child: Text('لون الخط: أسود'),
              ),
              const PopupMenuItem(
                value: 'color_0xFF0000FF', // blue
                child: Text('لون الخط: أزرق'),
              ),
              const PopupMenuItem(
                value: 'color_0xFFFF0000', // red
                child: Text('لون الخط: أحمر'),
              ),
              const PopupMenuItem(
                value: 'color_0xFF00FF00', // green
                child: Text('لون الخط: أخضر'),
              ),
              const PopupMenuItem(
                value: 'fontSize_14.0',
                child: Text('حجم الخط: 14'),
              ),
              const PopupMenuItem(
                value: 'fontSize_16.0',
                child: Text('حجم الخط: 16'),
              ),
              const PopupMenuItem(
                value: 'fontSize_18.0',
                child: Text('حجم الخط: 18'),
              ),
              const PopupMenuItem(
                value: 'fontSize_20.0',
                child: Text('حجم الخط: 20'),
              ),
              const PopupMenuItem(
                value: 'fontSize_22.0',
                child: Text('حجم الخط: 22'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'اكتب ملاحظاتك هنا...',
                border: OutlineInputBorder(),
              ),
              style: TextStyle(
                fontSize: _fontSize,
                fontFamily: _fontFamily,
                color: _fontColor,
              ),
              onChanged: (value) {
                setState(() {
                  _currentText = value;
                });
              },
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _saveText,
                  child: const Text('حفظ النص'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _clearText,
                  child: const Text('مسح النص'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'ابحث في النصوص...',
                border: OutlineInputBorder(),
              ),
              onChanged: _searchText,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredTexts.length,
                itemBuilder: (context, index) {
                  final entry = _filteredTexts[index];
                  return ListTile(
                    title: Text(
                      entry['text']!,
                      style: TextStyle(
                        fontSize: _fontSize,
                        fontFamily: _fontFamily,
                        color: _fontColor,
                      ),
                    ),
                    subtitle: Text('${entry['date']} ${entry['time']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _removeSavedText(index),
                    ),
                    onTap: () => _viewTextDetails(entry),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextDetailsPage extends StatefulWidget {
  final String text;
  final String date;
  final String time;
  final double initialFontSize;

  const TextDetailsPage({
    super.key,
    required this.text,
    required this.date,
    required this.time,
    required this.initialFontSize,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TextDetailsPageState createState() => _TextDetailsPageState();
}

class _TextDetailsPageState extends State<TextDetailsPage> {
  late double _fontSize;

  @override
  void initState() {
    super.initState();
    _fontSize = widget.initialFontSize;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل النص'),
        actions: [
          PopupMenuButton<double>(
            onSelected: (value) {
              setState(() {
                _fontSize = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 14.0,
                child: Text('حجم الخط: 14'),
              ),
              const PopupMenuItem(
                value: 16.0,
                child: Text('حجم الخط: 16'),
              ),
              const PopupMenuItem(
                value: 18.0,
                child: Text('حجم الخط: 18'),
              ),
              const PopupMenuItem(
                value: 20.0,
                child: Text('حجم الخط: 20'),
              ),
              const PopupMenuItem(
                value: 22.0,
                child: Text('حجم الخط: 22'),
              ),
              const PopupMenuItem(
                value: 24.0,
                child: Text('حجم الخط: 24'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text,
              style: TextStyle(
                fontSize: _fontSize,
              ),
            ),
            const SizedBox(height: 16),
            Text('تاريخ: ${widget.date}'),
            Text('وقت: ${widget.time}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, _fontSize);
        },
        tooltip: 'حفظ حجم الخط',
        child: const Icon(Icons.save),
      ),
    );
  }
}
