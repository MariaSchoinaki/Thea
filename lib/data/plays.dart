const rawPlayData = '''
[
  {
    "title": "Be More Chill",
    "headline": "A High-School Musical About Fitting In and Standing Out",
    "description": "This quirky musical comedy explores the anxiety of adolescence with a sci-fi twist—where a pill can make you cool, but at what cost?",
    "playwriter": "Joe Tracz & Joe Iconis",
    "cast": ["Will Roland", "Stephanie Hsu", "George Salazar"],
    "genre": "Musical Comedy",
    "runtime": "2h 10min",
    "availableDates": {
      "2024-07-10T00:00:00": {"afternoon": [], "night": []},
      "2024-07-11T00:00:00": {"afternoon": [], "night": []}
    },
    "afternoon": "17:30",
    "night": "21:00",
    "regularTickets": {
      "name": "regular",
      "price": 23,
      "availableTickets": 30,
      "soldTickets": 0
    },
    "specialNeedsTickets": {
      "name": "special needs",
      "price": 18,
      "availableTickets": 5,
      "soldTickets": 0
    },
    "hall": "Hall A",
    "ageLimit": "12+",
    "additionalInfo": "Features energetic songs and live band. Ideal for teens and young adults.",
    "hearingImpaired": true,
    "imageUrl": "assets/images/be_more_chill.jpg"
  },
  {
    "title": "A Midsummer Night’s Dream",
    "headline": "A Magical Shakespearean Romp Through Love and Chaos",
    "description": "Shakespeare’s enchanted forest comes alive with mischievous fairies, tangled lovers, and comic fools in this timeless romantic comedy.",
    "playwriter": "William Shakespeare",
    "cast": ["Lily James", "Dev Patel", "Andrew Scott"],
    "genre": "Romantic Comedy",
    "runtime": "2h 5min",
    "availableDates": {
      "2024-07-15T00:00:00": {"afternoon": [], "night": []},
      "2024-07-16T00:00:00": {"afternoon": [], "night": []}
    },
    "afternoon": "18:00",
    "night": "22:00",
    "regularTickets": {
      "name": "regular",
      "price": 21,
      "availableTickets": 40,
      "soldTickets": 0
    },
    "specialNeedsTickets": {
      "name": "special needs",
      "price": 15,
      "availableTickets": 6,
      "soldTickets": 0
    },
    "hall": "Hall B",
    "ageLimit": "10+",
    "additionalInfo": "Performed in modern English with fairy-tale staging and visual effects.",
    "hearingImpaired": false,
    "imageUrl": "assets/images/midsummer_dream.jpg"
  },
  {
    "title": "Hamlet",
    "headline": "The Prince's Revenge — A Tale of Madness and Morality",
    "description": "A psychological journey through the human soul as Hamlet seeks vengeance for his father’s murder in Shakespeare’s darkest tragedy.",
    "playwriter": "William Shakespeare",
    "cast": ["Tom Hiddleston", "Olivia Colman", "Riz Ahmed"],
    "genre": "Tragedy",
    "runtime": "2h 45min",
    "availableDates": {
      "2024-07-12T00:00:00": {"afternoon": [], "night": []},
      "2024-07-13T00:00:00": {"afternoon": [], "night": []}
    },
    "afternoon": "17:00",
    "night": "21:00",
    "regularTickets": {
      "name": "regular",
      "price": 26,
      "availableTickets": 35,
      "soldTickets": 0
    },
    "specialNeedsTickets": {
      "name": "special needs",
      "price": 20,
      "availableTickets": 5,
      "soldTickets": 0
    },
    "hall": "Hall A",
    "ageLimit": "14+",
    "additionalInfo": "Includes surtitles and contemporary minimalist staging.",
    "hearingImpaired": true,
    "imageUrl": "assets/images/hamlet_new.jpg"
  },
  {
    "title": "Romeo and Juliet",
    "headline": "A Timeless Tale of Love and Fate",
    "description": "Shakespeare’s iconic tragedy about star-crossed lovers, feuding families, and the power of hope in the face of heartbreak.",
    "playwriter": "William Shakespeare",
    "cast": ["Lily James", "Richard Madden", "Derek Jacobi"],
    "genre": "Tragedy",
    "runtime": "2h 10min",
    "availableDates": {
      "2024-08-03T00:00:00": {
        "afternoon": [],
        "night": []
      },
      "2024-08-04T00:00:00": {
        "afternoon": [],
        "night": []
      }
    },
    "afternoon": "17:45",
    "night": "21:30",
    "regularTickets": {
      "name": "regular",
      "price": 20,
      "availableTickets": 50,
      "soldTickets": 0
    },
    "specialNeedsTickets": {
      "name": "special needs",
      "price": 15,
      "availableTickets": 10,
      "soldTickets": 0
    },
    "hall": "Hall A",
    "ageLimit": "13+",
    "additionalInfo": "A modern staging featuring live music. Optional subtitles available on in-house app.",
    "hearingImpaired": true,
    "imageUrl": "assets/images/romeo_and_juliet.jpg"
  },
  {
    "title": "The Phantom of the Opera",
    "headline": "A Haunting Love Story Beneath the Opera House",
    "description": "Andrew Lloyd Webber’s iconic musical about a disfigured musical genius who haunts the Paris Opera House and becomes enamored with a young soprano.",
    "playwriter": "Andrew Lloyd Webber (lyrics by Charles Hart and Richard Stilgoe)",
    "cast": ["Ramin Karimloo", "Sierra Boggess", "Hadley Fraser"],
    "genre": "Musical/Romance",
    "runtime": "2h 30min",
    "availableDates": {
      "2024-08-24T00:00:00": {
        "afternoon": [],
        "night": []
      },
      "2024-08-25T00:00:00": {
        "afternoon": [],
        "night": []
      }
    },
    "afternoon": "17:30",
    "night": "21:30",
    "regularTickets": {
      "name": "regular",
      "price": 32,
      "availableTickets": 40,
      "soldTickets": 0
    },
    "specialNeedsTickets": {
      "name": "special needs",
      "price": 25,
      "availableTickets": 6,
      "soldTickets": 0
    },
    "hall": "Hall D",
    "ageLimit": "12+",
    "additionalInfo": "Lavish stage production; includes a famous chandelier sequence. Strobe lighting effects in select scenes.",
    "hearingImpaired": false,
    "imageUrl": "assets/images/phantom_opera.jpg"
  }
]
''';