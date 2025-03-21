class CarbonData {
  static final List<Map<String, dynamic>> questions = [
    {
      'question': 'How many times have you traveled this year?',
      'options': {'Very frequently': 2.5, 'Moderate': 1.5, 'Rarely': 0.5},
    },
    {
      'question': 'What type of vehicle do you use the most?',
      'options': {'Car': 3.0, 'Bike': 0.5, 'Public Transport': 1.0},
    },
    {
      'question': 'How often do you eat meat?',
      'options': {'Daily': 3.0, 'Few times a week': 1.5, 'Rarely': 0.5},
    },
    {
      'question': 'How do you cool your home?',
      'options': {'AC always on': 4.0, 'Sometimes': 2.0, 'Rarely': 0.5},
    },
    {
      'question': 'How much electricity do you use monthly?',
      'options': {'High usage': 3.5, 'Moderate': 2.0, 'Low usage': 0.8},
    },
    {
      'question': 'How often do you buy new clothes?',
      'options': {'Very often': 2.5, 'Sometimes': 1.5, 'Rarely': 0.5},
    },
    {
      'question': 'Do you recycle waste regularly?',
      'options': {'Always': 0.5, 'Sometimes': 1.5, 'Never': 3.0},
    },
    {
      'question': 'Do you use energy-efficient appliances?',
      'options': {'Yes': 0.5, 'Some': 1.5, 'No': 3.0},
    },
    {
      'question': 'How do you heat your home?',
      'options': {'Gas': 2.5, 'Electric': 3.5, 'Solar': 0.5},
    },
    {
      'question': 'Do you compost food waste?',
      'options': {'Yes': 0.5, 'No': 3.0},
    },
    {
      'question': 'How often do you travel by plane?',
      'options': {'Often': 4.0, 'Sometimes': 2.5, 'Rarely': 1.0},
    },
    {
      'question': 'Do you use plastic bags frequently?',
      'options': {'Yes': 2.5, 'Sometimes': 1.5, 'No': 0.5},
    },
  ];

  static double calculateScore(List<double> responses) {
    return responses.reduce((a, b) => a + b);
  }
}
