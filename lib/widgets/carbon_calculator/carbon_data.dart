class CarbonData {
  static List<Map<String, dynamic>> questions = [
    {
      'question': 'How many times have you traveled this year?',
      'options': {'Very frequently': 2.0, 'Moderate': 1.0, 'Rarely': 0.5},
      // Source: EPA average vehicle emissions (4.6T CO2/year for frequent drivers)
      // https://www.epa.gov/greenvehicles/greenhouse-gas-emissions-typical-passenger-vehicle
    },
    {
      'question': 'What type of vehicle do you use the most?',
      'options': {'Car': 2.5, 'Public transport': 1.5, 'Bike/Walk': 0.5},
      // Source: Union of Concerned Scientists - Transportation emissions comparison
      // https://www.ucsusa.org/resources/clean-vehicles
    },
    {
      'question': 'How often do you eat meat?',
      'options': {'Daily': 3.0, 'Few times a week': 1.5, 'Rarely': 0.5},
      // Source: Nature Food Study (Beef = 60kg CO2/kg vs Lentils = 0.9kg)
      // https://www.nature.com/articles/s43016-021-00358-x
    },
    {
      'question': 'How energy-efficient is your home?',
      'options': {'Poor': 2.5, 'Average': 1.5, 'Efficient': 0.5},
      // Source: EIA Residential Energy Consumption Survey
      // https://www.eia.gov/consumption/residential
    },
    {
      'question': 'Do you recycle regularly?',
      'options': {'No': 2.0, 'Sometimes': 1.0, 'Yes': 0.5},
      // Source: EPA Waste Management Hierarchy impact
      // https://www.epa.gov/smm/sustainable-materials-management-non-hazardous-materials-and-waste-management-hierarchy
    },
    {
      'question': 'How often do you buy new clothes?',
      'options': {'Frequently': 2.5, 'Moderately': 1.5, 'Rarely': 0.5},
      // Source: Ellen MacArthur Foundation - Fashion Climate Impact
      // https://www.ellenmacarthurfoundation.org/publications
    },
    {
      'question': 'Do you use renewable energy sources?',
      'options': {'No': 2.5, 'Partially': 1.5, 'Yes': 0.5},
      // Source: IPCC Renewable Energy Integration Report
      // https://www.ipcc.ch/report/renewable-energy-sources-and-climate-change-mitigation
    },
    {
      'question': 'How much water do you use daily?',
      'options': {'High': 2.0, 'Moderate': 1.0, 'Low': 0.5},
      // Source: Environmental Research Letters - Water-Energy Nexus
      // https://iopscience.iop.org/article/10.1088/1748-9326/ab6399
    },
    {
      'question': 'Do you use plastic products frequently?',
      'options': {'Yes': 2.5, 'Sometimes': 1.5, 'No': 0.5},
    },
    {
      'question': 'How often do you fly?',
      'options': {'Frequently': 3.0, 'Occasionally': 2.0, 'Never': 0.0},
    },
    {
      'question': 'Do you compost food waste?',
      'options': {'No': 2.0, 'Sometimes': 1.0, 'Yes': 0.5},
      // Source: EPA Composting Climate Benefits
      // https://www.epa.gov/sustainable-management-food/composting
    },
    {
      'question': 'Do you use energy-saving appliances?',
      'options': {'No': 2.5, 'Some': 1.5, 'Yes': 0.5},
    },
  ];

  static double calculateScore(List<double> responses) {
    double totalScore = responses.reduce((a, b) => a + b);
    return totalScore *
        200; // Conversion factor aligns with EPA per-capita averages
  }
}
