import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Make sure to import Google Fonts package

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  QuizState createState() => QuizState();
}

class QuizState extends State<Quiz> {
  int currentQuestionIndex = 0;
  String? selectedAnswer;
  bool? isCorrect;

  final List<Map<String, dynamic>> questions = [
    {
      'question':
          'Qual destes animais é conhecido por sua impressionante capacidade de mudar de cor?',
      'answers': ['Golfinho', 'Polvo', 'Tubarão', 'Baleia'],
      'correctAnswer': 'Polvo',
    },
    {
      'question':
          'Qual animal marinho é famoso por sua carapaça dura e longa vida?',
      'answers': [
        'Baleia Azul',
        'Caranguejo',
        'Tartaruga Marinha',
        'Estrela do Mar'
      ],
      'correctAnswer': 'Tartaruga Marinha',
    },
    // Add more questions as needed
  ];

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      // End of the quiz, handle logic here if needed
      // You can navigate to a results screen or show a dialog
      // Add your logic here...
      // Reset the quiz to the initial state
      currentQuestionIndex = 0;
    }
  }

  void handleAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      isCorrect = answer == questions[currentQuestionIndex]['correctAnswer'];
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        // Reset to the next question state
        selectedAnswer = null;
        isCorrect = null;

        nextQuestion(); // Call nextQuestion() to move to the next question
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentQuestion = questions[currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz marítimo!',
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.deepPurple[50],
            width: double.infinity,
            height: 400,
            child: Text(
              currentQuestion['question'], // Corrected the key name
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Wrap(
            children: questions[currentQuestionIndex]['answers']
                .map<Widget>((resposta) {
              bool isSelected = selectedAnswer == resposta;
              Color? buttonColor;

              if (isSelected) {
                buttonColor = isCorrect != null
                    ? (isCorrect! ? Colors.green : Colors.red)
                    : null;
              }

              return meuBtn(
                  resposta, () => handleAnswer(resposta), buttonColor);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget meuBtn(String resposta, VoidCallback onPressed, Color? buttonColor) =>
      Container(
        margin: const EdgeInsets.all(16),
        width: 160,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(resposta),
          style: ElevatedButton.styleFrom(
            primary: buttonColor,
          ),
        ),
      );
}
