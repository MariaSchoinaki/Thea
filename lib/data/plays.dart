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
      "2025-06-04T00:00:00": {
        "afternoon": ["A1", "A3", "B2", "C4", "D6", "E7", "F1", "F4", "C3"], 
        "night": ["A2", "B3", "C5", "D1", "E1", "F2", "F6", "D4", "B6"]
      },
      "2025-06-05T00:00:00": {
        "afternoon": ["A4", "B1", "C2", "D2", "E2", "F3", "F5", "A6", "D8"], 
        "night": ["A5", "B4", "C6", "D5", "E4", "F7", "F1", "C1", "B5"]
      },
      "2025-06-11T00:00:00": {
        "afternoon": ["A6", "B6", "C7", "D3", "E6", "F6", "E8", "D7", "B7"], 
        "night": ["A7", "B2", "C1", "D6", "E3", "F2", "F4", "C4", "A1"]
      },
      "2025-06-12T00:00:00": {
        "afternoon": ["A2", "B3", "C5", "D1", "E5", "F3", "F6", "D5", "C2"], 
        "night": ["A3", "B5", "C3", "D2", "E7", "F5", "A5", "E1", "B1"]
      },
      "2025-06-18T00:00:00": {
        "afternoon": ["A4", "B4", "C4", "D4", "E4", "F4", "B6", "E2", "F7"], 
        "night": ["A5", "B7", "C6", "D8", "E6", "F1", "C3", "B2", "D6"]
      },
      "2025-06-19T00:00:00": {
        "afternoon": ["A5", "B7", "C6", "D8", "E6", "F1", "C3", "B2", "D6"], 
        "night": ["A2", "B3", "C5", "D1", "E5", "F3", "F6", "D5", "C2"]
      },
      "2025-06-25T00:00:00": {
        "afternoon": ["A7", "B2", "C1", "D6", "E3", "F2", "F4", "C4", "A1"], 
        "night": ["A2", "B3", "C5", "D1", "E1", "F2", "F6", "D4", "B6"]
      },
      "2025-06-26T00:00:00": {
        "afternoon": ["A4", "B4", "C4", "D4", "E4", "F4", "B6", "E2", "F7"], 
        "night": ["A1", "A3", "B2", "C4", "D6", "E7", "F1", "F4", "C3"]
      },
      "2025-06-27T00:00:00": {
        "afternoon": ["A3", "B5", "C3", "D2", "E7", "F5", "A5", "E1", "B1"], 
        "night": ["A5", "B7", "C6", "D8", "E6", "F1", "C3", "B2", "D6"]
      }
    },
    "afternoon": "17:30",
    "night": "21:00",
    "regularTickets": {
      "name": "regular",
      "price": 23,
      "availableTickets": 138,
      "soldTickets": 0
    },
    "specialNeedsTickets": {
      "name": "special needs",
      "price": 18,
      "availableTickets": 24,
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
      "2025-06-03T00:00:00": {
        "afternoon": ["F2", "A6", "B1", "D3", "E7", "C5", "A4", "F7", "B3"],
        "night": ["C1", "E5", "A7", "F4", "B6", "D8", "C3", "A1", "E2"]
      },
      "2025-06-06T00:00:00": {
        "afternoon": ["A5", "D7", "F1", "B2", "C4", "E8", "A2", "D1", "F6"],
        "night": ["B7", "E3", "A7", "F5", "C2", "D4", "B1", "A3", "E6"]
      },
      "2025-06-10T00:00:00": {
        "afternoon": ["E4", "C7", "A3", "F7", "B5", "D2", "E1", "C6", "A6"],
        "night": ["F3", "B1", "D6", "E5", "C1", "A4", "F6", "B2", "D7"]
      },
      "2025-06-13T00:00:00": {
        "afternoon": ["B7", "E2", "F5", "A1", "C3", "D7", "B4", "E7", "F1"],
        "night": ["A5", "D2", "B7", "E8", "C6", "F3", "A2", "D4", "B1"]
      },
      "2025-06-16T00:00:00": {
        "afternoon": ["F7", "A4", "B2", "D6", "E1", "C7", "F2", "A7", "B5"],
        "night": ["C4", "E3", "F6", "A1", "D8", "B3", "C1", "E5", "F7"]
      },
      "2025-06-20T00:00:00": {
        "afternoon": ["B7", "E6", "F3", "A2", "C7", "D1", "B1", "E4", "F7"],
        "night": ["A7", "D5", "B2", "E1", "C3", "F5", "A6", "D7", "B7"]
      },
      "2025-06-23T00:00:00": {
        "afternoon": ["F4", "A3", "B6", "D8", "E2", "C1", "F7", "A5", "B7"],
        "night": ["C5", "E7", "F1", "A6", "D3", "B2", "C7", "E4", "F2"]
      },
      "2025-06-27T00:00:00": {
        "afternoon": ["B5", "E8", "F2", "A7", "C4", "D1", "B7", "E3", "F6"],
        "night": ["A1", "D5", "B3", "E6", "C7", "F4", "A7", "D2", "B1"]
      },
      "2025-06-30T00:00:00": {
        "afternoon": ["F7", "A1", "B4", "D5", "E8", "C2", "F3", "A5", "B7"],
        "night": ["C6", "E2", "F7", "A3", "D1", "B6", "C1", "E4", "F5"]
      },
      "2024-07-04T00:00:00": {
        "afternoon": ["B3", "E5", "F1", "A7", "C6", "D2", "B1", "E7", "F4"],
        "night": ["A2", "D8", "B5", "E3", "C1", "F6", "A4", "D3", "B7"]
      }
    },
    "afternoon": "18:00",
    "night": "22:00",
    "regularTickets": {
      "name": "regular",
      "price": 25,
      "availableTickets": 148,
      "soldTickets": 0
    },
    "specialNeedsTickets": {
      "name": "special needs",
      "price": 20,
      "availableTickets": 32,
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
      "2025-06-09T00:00:00": {
        "afternoon": ["A1", "B2", "C3", "D4", "E5", "F6", "A7", "B1", "C2"],
        "night": ["A2", "B3", "C4", "D5", "E6", "F1", "A7", "B7", "C1"]
      },
      "2025-06-13T00:00:00": {
        "afternoon": ["C1", "D2", "E3", "F4", "A5", "B6", "C7", "D8", "E1"],
        "night": ["D1", "E2", "F3", "A4", "B5", "C6", "D7", "E8", "F1"]
      },
      "2025-06-16T00:00:00": {
        "afternoon": ["E1", "F2", "A3", "B4", "C5", "D6", "E7", "F7", "A1"],
        "night": ["F1", "A2", "B3", "C4", "D5", "E6", "F7", "A7", "B1"]
      },
      "2025-06-19T00:00:00": {
        "afternoon": ["A7", "B7", "C1", "D2", "E3", "F4", "A5", "B6", "C7"],
        "night": ["A7", "B1", "C2", "D3", "E4", "F5", "A6", "B7", "C4"]
      },
      "2025-06-23T00:00:00": {
        "afternoon": ["C7", "D8", "E1", "F2", "A3", "B4", "C5", "D6", "E7"],
        "night": ["A1", "B2", "C3", "D4", "E5", "F6", "A7", "B6", "C1"]
      },
      "2025-06-26T00:00:00": {
        "afternoon": ["B1", "C2", "D3", "E4", "F5", "A6", "B7", "C8", "D1"],
        "night": ["C1", "D2", "E3", "F4", "A5", "B6", "C7", "D8", "E1"]
      },
      "2025-06-30T00:00:00": {
        "afternoon": ["D1", "E2", "F3", "A4", "B5", "C6", "D7", "E8", "F1"],
        "night": ["E1", "F2", "A3", "B4", "C5", "D6", "E7", "F7", "A1"]
      },
      "2025-07-03T00:00:00": {
        "afternoon": ["F1", "A2", "B3", "C4", "D5", "E6", "F7", "A6", "B1"],
        "night": ["A7", "B8", "C1", "D2", "E3", "F4", "A5", "B6", "C7"]
      },
      "2025-07-07T00:00:00": {
        "afternoon": ["A1", "B1", "C2", "D3", "E4", "F5", "A6", "B7", "C5"],
        "night": ["C7", "D8", "E1", "F2", "A3", "B4", "C5", "D6", "E7"]
      },
      "2025-07-10T00:00:00": {
        "afternoon": ["A1", "B2", "C3", "D4", "E5", "F6", "A2", "B3", "C4"],
        "night": ["D5", "E6", "F1", "A3", "B4", "C5", "D6", "E1", "F2"]
      },
      "2025-07-14T00:00:00": {
        "afternoon": ["B1", "C2", "D3", "E4", "F5", "A4", "B5", "C6", "D7"],
        "night": ["E7", "F3", "A5", "B6", "C7", "D8", "E8", "F4", "A6"]
      },
      "2025-07-17T00:00:00": {
        "afternoon": ["C1", "D2", "E3", "F4", "A7", "B7", "C8", "D1", "E2"],
        "night": ["F5", "A8", "B1", "C2", "D3", "E4", "F6", "A1", "B2"]
      },
      "2025-07-21T00:00:00": {
        "afternoon": ["D1", "E2", "F3", "A2", "B3", "C4", "D5", "E6", "F7"],
        "night": ["A3", "B4", "C5", "D6", "E7", "F8", "A4", "B5", "C6"]
      },
      "2025-07-24T00:00:00": {
        "afternoon": ["E1", "F2", "A3", "B4", "C5", "D6", "E7", "F7", "A1"],
        "night": ["B1", "C2", "D3", "E4", "F5", "A5", "B6", "C7", "D8"]
      },
      "2025-07-28T00:00:00": {
        "afternoon": ["F1", "A2", "B3", "C4", "D5", "E6", "F7", "A3", "B1"],
        "night": ["C1", "D2", "E3", "F4", "A6", "B7", "C8", "D1", "E2"]
      },
      "2025-07-31T00:00:00": {
        "afternoon": ["A7", "B5", "C1", "D2", "E3", "F4", "A5", "B6", "C7"],
        "night": ["D3", "E4", "F5", "A7", "B2", "C1", "D4", "E5", "F6"]
      }
    },
    "afternoon": "17:00",
    "night": "21:00",
    "regularTickets": {
      "name": "regular",
      "price": 25,
      "availableTickets": 242,
      "soldTickets": 0
    },
    "specialNeedsTickets": {
      "name": "special needs",
      "price": 20,
      "availableTickets": 46,
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
      "2025-06-07T00:00:00": {
        "afternoon": ["A1", "B2", "C3", "D4", "E5", "F6", "A4", "B5", "C6"],
        "night": ["D7", "E8", "F1", "A2", "B3", "C4", "D5", "E6", "F7"]
      },
      "2025-06-14T00:00:00": {
        "afternoon": ["B1", "C2", "D3", "E4", "F5", "A6", "B7", "C8", "D1"],
        "night": ["E2", "F3", "A7", "B8", "C1", "D2", "E3", "F4", "A5"]
      },
      "2025-06-21T00:00:00": {
        "afternoon": ["C1", "D2", "E3", "F4", "A2", "B1", "C2", "D3", "E4"],
        "night": ["F5", "A1", "B2", "C3", "D4", "E5", "F6", "A7", "B8"]
      },
      "2025-06-28T00:00:00": {
        "afternoon": ["D1", "E2", "F3", "A2", "B3", "C4", "D5", "E6", "F7"],
        "night": ["A3", "B4", "C5", "D6", "E7", "F8", "A1", "B2", "C3"]
      },
      "2025-07-05T00:00:00": {
        "afternoon": ["E1", "F2", "A3", "B4", "C5", "D6", "E7", "F7", "A4"],
        "night": ["B1", "C2", "D3", "E4", "F5", "A5", "B6", "C7", "D8"]
      },
      "2025-07-12T00:00:00": {
        "afternoon": ["F1", "A2", "B3", "C4", "D5", "E6", "F7", "A4", "B1"],
        "night": ["C1", "D2", "E3", "F4", "A6", "B7", "C7", "D1", "E2"]
      },
      "2025-07-19T00:00:00": {
        "afternoon": ["A7", "B6", "C1", "D2", "E3", "F4", "A5", "B5", "C7"],
        "night": ["D3", "E4", "F5", "A7", "B6", "C1", "D4", "E5", "F6"]
      },
      "2025-07-26T00:00:00": {
        "afternoon": ["B7", "C6", "D1", "E2", "F3", "A1", "B2", "C3", "D4"],
        "night": ["E5", "F6", "A2", "B3", "C4", "D5", "E6", "F7", "A6"]
      }
    },
    "afternoon": "17:45",
    "night": "21:30",
    "regularTickets": {
      "name": "regular",
      "price": 20,
      "availableTickets": 121,
      "soldTickets": 0
    },
    "specialNeedsTickets": {
      "name": "special needs",
      "price": 15,
      "availableTickets": 23,
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
      "2025-07-06T00:00:00": {
        "afternoon": ["F7", "A7", "B7", "C7", "D8", "E8", "F6", "A6", "B6"],
        "night": ["C6", "D7", "E7", "F5", "A5", "B5", "C5", "D6", "E6"]
      },
      "2025-07-08T00:00:00": {
        "afternoon": ["A4", "B4", "C4", "D5", "E5", "F4", "A3", "B3", "C3"],
        "night": ["D4", "E4", "F3", "A2", "B2", "C2", "D3", "E3", "F2"]
      },
      "2025-07-13T00:00:00": {
        "afternoon": ["E1", "F1", "A1", "B1", "C1", "D1", "E2", "F2", "A2"],
        "night": ["B2", "C2", "D2", "E3", "F3", "A3", "B3", "C3", "D3"]
      },
      "2025-07-20T00:00:00": {
        "afternoon": ["C7", "D8", "E8", "F7", "A7", "B7", "C6", "D7", "E7"],
        "night": ["F6", "A6", "B6", "C5", "D6", "E6", "F5", "A5", "B5"]
      },
      "2025-07-22T00:00:00": {
        "afternoon": ["B4", "C4", "D5", "E5", "F4", "A4", "B3", "C3", "D4"],
        "night": ["E4", "F3", "A3", "B2", "C2", "D3", "E3", "F2", "A2"]
      },
      "2025-07-27T00:00:00": {
        "afternoon": ["F1", "A1", "B1", "C1", "D1", "E1", "F2", "A2", "B2"],
        "night": ["C2", "D2", "E2", "F3", "A3", "B3", "C3", "D3", "E3"]
      },
      "2025-08-03T00:00:00": {
        "afternoon": ["A7", "B7", "C7", "D8", "E8", "F7", "A6", "B6", "C6"],
        "night": ["D7", "E7", "F6", "A5", "B5", "C5", "D6", "E6", "F5"]
      },
      "2025-08-05T00:00:00": {
        "afternoon": ["B4", "C4", "D5", "E5", "F4", "A4", "B3", "C3", "D4"],
        "night": ["E4", "F3", "A3", "B2", "C2", "D3", "E3", "F2", "A2"]
      },
      "2025-08-10T00:00:00": {
        "afternoon": ["C1", "D1", "E1", "F1", "A1", "B1", "C2", "D2", "E2"],
        "night": ["F2", "A2", "B2", "C3", "D3", "E3", "F3", "A3", "B3"]
      },
      "2025-08-12T00:00:00": {
        "afternoon": ["D8", "E8", "F7", "A7", "B7", "C7", "D7", "E7", "F6"],
        "night": ["A6", "B6", "C6", "D6", "E6", "F5", "A5", "B5", "C5"]
      }
    },
    "afternoon": "17:30",
    "night": "21:30",
    "regularTickets": {
      "name": "regular",
      "price": 27,
      "availableTickets": 151,
      "soldTickets": 0
    },
    "specialNeedsTickets": {
      "name": "special needs",
      "price": 20,
      "availableTickets": 29,
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
      "2025-06-04T00:00:00": {
        "afternoon": ["A3", "B5", "C1", "D7", "E2", "F6", "A7", "B1", "C4"],
        "night": ["D2", "E8", "F3", "A5", "B7", "C6", "D1", "E4", "F5"]
      },
      "2025-06-11T00:00:00": {
        "afternoon": ["B2", "C7", "D4", "E6", "F1", "A7", "B4", "C2", "D6"],
        "night": ["E1", "F7", "A3", "B6", "C5", "D8", "E3", "F4", "A1"]
      },
      "2025-06-18T00:00:00": {
        "afternoon": ["C3", "D1", "E7", "F5", "A2", "B7", "C5", "D3", "E1"],
        "night": ["F7", "A4", "B2", "C7", "D6", "E5", "F1", "A6", "B3"]
      },
      "2025-06-25T00:00:00": {
        "afternoon": ["D5", "E3", "F3", "A6", "B1", "C7", "D2", "E5", "F2"],
        "night": ["A1", "B4", "C7", "D7", "E2", "F6", "A3", "B5", "C4"]
      },
      "2025-07-02T00:00:00": {
        "afternoon": ["E6", "F4", "A1", "B7", "C2", "D8", "E4", "F1", "A5"],
        "night": ["B3", "C6", "D1", "E7", "F5", "A7", "B2", "C4", "D3"]
      },
      "2025-07-09T00:00:00": {
        "afternoon": ["F7", "A5", "B3", "C7", "D3", "E1", "F4", "A7", "B6"],
        "night": ["C1", "D4", "E8", "F2", "A6", "B5", "C3", "D5", "E7"]
      },
      "2025-07-16T00:00:00": {
        "afternoon": ["A4", "B6", "C6", "D2", "E5", "F3", "A1", "B5", "C7"],
        "night": ["D8", "E3", "F7", "A2", "B4", "C1", "D6", "E8", "F5"]
      },
      "2025-07-23T00:00:00": {
        "afternoon": ["B6", "C2", "D8", "E4", "F1", "A3", "B1", "C5", "D7"],
        "night": ["E8", "F3", "A5", "B7", "C4", "D1", "E6", "F2", "A7"]
      },
      "2025-07-30T00:00:00": {
        "afternoon": ["C5", "D7", "E1", "F6", "A7", "B2", "C3", "D5", "E7"],
        "night": ["F4", "A1", "B7", "C2", "D6", "E3", "F7", "A4", "B6"]
      }
    },
    "afternoon": "16:30",
    "night": "21:30",
    "regularTickets": {
      "name": "regular",
      "price": 27,
      "availableTickets": 140,
      "soldTickets": 0
    },
    "specialNeedsTickets": {
      "name": "special needs",
      "price": 20,
      "availableTickets": 22,
      "soldTickets": 0
    },
    "stage": "Stage B",
    "ageLimit": "12+",
    "additionalInfo": "",
    "imageUrl": "assets/images/oedipus_rex.jpg"
  }
]
''';