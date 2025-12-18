import '../data/questions_easy.dart';
import '../../models/question_model.dart';
import 'blood_logic.dart';
import 'score_manager.dart';

class GameController {
  final List<GameQuestion> _questions = easyQuestions; // sementara easy dulu
  final BloodLogic bloodLogic = BloodLogic();
  final ScoreManager scoreManager = ScoreManager();

  int _currentIndex = 0;
  bool _isGameOver = false;

  GameQuestion get currentQuestion => _questions[_currentIndex];
  int get currentIndex => _currentIndex + 1;
  int get totalQuestions => _questions.length;
  bool get isGameOver => _isGameOver;

  int get bloodLevel => bloodLogic.bloodLevel;
  String get bloodStatusText => bloodLogic.statusText;
  int get bloodStatusType => bloodLogic.statusType; // 0 low,1 normal,2 high
  int get score => scoreManager.score;
  String get scoreLabel => scoreManager.scoreLabel;

  /// dipanggil ketika user pilih jawaban
  void answer(GameOption option) {
    if (_isGameOver) return;

    final before = bloodLogic.bloodLevel;
    bloodLogic.applyDelta(option.bloodDelta);
    final after = bloodLogic.bloodLevel;

    scoreManager.addScore(
      previousBlood: before,
      newBlood: after,
    );

    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
    } else {
      _isGameOver = true;
    }
  }

  void reset() {
    _currentIndex = 0;
    _isGameOver = false;
    bloodLogic.bloodLevel = 50;
    scoreManager.score = 0;
    scoreManager.questionsAnswered = 0;
  }
}
