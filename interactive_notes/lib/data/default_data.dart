// import 'package:flutter/material.dart';

Map<String, dynamic> defaultData() {
  Map<String, dynamic> defaultNotes = {
    // 'Basic Math': {
    //   'note_name': 'Basic Math',
    //   'question_list': [
    //     {
    //       'question': 'What is 2 + 2?',
    //       'answer': '4',
    //       'tags': ['addition', 'math'],
    //       'wrong_ans': ['1', '5', '6'],
    //       'explanation': '1+1+1+1 = 4'
    //     },
    //     {
    //       'question': 'What is 2 x 3?',
    //       'answer': '6',
    //       'tags': ['math'],
    //       'wrong_ans': ['8', '4', '9'],
    //       'explanation': '2+2+2 = 6'
    //     },
    //   ]
    // },
    'Advanced Math': {
      'note_name': 'Advanced Math',
      'question_list': [
        {
          'question': 'What is the derivative of x²?',
          'answer': '2x',
          'tags': ['differentiation', 'math'],
          'wrong_ans': ['x', 'x²', '2'],
          'explanation': 'differentiate'
        },
        {
          'question': 'What is 12 x 12?',
          'answer': '144',
          'tags': ['multiplication', 'math'],
          'wrong_ans': ['124', '140', '148'],
          'explanation': ''
        },
        {
          'question': 'What is 24 / 6 + 2',
          'answer': '6',
          'tags': ['division', 'addition', 'math'],
          'wrong_ans': ['4', '14', '3'],
          'explanation': 'Divide before adding'
        },
      ]
    },


// --------------------------------------------------------------------------------------------------------------------------------------------


    'Major Arcana': {
      'note_name': 'Major Arcana',
      'question_list': [

        {
          'question': 'What does The Fool represent?',
          'answer': 'Innocence, new beginnings, freedom, adventure',
          'tags': ['innocence', 'new beginnings', 'freedom', 'adventure'],
          'wrong_ans': [
            'Despair and endings',
            'Motherhood, fertility, responsibility',
            'Isolation, withdrawal, seclusion, solitude'
          ],
          'explanation': 'The Fool symbolizes the start of a journey, embracing life with optimism, curiosity, spontaneity and a willingness to take risks.'
        },

        {
          'question': 'What does The Magician represent?',
          'answer': 'Manifestation, resourcefulness, power, inspired action',
          'tags': ['manifestation', 'power', 'resourcefulness', 'action'],
          'wrong_ans': [
            'Confusion, illusion befuddlement, perplexity',
            'Loss, grief, devastation',
            'Sacrifice and surrender'
          ],
          'explanation': 'The Magician represents using one\'s talents, skills and available resources to transform ideas into reality.'
        },

        {
          'question': 'What does The High Priestess represent?',
          'answer': 'Intuition, mystery, inner wisdom, subconscious mind',
          'tags': ['intuition', 'mystery', 'wisdom', 'subconscious'],
          'wrong_ans': [
            'Authority, control, discipline',
            'Material abundance',
            'Sudden upheaval, turmoil, disruption'
          ],
          'explanation': 'The High Priestess encourages trusting intuition, seeking hidden knowledge and listening to inner wisdom.'
        },

        {
          'question': 'What does The Empress represent?',
          'answer': 'Nurturing, abundance, fertility, creativity',
          'tags': ['nurturing', 'abundance', 'fertility', 'creativity'],
          'wrong_ans': [
            'Conflict and competition',
            'Detachment, solitude, indifference',
            'Restriction, bondage, regulations, constraints'
          ],
          'explanation': 'The Empress embodies maternal energy, creativity, beauty and the abundant growth found in nature.'
        },

        {
          'question': 'What does The Emperor represent?',
          'answer': 'Authority, structure, stability, leadership',
          'tags': ['authority', 'structure', 'stability', 'leadership'],
          'wrong_ans': [
            'Illusion, uncertainty, fantasy, mirage',
            'Spiritual awakening, enlightenment ',
            'Emotional fulfillment'
          ],
          'explanation': 'The Emperor symbolizes order, discipline and the establishment of stable foundations through leadership.'
        },

        {
          'question': 'What does The Hierophant represent?',
          'answer': 'Tradition, spiritual wisdom, conformity, guidance',
          'tags': ['tradition', 'wisdom', 'guidance', 'conformity'],
          'wrong_ans': [
            'Independence and rebellion',
            'Unexpected disaster',
            'Temptation and addiction'
          ],
          'explanation': 'The Hierophant represents established traditions, spiritual teachings and learning from trusted institutions or mentors.'
        },

        {
          'question': 'What does The Lovers represent?',
          'answer': 'Love, harmony, relationships, choices',
          'tags': ['love', 'harmony', 'relationships', 'choices'],
          'wrong_ans': [
            'Isolation and introspection',
            'Material success only',
            'Fear and anxiety'
          ],
          'explanation': 'The Lovers signifies meaningful relationships, harmony and important decisions aligned with personal values.'
        },

        {
          'question': 'What does The Chariot represent?',
          'answer': 'Determination, willpower, victory, control',
          'tags': ['determination', 'willpower', 'victory', 'control'],
          'wrong_ans': [
            'Passive waiting',
            'Confusion and illusion',
            'Compassion and nurturing'
          ],
          'explanation': 'The Chariot represents overcoming obstacles through focus, discipline and determination.'
        },

        {
          'question': 'What does Strength represent?',
          'answer': 'Courage, inner strength, compassion, resilience',
          'tags': ['courage', 'strength', 'compassion', 'resilience'],
          'wrong_ans': [
            'Deception and trickery',
            'Financial prosperity',
            'Sudden endings'
          ],
          'explanation': 'Strength teaches that true power comes from patience, compassion and mastering one\'s inner impulses.'
        },

        {
          'question': 'What does The Hermit represent?',
          'answer': 'Introspection, solitude, wisdom, soul-searching',
          'tags': ['introspection', 'solitude', 'wisdom', 'guidance'],
          'wrong_ans': [
            'Celebration and joy',
            'Romantic partnership',
            'Rapid action and movement'
          ],
          'explanation': 'The Hermit encourages withdrawing from distractions to seek inner truth and deeper understanding.'
        },

        {
          'question': 'What does Wheel of Fortune represent?',
          'answer': 'Change, cycles, destiny, turning points',
          'tags': ['change', 'cycles', 'destiny', 'fortune'],
          'wrong_ans': [
            'Stagnation and resistance',
            'Self-sacrifice',
            'Authority and order'
          ],
          'explanation': 'Wheel of Fortune reminds us that life moves in cycles and unexpected changes can bring new opportunities.'
        },

        {
          'question': 'What does Justice represent?',
          'answer': 'Fairness, truth, accountability, cause and effect',
          'tags': ['fairness', 'truth', 'accountability', 'justice'],
          'wrong_ans': [
            'Fantasy and dreams',
            'Passion and desire',
            'Abundance and fertility'
          ],
          'explanation': 'Justice represents honesty, responsibility and the consequences of one\'s actions.'
        },

        {
          'question': 'What does The Hanged Man represent?',
          'answer': 'Surrender, new perspective, sacrifice, pause',
          'tags': ['surrender', 'perspective', 'sacrifice', 'pause'],
          'wrong_ans': [
            'Aggressive action',
            'Material gain',
            'Celebration and success'
          ],
          'explanation': 'The Hanged Man suggests that letting go and viewing situations differently can lead to insight.'
        },

        {
          'question': 'What does Death represent?',
          'answer': 'Transformation, endings, transition, renewal',
          'tags': ['transformation', 'endings', 'renewal', 'transition'],
          'wrong_ans': [
            'Literal physical death only',
            'Authority and control',
            'Romantic harmony'
          ],
          'explanation': 'Death signifies necessary endings and profound transformation that creates space for new beginnings.'
        },

        {
          'question': 'What does Temperance represent?',
          'answer': 'Balance, moderation, harmony, patience',
          'tags': ['balance', 'moderation', 'harmony', 'patience'],
          'wrong_ans': [
            'Excess and obsession',
            'Conflict and rivalry',
            'Isolation and withdrawal'
          ],
          'explanation': 'Temperance teaches balance, cooperation and blending different elements harmoniously.'
        },

        {
          'question': 'What does The Devil represent?',
          'answer': 'Bondage, temptation, materialism, unhealthy attachments',
          'tags': ['bondage', 'temptation', 'materialism', 'attachment'],
          'wrong_ans': [
            'Spiritual enlightenment',
            'Hope and inspiration',
            'Justice and fairness'
          ],
          'explanation': 'The Devil highlights limiting beliefs, unhealthy patterns and attachments that restrict personal freedom.'
        },

        {
          'question': 'What does The Tower represent?',
          'answer': 'Sudden change, upheaval, revelation, disruption',
          'tags': ['change', 'upheaval', 'revelation', 'disruption'],
          'wrong_ans': [
            'Peaceful stability',
            'Abundance and comfort',
            'Guidance from tradition'
          ],
          'explanation': 'The Tower represents dramatic change that destroys unstable foundations and reveals the truth.'
        },

        {
          'question': 'What does The Star represent?',
          'answer': 'Hope, inspiration, healing, faith',
          'tags': ['hope', 'inspiration', 'healing', 'faith'],
          'wrong_ans': [
            'Fear and uncertainty',
            'Control and domination',
            'Temptation and excess'
          ],
          'explanation': 'The Star brings optimism, spiritual renewal and trust that healing and guidance are available.'
        },

        {
          'question': 'What does The Moon represent?',
          'answer': 'Illusion, intuition, dreams, uncertainty',
          'tags': ['illusion', 'intuition', 'dreams', 'uncertainty'],
          'wrong_ans': [
            'Clarity and certainty',
            'Victory and conquest',
            'Tradition, conformity, custom, heritage'
          ],
          'explanation': 'The Moon represents navigating uncertainty, illusions and subconscious emotions while trusting intuition.'
        },

        {
          'question': 'What does The Sun represent?',
          'answer': 'Joy, success, positivity, vitality',
          'tags': ['joy', 'success', 'positivity', 'vitality'],
          'wrong_ans': [
            'Isolation and withdrawal',
            'Restriction and fear',
            'Sacrifice, waiting, selflessness'
          ],
          'explanation': 'The Sun symbolizes happiness, clarity, confidence and the warmth that comes from success and truth.'
        },

        {
          'question': 'What does Judgement represent?',
          'answer': 'Awakening, rebirth, reflection, absolution',
          'tags': ['awakening', 'rebirth', 'reflection', 'renewal'],
          'wrong_ans': [
            'Material temptation',
            'Hidden secrets',
            'Romantic attraction'
          ],
          'explanation': 'Judgement signifies self-evaluation, spiritual awakening and answering a higher calling.'
        },

        {
          'question': 'What does The World represent?',
          'answer': 'Completion, fulfillment, accomplishment, wholeness',
          'tags': ['completion', 'fulfillment', 'accomplishment', 'wholeness'],
          'wrong_ans': [
            'Confusion and deception',
            'Isolation and retreat',
            'Conflict, tension, clash, dispute, friction'
          ],
          'explanation': 'The World marks the successful completion of a cycle, bringing fulfillment, integration and new possibilities.'
        }

      ]
    },


// --------------------------------------------------------------------------------------------------------------------------------------------

    'Wands': {
      'note_name': 'Wands',
      'question_list': [
        {
          'question': 'What does Ace of Wands represent?',
          'answer': 'Inspiration, new opportunities, growth, potential',
          'tags': ['inspiration', 'opportunity', 'growth', 'potential'],
          'wrong_ans': ['Heartbreak and sorrow', 'Financial loss', 'Isolation and retreat'],
          'explanation': 'The Ace of Wands represents a spark of inspiration and the beginning of exciting new ventures or creative pursuits.'
        },

        {
          'question': 'What does Two of Wands represent?',
          'answer': 'Planning, decisions, future progress, discovery',
          'tags': ['planning', 'decisions', 'progress', 'discovery'],
          'wrong_ans': ['Emotional fulfillment', 'Sudden upheaval', 'Nostalgia and memories'],
          'explanation': 'The Two of Wands signifies long-term planning, making decisions, and looking toward future possibilities.'
        },

        {
          'question': 'What does Three of Wands represent?',
          'answer': 'Expansion, foresight, progress, exploration',
          'tags': ['expansion', 'foresight', 'progress', 'exploration'],
          'wrong_ans': ['Confusion and illusion', 'Defeat and betrayal', 'Stagnation and delay'],
          'explanation': 'The Three of Wands indicates expansion and seeing plans begin to take shape through preparation and foresight.'
        },

        {
          'question': 'What does Four of Wands represent?',
          'answer': 'Celebration, harmony, home, community',
          'tags': ['celebration', 'harmony', 'home', 'community'],
          'wrong_ans': ['Restriction and bondage', 'Anxiety and fear', 'Conflict and competition'],
          'explanation': 'The Four of Wands represents joyful celebrations, stable foundations, and supportive relationships.'
        },

        {
          'question': 'What does Five of Wands represent?',
          'answer': 'Competition, conflict, rivalry, tension',
          'tags': ['competition', 'conflict', 'rivalry', 'tension'],
          'wrong_ans': ['Peace and harmony', 'Success and recognition', 'Spiritual awakening'],
          'explanation': 'The Five of Wands signifies disagreements, competition, and challenges that test one\'s abilities.'
        },

        {
          'question': 'What does Six of Wands represent?',
          'answer': 'Success, victory, recognition, confidence',
          'tags': ['success', 'victory', 'recognition', 'confidence'],
          'wrong_ans': ['Loss and grief', 'Withdrawal and solitude', 'Temptation and excess'],
          'explanation': 'The Six of Wands indicates achievement, public recognition, and confidence after overcoming obstacles.'
        },

        {
          'question': 'What does Seven of Wands represent?',
          'answer': 'Perseverance, defense, challenge, resilience',
          'tags': ['perseverance', 'defense', 'challenge', 'resilience'],
          'wrong_ans': ['Partnership and union', 'Abundance and comfort', 'Intuition and mystery'],
          'explanation': 'The Seven of Wands represents standing your ground and defending your position despite opposition.'
        },

        {
          'question': 'What does Eight of Wands represent?',
          'answer': 'Speed, movement, progress, action',
          'tags': ['speed', 'movement', 'progress', 'action'],
          'wrong_ans': ['Delay and waiting', 'Emotional withdrawal', 'Financial hardship'],
          'explanation': 'The Eight of Wands signifies rapid developments, swift action, and momentum toward goals.'
        },

        {
          'question': 'What does Nine of Wands represent?',
          'answer': 'Resilience, persistence, courage, boundaries',
          'tags': ['resilience', 'persistence', 'courage', 'boundaries'],
          'wrong_ans': ['Celebration and joy', 'Manifestation and power', 'Harmony and balance'],
          'explanation': 'The Nine of Wands represents perseverance and maintaining strength despite previous challenges.'
        },

        {
          'question': 'What does Ten of Wands represent?',
          'answer': 'Burden, responsibility, hard work, stress',
          'tags': ['burden', 'responsibility', 'hard work', 'stress'],
          'wrong_ans': ['Freedom and adventure', 'Healing and hope', 'Justice and fairness'],
          'explanation': 'The Ten of Wands suggests carrying heavy responsibilities and feeling overwhelmed by obligations.'
        },

        {
          'question': 'What does Page of Wands represent?',
          'answer': 'Exploration, enthusiasm, discovery, free spirit',
          'tags': ['exploration', 'enthusiasm', 'discovery', 'adventure'],
          'wrong_ans': ['Material greed', 'Heartbreak and separation', 'Withdrawal and introspection'],
          'explanation': 'The Page of Wands symbolizes curiosity, enthusiasm, and the excitement of new possibilities.'
        },

        {
          'question': 'What does Knight of Wands represent?',
          'answer': 'Passion, energy, adventure, impulsiveness',
          'tags': ['passion', 'energy', 'adventure', 'action'],
          'wrong_ans': ['Patience and moderation', 'Fear and anxiety', 'Nurturing and abundance'],
          'explanation': 'The Knight of Wands represents energetic pursuit of goals, passion, and bold action.'
        },

        {
          'question': 'What does Queen of Wands represent?',
          'answer': 'Confidence, courage, independence, determination',
          'tags': ['confidence', 'courage', 'independence', 'determination'],
          'wrong_ans': ['Illusion and deception', 'Financial insecurity', 'Sacrifice and surrender'],
          'explanation': 'The Queen of Wands embodies confidence, charisma, independence, and passionate leadership.'
        },

        {
          'question': 'What does King of Wands represent?',
          'answer': 'Leadership, vision, inspiration, entrepreneurship',
          'tags': ['leadership', 'vision', 'inspiration', 'entrepreneurship'],
          'wrong_ans': ['Isolation and retreat', 'Emotional loss', 'Restriction and control'],
          'explanation': 'The King of Wands represents visionary leadership, ambition, and inspiring others through action.'
        }
      ]
    },


// --------------------------------------------------------------------------------------------------------------------------------------------


    'Cups': {
      'note_name': 'Cups',
      'question_list': [
        {
          'question': 'What does Ace of Cups represent?',
          'answer': 'Love, compassion, new feelings, emotional beginnings',
          'tags': ['love', 'compassion', 'emotions', 'beginnings'],
          'wrong_ans': ['Conflict and rivalry', 'Financial hardship', 'Restriction and control'],
          'explanation': 'The Ace of Cups signifies emotional renewal, love, compassion, and the beginning of meaningful relationships or creative inspiration.'
        },

        {
          'question': 'What does Two of Cups represent?',
          'answer': 'Partnership, unity, mutual attraction, connection',
          'tags': ['partnership', 'unity', 'connection', 'love'],
          'wrong_ans': ['Isolation and withdrawal', 'Sudden upheaval', 'Overwhelming burdens'],
          'explanation': 'The Two of Cups represents harmonious partnerships, mutual respect, and emotional connections.'
        },

        {
          'question': 'What does Three of Cups represent?',
          'answer': 'Celebration, friendship, community, joy',
          'tags': ['celebration', 'friendship', 'community', 'joy'],
          'wrong_ans': ['Heartbreak and sorrow', 'Competition and conflict', 'Fear and anxiety'],
          'explanation': 'The Three of Cups signifies friendship, social gatherings, celebration, and shared happiness.'
        },

        {
          'question': 'What does Four of Cups represent?',
          'answer': 'Contemplation, apathy, reevaluation, introspection',
          'tags': ['contemplation', 'apathy', 'reevaluation', 'introspection'],
          'wrong_ans': ['Rapid progress', 'Public recognition', 'Creative inspiration'],
          'explanation': 'The Four of Cups suggests introspection, emotional withdrawal, and reevaluating one\'s circumstances.'
        },

        {
          'question': 'What does Five of Cups represent?',
          'answer': 'Loss, grief, disappointment, regret',
          'tags': ['loss', 'grief', 'disappointment', 'regret'],
          'wrong_ans': ['Victory and success', 'Hope and healing', 'Tradition and conformity'],
          'explanation': 'The Five of Cups focuses on grief and disappointment while reminding us not to overlook remaining opportunities.'
        },

        {
          'question': 'What does Six of Cups represent?',
          'answer': 'Nostalgia, memories, childhood, innocence',
          'tags': ['nostalgia', 'memories', 'childhood', 'innocence'],
          'wrong_ans': ['Materialism and temptation', 'Competition and struggle', 'Authority and leadership'],
          'explanation': 'The Six of Cups represents fond memories, innocence, nostalgia, and reconnecting with the past.'
        },

        {
          'question': 'What does Seven of Cups represent?',
          'answer': 'Choices, fantasy, illusion, opportunities',
          'tags': ['choices', 'fantasy', 'illusion', 'opportunities'],
          'wrong_ans': ['Clear direction', 'Completion and fulfillment', 'Discipline and structure'],
          'explanation': 'The Seven of Cups represents many possibilities and warns against unrealistic expectations or illusions.'
        },

        {
          'question': 'What does Eight of Cups represent?',
          'answer': 'Walking away, transition, seeking truth, withdrawal',
          'tags': ['walking away', 'transition', 'truth', 'withdrawal'],
          'wrong_ans': ['Celebration and reunion', 'Financial abundance', 'Passionate action'],
          'explanation': 'The Eight of Cups signifies leaving behind unfulfilling situations in search of deeper meaning.'
        },

        {
          'question': 'What does Nine of Cups represent?',
          'answer': 'Contentment, satisfaction, wishes fulfilled, pleasure',
          'tags': ['contentment', 'satisfaction', 'wishes', 'pleasure'],
          'wrong_ans': ['Heartbreak and betrayal', 'Conflict and tension', 'Sudden destruction'],
          'explanation': 'The Nine of Cups is often known as the wish card, symbolizing satisfaction, pleasure, and emotional fulfillment.'
        },

        {
          'question': 'What does Ten of Cups represent?',
          'answer': 'Harmony, family happiness, fulfillment, alignment',
          'tags': ['harmony', 'family', 'happiness', 'fulfillment'],
          'wrong_ans': ['Isolation and loneliness', 'Stress and burden', 'Confusion and uncertainty'],
          'explanation': 'The Ten of Cups represents emotional fulfillment, harmonious relationships, and lasting happiness.'
        },

        {
          'question': 'What does Page of Cups represent?',
          'answer': 'Creativity, intuition, curiosity, emotional messages',
          'tags': ['creativity', 'intuition', 'curiosity', 'messages'],
          'wrong_ans': ['Aggressive competition', 'Rigid authority', 'Material loss'],
          'explanation': 'The Page of Cups symbolizes emotional openness, creativity, and intuitive insights.'
        },

        {
          'question': 'What does Knight of Cups represent?',
          'answer': 'Romance, charm, imagination, idealism',
          'tags': ['romance', 'charm', 'imagination', 'idealism'],
          'wrong_ans': ['Defensiveness and struggle', 'Restriction and bondage', 'Exhaustion and stress'],
          'explanation': 'The Knight of Cups represents pursuing dreams, romance, and creative or emotional aspirations.'
        },

        {
          'question': 'What does Queen of Cups represent?',
          'answer': 'Compassion, intuition, emotional security, nurturing',
          'tags': ['compassion', 'intuition', 'security', 'nurturing'],
          'wrong_ans': ['Material obsession', 'Aggressive ambition', 'Sudden disruption'],
          'explanation': 'The Queen of Cups embodies empathy, emotional maturity, and deep intuitive understanding.'
        },

        {
          'question': 'What does King of Cups represent?',
          'answer': 'Emotional balance, wisdom, diplomacy, compassion',
          'tags': ['balance', 'wisdom', 'diplomacy', 'compassion'],
          'wrong_ans': ['Impulsive behavior', 'Fear and anxiety', 'Competition and conflict'],
          'explanation': 'The King of Cups represents emotional mastery, wisdom, compassion, and calm leadership.'
        }
      ]
    },


// --------------------------------------------------------------------------------------------------------------------------------------------


    'Swords': {
      'note_name': 'Swords',
      'question_list': [
        {
          'question': 'What does Ace of Swords represent?',
          'answer': 'Clarity, truth, breakthroughs, new ideas',
          'tags': ['clarity', 'truth', 'breakthrough', 'ideas'],
          'wrong_ans': ['Emotional withdrawal', 'Celebration and joy', 'Material abundance'],
          'explanation': 'The Ace of Swords represents mental clarity, truth, and powerful new ideas or insights.'
        },

        {
          'question': 'What does Two of Swords represent?',
          'answer': 'Difficult decisions, stalemate, indecision, balance',
          'tags': ['decisions', 'stalemate', 'indecision', 'balance'],
          'wrong_ans': ['Rapid progress', 'Celebration with friends', 'Spiritual awakening'],
          'explanation': 'The Two of Swords suggests difficult choices and the need to confront avoided truths.'
        },

        {
          'question': 'What does Three of Swords represent?',
          'answer': 'Heartbreak, sorrow, grief, emotional pain',
          'tags': ['heartbreak', 'sorrow', 'grief', 'pain'],
          'wrong_ans': ['Harmony and union', 'Abundance and fertility', 'Recognition and success'],
          'explanation': 'The Three of Swords represents emotional pain, heartbreak, and difficult truths.'
        },

        {
          'question': 'What does Four of Swords represent?',
          'answer': 'Rest, recovery, contemplation, restoration',
          'tags': ['rest', 'recovery', 'contemplation', 'restoration'],
          'wrong_ans': ['Conflict and rivalry', 'Passion and adventure', 'Temptation and bondage'],
          'explanation': 'The Four of Swords encourages rest, healing, and taking time to recover mentally and physically.'
        },

        {
          'question': 'What does Five of Swords represent?',
          'answer': 'Conflict, tension, defeat, self-interest',
          'tags': ['conflict', 'tension', 'defeat', 'self-interest'],
          'wrong_ans': ['Celebration and success', 'Compassion and nurturing', 'Patience and moderation'],
          'explanation': 'The Five of Swords represents conflict, disagreements, and the consequences of winning at all costs.'
        },

        {
          'question': 'What does Six of Swords represent?',
          'answer': 'Transition, moving on, healing, change',
          'tags': ['transition', 'moving on', 'healing', 'change'],
          'wrong_ans': ['Stagnation and resistance', 'Financial prosperity', 'Joyful celebration'],
          'explanation': 'The Six of Swords signifies moving away from difficulties toward calmer circumstances.'
        },

        {
          'question': 'What does Seven of Swords represent?',
          'answer': 'Deception, strategy, secrecy, cunning',
          'tags': ['deception', 'strategy', 'secrecy', 'cunning'],
          'wrong_ans': ['Honesty and fairness', 'Family harmony', 'Creative inspiration'],
          'explanation': 'The Seven of Swords suggests strategy, secrecy, or deceptive behavior requiring caution.'
        },

        {
          'question': 'What does Eight of Swords represent?',
          'answer': 'Restriction, imprisonment, helplessness, limitation',
          'tags': ['restriction', 'helplessness', 'limitation', 'imprisonment'],
          'wrong_ans': ['Freedom and adventure', 'Celebration and reunion', 'Success and victory'],
          'explanation': 'The Eight of Swords represents feeling trapped by limiting beliefs or circumstances.'
        },

        {
          'question': 'What does Nine of Swords represent?',
          'answer': 'Anxiety, worry, fear, nightmares',
          'tags': ['anxiety', 'worry', 'fear', 'nightmares'],
          'wrong_ans': ['Hope and inspiration', 'Achievement and recognition', 'Balance and harmony'],
          'explanation': 'The Nine of Swords represents mental anguish, anxiety, and excessive worry.'
        },

        {
          'question': 'What does Ten of Swords represent?',
          'answer': 'Endings, betrayal, painful conclusions, collapse',
          'tags': ['endings', 'betrayal', 'conclusions', 'collapse'],
          'wrong_ans': ['New beginnings', 'Romantic partnership', 'Emotional fulfillment'],
          'explanation': 'The Ten of Swords signifies painful endings that clear the way for renewal.'
        },

        {
          'question': 'What does Page of Swords represent?',
          'answer': 'Curiosity, communication, vigilance, new ideas',
          'tags': ['curiosity', 'communication', 'vigilance', 'ideas'],
          'wrong_ans': ['Emotional contentment', 'Material abundance', 'Nurturing energy'],
          'explanation': 'The Page of Swords represents curiosity, learning, communication, and mental agility.'
        },

        {
          'question': 'What does Knight of Swords represent?',
          'answer': 'Ambition, action, determination, assertiveness',
          'tags': ['ambition', 'action', 'determination', 'assertiveness'],
          'wrong_ans': ['Patience and moderation', 'Withdrawal and solitude', 'Romantic harmony'],
          'explanation': 'The Knight of Swords symbolizes determined action, ambition, and pursuing goals fearlessly.'
        },

        {
          'question': 'What does Queen of Swords represent?',
          'answer': 'Independence, honesty, clarity, perceptiveness',
          'tags': ['independence', 'honesty', 'clarity', 'perception'],
          'wrong_ans': ['Fantasy and illusion', 'Material greed', 'Passionate impulsiveness'],
          'explanation': 'The Queen of Swords represents clear thinking, honesty, independence, and wisdom.'
        },

        {
          'question': 'What does King of Swords represent?',
          'answer': 'Authority, intellect, truth, discipline',
          'tags': ['authority', 'intellect', 'truth', 'discipline'],
          'wrong_ans': ['Emotional confusion', 'Celebration and friendship', 'Overwhelming stress'],
          'explanation': 'The King of Swords symbolizes intellectual authority, truth, fairness, and disciplined leadership.'
        }
      ]
    },


// --------------------------------------------------------------------------------------------------------------------------------------------


    'Pentacles': {
    'note_name': 'Pentacles',
    'question_list': [
      {
        'question': 'What does Ace of Pentacles represent?',
        'answer': 'Opportunity, prosperity, abundance, manifestation',
        'tags': ['opportunity', 'prosperity', 'abundance', 'manifestation'],
        'wrong_ans': ['Heartbreak and sorrow', 'Illusion and fantasy', 'Conflict and rivalry'],
        'explanation': 'The Ace of Pentacles signifies new financial opportunities, prosperity, and tangible beginnings.'
      },

      {
        'question': 'What does Two of Pentacles represent?',
        'answer': 'Balance, adaptability, priorities, flexibility',
        'tags': ['balance', 'adaptability', 'priorities', 'flexibility'],
        'wrong_ans': ['Isolation and retreat', 'Sudden destruction', 'Emotional grief'],
        'explanation': 'The Two of Pentacles represents balancing multiple responsibilities and adapting to change.'
      },

      {
        'question': 'What does Three of Pentacles represent?',
        'answer': 'Teamwork, collaboration, learning, craftsmanship',
        'tags': ['teamwork', 'collaboration', 'learning', 'craftsmanship'],
        'wrong_ans': ['Deception and secrecy', 'Anxiety and fear', 'Withdrawal and introspection'],
        'explanation': 'The Three of Pentacles highlights cooperation, teamwork, and developing skills through collaboration.'
      },

      {
        'question': 'What does Four of Pentacles represent?',
        'answer': 'Security, conservation, control, stability',
        'tags': ['security', 'conservation', 'control', 'stability'],
        'wrong_ans': ['Adventure and freedom', 'Celebration and joy', 'Compassion and empathy'],
        'explanation': 'The Four of Pentacles represents financial security but can also suggest possessiveness or control.'
      },

      {
        'question': 'What does Five of Pentacles represent?',
        'answer': 'Hardship, poverty, insecurity, struggle',
        'tags': ['hardship', 'poverty', 'insecurity', 'struggle'],
        'wrong_ans': ['Success and victory', 'Family happiness', 'Creative inspiration'],
        'explanation': 'The Five of Pentacles signifies financial difficulties, hardship, and feelings of exclusion.'
      },

      {
        'question': 'What does Six of Pentacles represent?',
        'answer': 'Generosity, charity, sharing, support',
        'tags': ['generosity', 'charity', 'sharing', 'support'],
        'wrong_ans': ['Conflict and tension', 'Anxiety and nightmares', 'Restriction and limitation'],
        'explanation': 'The Six of Pentacles represents generosity, balance in giving and receiving, and mutual support.'
      },

      {
        'question': 'What does Seven of Pentacles represent?',
        'answer': 'Patience, investment, perseverance, long-term growth',
        'tags': ['patience', 'investment', 'perseverance', 'growth'],
        'wrong_ans': ['Impulsive action', 'Heartbreak and grief', 'Fantasy and illusion'],
        'explanation': 'The Seven of Pentacles encourages patience and evaluating progress toward long-term goals.'
      },

      {
        'question': 'What does Eight of Pentacles represent?',
        'answer': 'Skill, diligence, craftsmanship, mastery',
        'tags': ['skill', 'diligence', 'craftsmanship', 'mastery'],
        'wrong_ans': ['Withdrawal and apathy', 'Competition and rivalry', 'Sudden change and upheaval'],
        'explanation': 'The Eight of Pentacles signifies dedication to mastering skills through hard work and practice.'
      },

      {
        'question': 'What does Nine of Pentacles represent?',
        'answer': 'Luxury, independence, self-sufficiency, abundance',
        'tags': ['luxury', 'independence', 'abundance', 'self-sufficiency'],
        'wrong_ans': ['Burden and stress', 'Fear and anxiety', 'Conflict and defeat'],
        'explanation': 'The Nine of Pentacles represents enjoying the rewards of hard work, independence, and prosperity.'
      },

      {
        'question': 'What does Ten of Pentacles represent?',
        'answer': 'Legacy, wealth, family, long-term success',
        'tags': ['legacy', 'wealth', 'family', 'success'],
        'wrong_ans': ['Emotional withdrawal', 'Sudden endings', 'Confusion and uncertainty'],
        'explanation': 'The Ten of Pentacles symbolizes lasting success, family stability, and generational wealth.'
      },

      {
        'question': 'What does Page of Pentacles represent?',
        'answer': 'Ambition, learning, opportunity, diligence',
        'tags': ['ambition', 'learning', 'opportunity', 'diligence'],
        'wrong_ans': ['Deception and manipulation', 'Romantic idealism', 'Isolation and solitude'],
        'explanation': 'The Page of Pentacles represents new opportunities for learning, growth, and practical achievement.'
      },

      {
        'question': 'What does Knight of Pentacles represent?',
        'answer': 'Hard work, reliability, responsibility, persistence',
        'tags': ['hard work', 'reliability', 'responsibility', 'persistence'],
        'wrong_ans': ['Impulsive adventure', 'Fantasy and dreams', 'Emotional instability'],
        'explanation': 'The Knight of Pentacles symbolizes steady progress, reliability, and dedication to long-term goals.'
      },

      {
        'question': 'What does Queen of Pentacles represent?',
        'answer': 'Nurturing, practicality, abundance, security',
        'tags': ['nurturing', 'practicality', 'abundance', 'security'],
        'wrong_ans': ['Conflict and aggression', 'Illusion and uncertainty', 'Heartbreak and sorrow'],
        'explanation': 'The Queen of Pentacles embodies practicality, generosity, nurturing, and creating comfort and security.'
      },

      {
        'question': 'What does King of Pentacles represent?',
        'answer': 'Prosperity, success, leadership, security',
        'tags': ['prosperity', 'success', 'leadership', 'security'],
        'wrong_ans': ['Fear and anxiety', 'Emotional withdrawal', 'Restriction and helplessness'],
        'explanation': 'The King of Pentacles represents financial success, stability, abundance, and dependable leadership.'
      }
    ]
  }


// --------------------------------------------------------------------------------------------------------------------------------------------
  };
  return defaultNotes; 
}