import 'package:flutter/material.dart';

void main() => runApp(const GradesApp());

class GradesApp extends StatelessWidget {
  const GradesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
      builder: (context, child) =>
          Directionality(textDirection: TextDirection.rtl, child: child!),
      home: const GradesScreen(),
    );
  }
}

class Student {
  final String name;
  int grade;
  Student(this.name, this.grade);
}

class GradesScreen extends StatefulWidget {
  const GradesScreen({super.key});

  @override
  State<GradesScreen> createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {
  final students = [
    Student('נועה', 92),
    Student('דנה', 71),
    Student('יוסף', 54),
    Student('עומר', 48),
  ];
  bool descending = true;

  double get average =>
      students.fold(0, (sum, s) => sum + s.grade) / students.length;

  void changeGrade(Student s, int delta) =>
      setState(() => s.grade = (s.grade + delta).clamp(0, 100));

  void toggleSort() => setState(() {
        descending = !descending;
        students.sort((a, b) =>
            descending ? b.grade.compareTo(a.grade) : a.grade.compareTo(b.grade));
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ממוצע: ${average.toStringAsFixed(1)}'),
        actions: [
          IconButton.filledTonal(
            icon: const Icon(Icons.sort),
            tooltip: descending ? 'מיון עולה' : 'מיון יורד',
            onPressed: toggleSort,
          ),
        ],
      ),
      body: ListView(
        children: [
          for (final s in students)
            ListTile(
              leading: s.grade >= 60
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : const Icon(Icons.cancel, color: Colors.red),
              title: Text(s.name),
              subtitle: Text('ציון: ${s.grade}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => changeGrade(s, -1),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => changeGrade(s, 1),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
