import 'package:flutter/material.dart';
import 'package:flutter_mentor_quiz_app_tut/answer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Icon> _scoreTracker = [];
  int _questionIndex = 0;
  int _totalScore = 0;
  bool answerWasSelected = false;
  bool endOfQuiz = false;
  bool correctAnswerSelected = false;

  void _questionAnswered(bool answerScore) {
    setState(() {
      answerWasSelected = true;
      if (answerScore) {
        _totalScore++;
        correctAnswerSelected = true;
      }
      _scoreTracker.add(
        answerScore
            ? Icon(
                Icons.check_circle,
                color: Colors.green,
              )
            : Icon(
                Icons.clear,
                color: Colors.red,
              ),
      );
      if (_questionIndex + 1 == _questions.length) {
        endOfQuiz = true;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _questionIndex++;
      answerWasSelected = false;
      correctAnswerSelected = false;
    });
    if (_questionIndex >= _questions.length) {
      _resetQuiz();
    }
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      _scoreTracker = [];
      endOfQuiz = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                if (_scoreTracker.length == 0)
                  SizedBox(
                    height: 25.0,
                  ),
                if (_scoreTracker.length > 0) ..._scoreTracker
              ],
            ),
            Container(
              width: double.infinity,
              height: 130.0,
              margin: EdgeInsets.only(bottom: 10.0, left: 30.0, right: 30.0),
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  _questions[_questionIndex]['question'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ...(_questions[_questionIndex]['answers']
                    as List<Map<String, Object>>)
                .map(
              (answer) => Answer(
                answerText: answer['answerText'],
                answerColor: answerWasSelected
                    ? answer['score']
                        ? Colors.green
                        : Colors.red
                    : null,
                answerTap: () {
                  if (answerWasSelected) {
                    return;
                  }
                  _questionAnswered(answer['score']);
                },
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 40.0),
              ),
              onPressed: () {
                if (!answerWasSelected) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Выберете вариант ответа, чтобы продолжить'),
                  ));
                  return;
                }
                _nextQuestion();
              },
              child: Text(endOfQuiz ? 'Повторить' : 'Следующий вопрос'),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                '${_totalScore.toString()}/${_questions.length}',
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
              ),
            ),
            if (answerWasSelected && !endOfQuiz)
              Container(
                height: 100,
                width: double.infinity,
                color: correctAnswerSelected ? Colors.green : Colors.red,
                child: Center(
                  child: Text(
                    correctAnswerSelected ? 'Верно!' : 'Неверно!',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            if (endOfQuiz)
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    _totalScore > 4
                        ? 'Баллы: $_totalScore'
                        : 'Ваш результат: $_totalScore.',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: _totalScore > 4 ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

final _questions = const [
  {
    'question': 'Как называется данный химический элемент: Au ?',
    'answers': [
      {'answerText': 'Серебро', 'score': false},
      {'answerText': 'Золото', 'score': true},
      {'answerText': 'Железо', 'score': false},
    ],
  },
  {
    'question': 'Как называется данный химический элемент: O ?',
    'answers': [
      {'answerText': 'Азот', 'score': false},
      {'answerText': 'Водород', 'score': false},
      {'answerText': 'Кислород', 'score': true},
    ],
  },
  {
    'question': 'Как называется данный химический элемент: Na ?',
    'answers': [
      {'answerText': 'Натрий', 'score': true},
      {'answerText': 'Неон', 'score': false},
      {'answerText': 'Никель', 'score': false},
    ],
  },
  {
    'question': 'Как называется данный химический элемент: C ?',
    'answers': [
      {'answerText': 'Цезий', 'score': false},
      {'answerText': 'Углерод', 'score': true},
      {'answerText': 'Медь', 'score': false},
    ],
  },
  {
    'question': 'Как называется данный химический элемент: Cu ?',
    'answers': [
      {'answerText': 'Медь', 'score': true},
      {'answerText': 'Цинк', 'score': false},
      {'answerText': 'Алюминий', 'score': false},
    ],
  },
  {
    'question': 'Как называется данный химический элемент: Ge ?',
    'answers': [
      {'answerText': 'Германий', 'score': true},
      {'answerText': 'Гелий', 'score': false},
      {'answerText': 'Галлий', 'score': false},
    ],
  },
  {
    'question': 'Как называется данный химический элемент: Mc ?',
    'answers': [
      {'answerText': 'Московий', 'score': true},
      {'answerText': 'Майтнерий', 'score': false},
      {'answerText': 'Менделеевий', 'score': false},
    ],
  },
  {
    'question': 'Как называется данный химический элемент: Pt ?',
    'answers': [
      {'answerText': 'Фтор', 'score': false},
      {'answerText': 'Фосфор', 'score': false},
      {'answerText': 'Платина', 'score': true},
    ],
  },
  {
    'question': 'Как называется данный химический элемент: Cl ?',
    'answers': [
      {'answerText': 'Хлор', 'score': true},
      {'answerText': 'Хром', 'score': false},
      {'answerText': 'Кадмий', 'score': false},
    ],
  },
  {
    'question': 'Как называется данный химический элемент: Ra ?',
    'answers': [
      {'answerText': 'Ртуть', 'score': false},
      {'answerText': 'Радон', 'score': false},
      {'answerText': 'Радий', 'score': true},
    ],
  },
];
