import 'package:flutter/material.dart';
import 'dart:async';
import 'ResultsScreen.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int _totalQuestions = 10; // Only 10 questions will be presented
  Timer? _timer;
  int _start = 600; // 10 minutes timer (600 seconds)
  List<Map<String, dynamic>> _questions = [];
  List<String?> _selectedAnswers = List<String?>.filled(10, null);
  int _correctAnswers = 0;

  @override
  void initState() {
    super.initState();
    _questions = _getRandomQuestions();
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  List<Map<String, dynamic>> _getRandomQuestions() {
    List<Map<String, dynamic>> shuffledQuestions = List.from(_allQuestions);
    shuffledQuestions.shuffle();
    return shuffledQuestions.take(_totalQuestions).toList();
  }

  void _nextQuestion() {
    if (_currentIndex < _totalQuestions - 1) {
      setState(() {
        _currentIndex++;
      });
    }
  }

  void _prevQuestion() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  void _submitQuiz() {
    _calculateResults();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsScreen(
          correctAnswers: _correctAnswers,
          totalQuestions: _totalQuestions,
          questions: _questions,
          selectedAnswers: _selectedAnswers,
        ),
      ),
    );
  }

  void _calculateResults() {
    _correctAnswers = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (_questions[i]['answer'] == _selectedAnswers[i]) {
        _correctAnswers++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "${(_start ~/ 60).toString().padLeft(2, '0')}:${(_start % 60).toString().padLeft(2, '0')}",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: (_currentIndex + 1) / _totalQuestions,
              backgroundColor: Colors.grey[300],
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Text(
              "Question ${_currentIndex + 1}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              _questions[_currentIndex]['question']!,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ..._questions[_currentIndex]['options']!.map((option) {
              return RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: _selectedAnswers[_currentIndex],
                onChanged: (value) {
                  setState(() {
                    _selectedAnswers[_currentIndex] = value;
                  });
                },
              );
            }).toList(),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _prevQuestion,
                  child: Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: _currentIndex == _totalQuestions - 1
                      ? _submitQuiz
                      : _nextQuestion,
                  child: Text(_currentIndex == _totalQuestions - 1
                      ? 'Submit Quiz'
                      : 'Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> _allQuestions = [
    {
      'question': 'Which of the following is a common symptom of concussion?',
      'options': [
        'Loss of consciousness',
        'Confusion',
        'Headache',
        'All of the above'
      ],
      'answer': 'All of the above',
    },
    {
      'question': 'What does PTSD stand for?',
      'options': [
        'Post-Traumatic Stress Disorder',
        'Pre-Traumatic Stress Disorder',
        'Post-Treatment Stress Disorder',
        'Pre-Treatment Stress Disorder'
      ],
      'answer': 'Post-Traumatic Stress Disorder',
    },
    {
      'question': 'Which of these is NOT a typical symptom of PTSD?',
      'options': [
        'Intrusive memories',
        'Avoidance behaviors',
        'Improved concentration',
        'Negative changes in mood'
      ],
      'answer': 'Improved concentration',
    },
    {
      'question': 'Which type of brain injury is caused by a blow to the head?',
      'options': [
        'Concussion',
        'Stroke',
        'Aneurysm',
        'Alzheimer\'s disease'
      ],
      'answer': 'Concussion',
    },
    {
      'question': 'How long do concussion symptoms usually last?',
      'options': [
        'A few hours',
        'A few days to weeks',
        'Several months',
        'Permanently'
      ],
      'answer': 'A few days to weeks',
    },
    {
      'question': 'Which diagnostic tool is most commonly used to assess a concussion?',
      'options': [
        'MRI',
        'CT scan',
        'X-ray',
        'PET scan'
      ],
      'answer': 'CT scan',
    },
    {
      'question': 'Which of the following can be a trigger for PTSD?',
      'options': [
        'War experiences',
        'Natural disasters',
        'Serious accidents',
        'All of the above'
      ],
      'answer': 'All of the above',
    },
    {
      'question': 'Which therapy is most commonly used to treat PTSD?',
      'options': [
        'Cognitive Behavioral Therapy',
        'Electroconvulsive Therapy',
        'Dialectical Behavior Therapy',
        'Physical Therapy'
      ],
      'answer': 'Cognitive Behavioral Therapy',
    },
    {
      'question': 'What is a common emotional symptom of TBI?',
      'options': [
        'Mood swings',
        'Euphoria',
        'Lack of emotion',
        'Heightened focus'
      ],
      'answer': 'Mood swings',
    },
    {
      'question': 'Which of these is a common cause of TBI?',
      'options': [
        'Falls',
        'Car accidents',
        'Sports injuries',
        'All of the above'
      ],
      'answer': 'All of the above',
    },
    {
      'question': 'Which of these is a common physical symptom of concussion?',
      'options': [
        'Nausea or vomiting',
        'Ringing in the ears',
        'Fatigue',
        'All of the above'
      ],
      'answer': 'All of the above',
    },
    {
      'question': 'What percentage of concussions result in a loss of consciousness?',
      'options': [
        '10%',
        '50%',
        '70%',
        '100%'
      ],
      'answer': '10%',
    },
    {
      'question': 'What is the first step in managing a concussion?',
      'options': [
        'Rest',
        'Medication',
        'Surgery',
        'Physical therapy'
      ],
      'answer': 'Rest',
    },
    {
      'question': 'Which of these is NOT a cognitive symptom of TBI?',
      'options': [
        'Memory problems',
        'Difficulty concentrating',
        'Easily distracted',
        'Improved learning ability'
      ],
      'answer': 'Improved learning ability',
    },
    {
      'question': 'What is the purpose of baseline testing in concussion management?',
      'options': [
        'To assess the severity of the injury',
        'To measure brain function before an injury occurs',
        'To diagnose concussion',
        'To monitor recovery progress'
      ],
      'answer': 'To measure brain function before an injury occurs',
    },
    {
      'question': 'Which of the following is a sign of a more severe TBI?',
      'options': [
        'Prolonged loss of consciousness',
        'Persistent headache',
        'Dizziness',
        'Nausea'
      ],
      'answer': 'Prolonged loss of consciousness',
    },
    {
      'question': 'Which of the following factors can increase the risk of developing PTSD?',
      'options': [
        'Lack of social support',
        'History of mental illness',
        'Prolonged exposure to trauma',
        'All of the above'
      ],
      'answer': 'All of the above',
    },
    {
      'question': 'Which type of TBI is characterized by bruising of the brain tissue?',
      'options': [
        'Concussion',
        'Contusion',
        'Diffuse axonal injury',
        'Penetrating injury'
      ],
      'answer': 'Contusion',
    },
    {
      'question': 'Which symptom is most commonly associated with mild TBI?',
      'options': [
        'Severe headache',
        'Brief loss of consciousness',
        'Coma',
        'Seizures'
      ],
      'answer': 'Brief loss of consciousness',
    },
    {
      'question': 'Which type of imaging is most effective for detecting diffuse axonal injury?',
      'options': [
        'CT scan',
        'MRI',
        'X-ray',
        'Ultrasound'
      ],
      'answer': 'MRI',
    },
    {
      'question': 'Which of these symptoms suggests that MRI is indicated for a concussion?',
      'options': [
        'Brief loss of consciousness',
        'Focal neurologic examination findings',
        'Prolonged symptoms > 7 days',
        'Seizures related to trauma'
      ],
      'answer': 'Seizures related to trauma',
    },
    {
      'question': 'Which age group is most at risk for concussions?',
      'options': [
        'Children (0-14 years)',
        'Adolescents (15-19 years)',
        'Adults (20-39 years)',
        'Elderly (65+ years)'
      ],
      'answer': 'Adolescents (15-19 years)',
    },
    {
      'question': 'What is the Glasgow Coma Scale used for?',
      'options': [
        'To assess the severity of TBI',
        'To measure blood pressure',
        'To diagnose PTSD',
        'To monitor brain waves'
      ],
      'answer': 'To assess the severity of TBI',
    },
    {
      'question': 'Which neurotransmitter is most commonly associated with PTSD?',
      'options': [
        'Serotonin',
        'Dopamine',
        'Norepinephrine',
        'Acetylcholine'
      ],
      'answer': 'Norepinephrine',
    },
    {
      'question': 'Which of these is a common long-term effect of TBI?',
      'options': [
        'Chronic headaches',
        'Seizures',
        'Personality changes',
        'All of the above'
      ],
      'answer': 'All of the above',
    },
    {
      'question': 'Which of these is a hallmark of PTSD?',
      'options': [
        'Re-experiencing the traumatic event',
        'Elevated mood',
        'Increased social interactions',
        'Enhanced memory recall'
      ],
      'answer': 'Re-experiencing the traumatic event',
    },
    {
      'question': 'What type of brain injury involves tearing of brain structures due to rotational forces?',
      'options': [
        'Contusion',
        'Diffuse axonal injury',
        'Concussion',
        'Subdural hematoma'
      ],
      'answer': 'Diffuse axonal injury',
    },
    {
      'question': 'What is the primary focus of treatment immediately following a severe TBI?',
      'options': [
        'Surgical intervention',
        'Stabilizing vital functions',
        'Physical therapy',
        'Cognitive rehabilitation'
      ],
      'answer': 'Stabilizing vital functions',
    },
    {
      'question': 'Which of the following is a common symptom of PTSD in veterans?',
      'options': [
        'Nightmares',
        'Flashbacks',
        'Hypervigilance',
        'All of the above'
      ],
      'answer': 'All of the above',
    },
    {
      'question': 'What is the most common cause of TBI in older adults?',
      'options': [
        'Falls',
        'Car accidents',
        'Sports injuries',
        'Violence'
      ],
      'answer': 'Falls',
    },
    {
      'question': 'Which of these treatments is often recommended for PTSD?',
      'options': [
        'EMDR (Eye Movement Desensitization and Reprocessing)',
        'Insulin therapy',
        'Radiation therapy',
        'Chemotherapy'
      ],
      'answer': 'EMDR (Eye Movement Desensitization and Reprocessing)',
    },
    {
      'question': 'What is the purpose of neuroimaging in the context of TBI?',
      'options': [
        'To visualize brain structure and detect injury',
        'To treat brain injuries',
        'To prevent brain injuries',
        'To enhance cognitive function'
      ],
      'answer': 'To visualize brain structure and detect injury',
    },
    {
      'question': 'Which of these is a known risk factor for PTSD?',
      'options': [
        'Previous trauma exposure',
        'High levels of social support',
        'Positive coping strategies',
        'None of the above'
      ],
      'answer': 'Previous trauma exposure',
    },
    {
      'question': 'Which of these is a cognitive-behavioral symptom of PTSD?',
      'options': [
        'Avoidance of reminders of the trauma',
        'Increased interest in hobbies',
        'Improved focus and concentration',
        'Enhanced memory'
      ],
      'answer': 'Avoidance of reminders of the trauma',
    },
    {
      'question': 'Which of the following is a potential outcome of repeated concussions?',
      'options': [
        'Chronic traumatic encephalopathy (CTE)',
        'Improved brain function',
        'Decreased likelihood of brain injury',
        'Increased IQ'
      ],
      'answer': 'Chronic traumatic encephalopathy (CTE)',
    },
    {
      'question': 'Which medication is commonly prescribed to help manage PTSD symptoms?',
      'options': [
        'Selective serotonin reuptake inhibitors (SSRIs)',
        'Antibiotics',
        'Anti-inflammatory drugs',
        'Chemotherapy agents'
      ],
      'answer': 'Selective serotonin reuptake inhibitors (SSRIs)',
    },
    {
      'question': 'Which of these brain regions is most involved in the fear response seen in PTSD?',
      'options': [
        'Amygdala',
        'Hippocampus',
        'Cerebellum',
        'Thalamus'
      ],
      'answer': 'Amygdala',
    },
    {
      'question': 'Which of the following is true about mild TBI (concussion)?',
      'options': [
        'Most people fully recover',
        'It always leads to permanent brain damage',
        'It usually requires surgery',
        'It is not a serious condition'
      ],
      'answer': 'Most people fully recover',
    },
    {
      'question': 'What is the primary function of the hippocampus, which can be affected by PTSD?',
      'options': [
        'Memory formation',
        'Movement control',
        'Language processing',
        'Emotional regulation'
      ],
      'answer': 'Memory formation',
    },
  ];
}
