const rawPlayData = '''
[
  {
    "title": "Be More Chill",
    "headline": "A High-School Musical About Fitting In and Standing Out",
    "description": "Be More Chill is a contemporary musical that follows the story of Jeremy Heere, an ordinary high school student who takes a mysterious pill containing a supercomputer designed to help him become popular. As his life begins to change, Jeremy must confront the consequences of losing himself to technology and peer pressure. With a compelling narrative and a modern score, this production offers a thought-provoking look at adolescence and the desire to belong.",
    "playwriter": "Joe Tracz & Joe Iconis",
    "cast": ["Will Roland", "Stephanie Hsu", "George Salazar"],
    "genre": "Musical Comedy",
    "runtime": "2h 10min",
    "availableDates": {
      "2025-07-10T00:00:00": {"afternoon": [], "night": []},
      "2025-07-11T00:00:00": {"afternoon": [], "night": []},
      "2025-07-12T00:00:00": {"afternoon": [], "night": []},
      "2025-07-13T00:00:00": {"afternoon": [], "night": []},
      "2025-07-14T00:00:00": {"afternoon": [], "night": []},
      "2025-07-15T00:00:00": {"afternoon": [], "night": []},
      "2025-07-16T00:00:00": {"afternoon": [], "night": []},
      "2025-07-17T00:00:00": {"afternoon": [], "night": []},
      "2025-07-18T00:00:00": {"afternoon": [], "night": []}
    },
    "afternoon": "17:30",
    "night": "21:00",
    "regularTickets": {
      "name": "regular",
      "price": 23,
      "availableTickets": 35,
      "soldTickets": 0
    },
    "specialNeedsTickets": {
      "name": "special needs",
      "price": 18,
      "availableTickets": 5,
      "soldTickets": 0
    },
    "stage": "Stage A",
    "ageLimit": "12+",
    "additionalInfo": "Features energetic songs and live band. Ideal for teens and young adults.",
    "imageUrl": "assets/images/be_more_chill.jpg"
  },
  {
    "title": "A Midsummer Night's Dream",
    "headline": "A Magical Shakespearean Romp Through Love and Chaos",
    "description": "In one of Shakespeare's most beloved comedies, A Midsummer Night’s Dream transports audiences to a mystical forest where love is tested, identities are mistaken, and magic reigns supreme. As noble lovers, mischievous fairies, and a troupe of amateur actors cross paths, the boundaries between reality and illusion blur. This timeless classic explores the complexities of love and imagination with poetic brilliance and theatrical charm.",
    "playwriter": "William Shakespeare",
    "cast": ["JJ Feild", "Susannah Fielding", "Emmanuel Akwafo", "Nina Cassells","David Moorst"],
    "genre": "Romantic Comedy",
    "runtime": "2h 5min",
    "availableDates": {
      "2025-07-10T00:00:00": {"afternoon": [], "night": []},
      "2025-07-11T00:00:00": {"afternoon": [], "night": []},
      "2025-07-12T00:00:00": {"afternoon": [], "night": []},
      "2025-07-13T00:00:00": {"afternoon": [], "night": []},
      "2025-07-14T00:00:00": {"afternoon": [], "night": []},
      "2025-07-15T00:00:00": {"afternoon": [], "night": []},
      "2025-07-16T00:00:00": {"afternoon": [], "night": []},
      "2025-07-17T00:00:00": {"afternoon": [], "night": []},
      "2025-07-18T00:00:00": {"afternoon": [], "night": []},
      "2024-07-19T00:00:00": {"afternoon": [], "night": []},
      "2024-07-20T00:00:00": {"afternoon": [], "night": []}
    },
    "afternoon": "18:00",
    "night": "22:00",
    "regularTickets": {
      "name": "regular",
      "price": 25,
      "availableTickets": 40,
      "soldTickets": 0
    },
    "specialNeedsTickets": {
      "name": "special needs",
      "price": 20,
      "availableTickets": 6,
      "soldTickets": 0
    },
    "stage": "Stage B",
    "ageLimit": "5+",
    "additionalInfo": "Performed in modern English with fairy-tale staging and visual effects.",
    "imageUrl": "assets/images/midsummer_dream.jpg"
  },
  {
    "title": "Hamlet",
    "headline": "The Prince's Revenge — A Tale of Madness and Morality",
    "description": "Shakespeare's Hamlet remains one of the most profound explorations of human emotion and ethical struggle in the theatrical canon. Following the death of his father, Prince Hamlet of Denmark is consumed by grief and driven to uncover the truth behind the king's mysterious demise. As he wrestles with betrayal, doubt, and vengeance, the line between reason and madness begins to fade. This landmark tragedy is a powerful meditation on justice, mortality, and the search for truth in a corrupted world.",
    "playwriter": "William Shakespeare",
    "cast": ["Hiran Abeysekera", "Phil Cheadle", "Ayesha Dharker", "Tom Glenister","Hari Mackinnon","Francesca Mills","Alistair Petrie","Siobhán Redmond","Geoffrey Streatfeild"],
    "genre": "Tragedy",
    "runtime": "2h 45min",
    "availableDates": {
      "2025-07-04T00:00:00": {"afternoon": [], "night": []},
      "2025-07-05T00:00:00": {"afternoon": [], "night": []},
      "2025-07-06T00:00:00": {"afternoon": [], "night": []},
      "2025-07-07T00:00:00": {"afternoon": [], "night": []},
      "2025-07-08T00:00:00": {"afternoon": [], "night": []},
      "2025-07-09T00:00:00": {"afternoon": [], "night": []},
      "2025-08-20T00:00:00": {"afternoon": [], "night": []},
      "2025-08-21T00:00:00": {"afternoon": [], "night": []},
      "2025-08-22T00:00:00": {"afternoon": [], "night": []},
      "2025-08-23T00:00:00": {"afternoon": [], "night": []},
      "2025-08-24T00:00:00": {"afternoon": [], "night": []},
      "2025-08-25T00:00:00": {"afternoon": [], "night": []},
      "2025-08-26T00:00:00": {"afternoon": [], "night": []},
      "2025-08-27T00:00:00": {"afternoon": [], "night": []},
      "2025-08-28T00:00:00": {"afternoon": [], "night": []},
      "2025-08-29T00:00:00": {"afternoon": [], "night": []},
      "2025-08-30T00:00:00": {"afternoon": [], "night": []}
    },
    "afternoon": "17:00",
    "night": "21:00",
    "regularTickets": {
      "name": "regular",
      "price": 25,
      "availableTickets": 35,
      "soldTickets": 0
    },
    "specialNeedsTickets": {
      "name": "special needs",
      "price": 20,
      "availableTickets": 5,
      "soldTickets": 0
    },
    "stage": "Stage A",
    "ageLimit": "14+",
    "additionalInfo": "Includes surtitles and contemporary minimalist staging.",
    "imageUrl": "assets/images/hamlet_new.jpg"
  },
  {
    "title": "Romeo and Juliet",
    "headline": "A Timeless Tale of Love and Fate",
    "description": "In Romeo and Juliet, Shakespeare crafts a poignant and enduring tale of two young lovers caught in the crossfire of an age-old feud between their families. As passion collides with fate, their secret romance unfolds with intensity and urgency, leading to one of the most iconic and heartrending conclusions in theatre history. This timeless tragedy explores the destructive power of hatred and the enduring force of love in the face of impossible odds.",
    "playwriter": "William Shakespeare",
    "cast": ["Kit Connor", "Rachel Zegler", "Gabby Beans"],
    "genre": "Tragedy",
    "runtime": "2h 10min",
    "availableDates": {
      "2025-08-20T00:00:00": {"afternoon": [], "night": []},
      "2025-08-21T00:00:00": {"afternoon": [], "night": []},
      "2025-08-22T00:00:00": {"afternoon": [], "night": []},
      "2025-08-23T00:00:00": {"afternoon": [], "night": []},
      "2025-08-24T00:00:00": {"afternoon": [], "night": []},
      "2025-08-25T00:00:00": {"afternoon": [], "night": []},
      "2025-08-26T00:00:00": {"afternoon": [], "night": []},
      "2025-08-27T00:00:00": {"afternoon": [], "night": []},
      "2025-08-28T00:00:00": {"afternoon": [], "night": []},
      "2025-08-29T00:00:00": {"afternoon": [], "night": []},
      "2025-08-30T00:00:00": {"afternoon": [], "night": []}
    },
    "afternoon": "17:45",
    "night": "21:30",
    "regularTickets": {
      "name": "regular",
      "price": 20,
      "availableTickets": 40,
      "soldTickets": 0
    },
    "specialNeedsTickets": {
      "name": "special needs",
      "price": 15,
      "availableTickets": 6,
      "soldTickets": 0
    },
    "stage": "Stage B",
    "ageLimit": "13+",
    "additionalInfo": "A modern staging featuring live music. Optional subtitles available on in-house app.",
    "imageUrl": "assets/images/romeo_and_juliet.jpg"
  },
  {
    "title": "The Phantom of the Opera",
    "headline": "A Haunting Love Story Beneath the Opera House",
    "description": "Andrew Lloyd Webber's The Phantom of the Opera is a sweeping musical that tells the story of a mysterious figure who lurks in the shadows of the Paris Opera House. As the Phantom becomes fixated on the young soprano Christine Daaé, his obsession unleashes a series of dramatic events that blur the lines between love and possession, beauty and darkness. With its iconic score, lavish staging, and emotional depth, this enduring production continues to captivate audiences worldwide.",
    "playwriter": "Andrew Lloyd Webber (lyrics by Charles Hart and Richard Stilgoe)",
    "cast": ["Dean Chisnall", "Lily Kerhoas", "Joe Griffiths-Brown","Eve Shanu-Wilson"],
    "genre": "Musical/Romance",
    "runtime": "2h 30min",
    "availableDates": {
      "2025-09-20T00:00:00": {"afternoon": [], "night": []},
      "2025-09-21T00:00:00": {"afternoon": [], "night": []},
      "2025-09-22T00:00:00": {"afternoon": [], "night": []},
      "2025-09-23T00:00:00": {"afternoon": [], "night": []},
      "2025-09-24T00:00:00": {"afternoon": [], "night": []},
      "2025-09-25T00:00:00": {"afternoon": [], "night": []},
      "2025-09-26T00:00:00": {"afternoon": [], "night": []},
      "2025-09-27T00:00:00": {"afternoon": [], "night": []},
      "2025-09-28T00:00:00": {"afternoon": [], "night": []},
      "2025-09-29T00:00:00": {"afternoon": [], "night": []},
      "2025-09-30T00:00:00": {"afternoon": [], "night": []}
    },
    "afternoon": "17:30",
    "night": "21:30",
    "regularTickets": {
      "name": "regular",
      "price": 27,
      "availableTickets": 35,
      "soldTickets": 0
    },
    "specialNeedsTickets": {
      "name": "special needs",
      "price": 20,
      "availableTickets": 5,
      "soldTickets": 0
    },
    "stage": "Stage A",
    "ageLimit": "12+",
    "additionalInfo": "Lavish stage production; includes a famous chandelier sequence. Strobe lighting effects in select scenes.",
    "imageUrl": "assets/images/phantom_opera.jpg"
  },
  {
    "title": "Oedipus Rex",
    "headline": "Humanity's Mirror: A Ritual of Oedipus's Reckoning",
    "description": "Never before have we in human history ever “looked” so far away inside the cosmos and so deeply inside humans. Very often, in the brink of destruction, we realize that the evil we are fighting against is, in fact, ourselves. Oedipus’ face is humanity itself in front of the mirror. Having found the culprit, he reaches the point where it is imperative that he make a choice, even at the eleventh hour, even after he has already committed the gravest error. In this performance, approached as a ritual of purification, a group of actors wearing masks of Elders comprises the writhing, mourning Chorus in agony. Through this Chorus, the tragic characters, namely Oedipus, Jocasta, Teiresias and Creon, are revealed.",
    "playwriter": "Sophocles",
    "cast": ["Yannis Stankoglou", "Marilita Lampropoulou", "Christos Malakis","Yannis Dalianis","Panagos Ioakeim","Giorgos Amoutzas","Konstantinos Moraitis"],
    "genre": "Greek Tragedy",
    "runtime": "2h 30min",
    "availableDates": {
      "2025-09-20T00:00:00": {"afternoon": [], "night": []},
      "2025-09-21T00:00:00": {"afternoon": [], "night": []},
      "2025-09-22T00:00:00": {"afternoon": [], "night": []},
      "2025-09-23T00:00:00": {"afternoon": [], "night": []},
      "2025-09-24T00:00:00": {"afternoon": [], "night": []},
      "2025-09-25T00:00:00": {"afternoon": [], "night": []},
      "2025-09-26T00:00:00": {"afternoon": [], "night": []},
      "2025-09-27T00:00:00": {"afternoon": [], "night": []},
      "2025-09-28T00:00:00": {"afternoon": [], "night": []},
      "2025-09-29T00:00:00": {"afternoon": [], "night": []},
      "2025-09-30T00:00:00": {"afternoon": [], "night": []}
    },
    "afternoon": "16:30",
    "night": "21:30",
    "regularTickets": {
      "name": "regular",
      "price": 27,
      "availableTickets": 40,
      "soldTickets": 0
    },
    "specialNeedsTickets": {
      "name": "special needs",
      "price": 20,
      "availableTickets": 6,
      "soldTickets": 0
    },
    "stage": "Stage B",
    "ageLimit": "12+",
    "additionalInfo": "",
    "imageUrl": "assets/images/oedipus_rex.jpg"
  }
]
''';