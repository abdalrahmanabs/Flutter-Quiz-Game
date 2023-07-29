import 'package:quizzler/main.dart';

import 'question.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class QuizManager {
  int _currentQuestion = 0;

  int correctAnswers = 0;
  int wrongAnswers = 0;
  double percentage = 0;

  bool isFinsihed = false;

  List<Question> _questionBank = [
    Question(
        ' أول من أسلم من الصبيان هو سيدنا علي بن أبي طالب رضي الله عنه', true),
    Question('وقعت غزوة حنين في العام السابع هجري', false),
    Question(
        'الصحابي الذي كانت تأتي الملائكة على صورته هو سيدنا دحية الكلبي رضي الله عنه',
        true),
    Question(
        'الصحابي الذي جهز جيش العسرة هو سيدنا عبد الرحمن بن عوف رضي الله عنه',
        false),
    Question('العام الذي فتحت فيه القسطنطينية هجريًا هو 875".', false),
    Question(
        'العالم الذي يلقب بسلطان العلماء هو الإمام العز بن عبد السلام', true),
    Question('ولد الإمام أبو حنيفة رحمه الله في دمشق', false),
    Question('اشتهر الإمام الشافعي بأنه كان أول من أسس لعلم أصول الفقه ', true),
    Question('حجة الإسلام هو لقب الإمام ابن تيمية', false),
    Question('كان الإمام مسلم أحد طلاب الإمام البخاري ', true),
    Question(
        'قائد المسلمين في معركة القادسية هو سيدنا أبو عبيدة بن الجراح رضي الله عنه".',
        false),
    Question('من الفواكه التي ذكرت في القرآن فاكهة الموز', true),
    Question(
        'كان الخليفة سيدنا أبو بكر الصديق من أعلم الناس بأنساب العرب', true),
  ];

  void nextQuestion() {
    if (_currentQuestion < _questionBank.length - 1)
      _currentQuestion++;
    else
      isFinsihed = true;
  }

  String getQuestionText() {
    return _questionBank[_currentQuestion].questionText;
  }

  bool getQuestionAnswer() {
    return _questionBank[_currentQuestion].answer;
  }
}
