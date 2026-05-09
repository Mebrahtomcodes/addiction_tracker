

enum AddictionCategory {
  sexual,
  substance,
  socialMedia,
  gaming,
  gambling,
  eating,
  procrastination,
  general
}

class QuoteService {
  static AddictionCategory _categorizeTracker(String title) {
    final lowerTitle = title.toLowerCase();

    // Sexual / Dopamine
    if (lowerTitle.contains('porn') ||
        lowerTitle.contains('masturbation') ||
        lowerTitle.contains('lust') ||
        lowerTitle.contains('goon') ||
        lowerTitle.contains('fap') ||
        lowerTitle.contains('nofap') ||
        lowerTitle.contains('edge') ||
        lowerTitle.contains('pmo') ||
        lowerTitle.contains('sex') ||
        lowerTitle.contains('onlyfans')) {
      return AddictionCategory.sexual;
    }

    // Substance
    if (lowerTitle.contains('smok') ||
        lowerTitle.contains('nicotine') ||
        lowerTitle.contains('vape') ||
        lowerTitle.contains('alcohol') ||
        lowerTitle.contains('drink') ||
        lowerTitle.contains('drunk') ||
        lowerTitle.contains('drug') ||
        lowerTitle.contains('weed') ||
        lowerTitle.contains('coke') ||
        lowerTitle.contains('pill') ||
        lowerTitle.contains('high') ||
        lowerTitle.contains('zyn') ||
        lowerTitle.contains('snus') ||
        lowerTitle.contains('cigar') ||
        lowerTitle.contains('thc')) {
      return AddictionCategory.substance;
    }

    // Behavioral: Social Media & Phone
    if (lowerTitle.contains('tiktok') ||
        lowerTitle.contains('instagram') ||
        lowerTitle.contains('ig') ||
        lowerTitle.contains('facebook') ||
        lowerTitle.contains('twitter') ||
        lowerTitle.contains('x') ||
        lowerTitle.contains('snapchat') ||
        lowerTitle.contains('reddit') ||
        lowerTitle.contains('youtube') ||
        lowerTitle.contains('phone') ||
        lowerTitle.contains('screen') ||
        lowerTitle.contains('scroll') ||
        lowerTitle.contains('social media') ||
        lowerTitle.contains('internet')) {
      return AddictionCategory.socialMedia;
    }

    // Behavioral: Gaming
    if (lowerTitle.contains('gam') ||
        lowerTitle.contains('playstation') ||
        lowerTitle.contains('xbox') ||
        lowerTitle.contains('pc') ||
        lowerTitle.contains('league') ||
        lowerTitle.contains('valorant') ||
        lowerTitle.contains('wow') ||
        lowerTitle.contains('console')) {
      return AddictionCategory.gaming;
    }

    // Behavioral: Gambling
    if (lowerTitle.contains('gambl') ||
        lowerTitle.contains('bet') ||
        lowerTitle.contains('casino') ||
        lowerTitle.contains('slot') ||
        lowerTitle.contains('poker') ||
        lowerTitle.contains('parlay') ||
        lowerTitle.contains('crypto') ||
        lowerTitle.contains('trade') ||
        lowerTitle.contains('wager')) {
      return AddictionCategory.gambling;
    }

    // Behavioral: Eating / Junk Food
    if (lowerTitle.contains('eat') ||
        lowerTitle.contains('food') ||
        lowerTitle.contains('junk') ||
        lowerTitle.contains('sugar') ||
        lowerTitle.contains('sweet') ||
        lowerTitle.contains('binge') ||
        lowerTitle.contains('diet') ||
        lowerTitle.contains('fat') ||
        lowerTitle.contains('carb') ||
        lowerTitle.contains('snack') ||
        lowerTitle.contains('chocolate') ||
        lowerTitle.contains('soda')) {
      return AddictionCategory.eating;
    }

    // Behavioral: Procrastination
    if (lowerTitle.contains('procrastinat') ||
        lowerTitle.contains('lazy') ||
        lowerTitle.contains('work') ||
        lowerTitle.contains('study') ||
        lowerTitle.contains('focus') ||
        lowerTitle.contains('delay') ||
        lowerTitle.contains('later')) {
      return AddictionCategory.procrastination;
    }

    return AddictionCategory.general;
  }

  static String _cleanTitle(String title) {
    String cleaned = title.toLowerCase().trim();
    
    // Remove common negative prefixes
    final prefixes = [
      "no more ", "no ", "quit ", "quitting ", "stop ", "stopping ", 
      "giving up ", "free from ", "without ", "end "
    ];
    
    for (var prefix in prefixes) {
      if (cleaned.startsWith(prefix)) {
        cleaned = cleaned.substring(prefix.length).trim();
        break; // Only remove the first matching prefix
      }
    }
    
    if (cleaned.isEmpty) return title; // Fallback if they just typed "No"
    
    // Capitalize each word for a cleaner look in the sentence
    return cleaned.split(' ').map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

  static List<String> getMotivations(String title) {
    title = _cleanTitle(title);
    final category = _categorizeTracker(title);
    List<String> list = [];

    switch (category) {
      case AddictionCategory.sexual:
        list = [
          "You are starving the dopamine loop of $title. Keep going.",
          "Real intimacy requires a healthy mind. Walk away from $title.",
          "Every day free from $title rewires your brain for the real world.",
          "You are breaking the edge cycle. Honor your progress.",
          "Pixels cannot give you purpose. Leaving $title behind will.",
          "Your brain is healing from the artificial highs of $title.",
          "Don't trade your vital energy for $title. Build an empire instead.",
          "The illusion of $title is fading. Your true strength is returning.",
          "You are reclaiming your mind from the grip of $title.",
          "Stay strong. The withdrawal from $title is just weakness leaving your body.",
        ];
        break;
      case AddictionCategory.substance:
        list = [
          "Every craving for $title you beat is a victory for your health.",
          "Your lungs and liver are healing. Don't let $title destroy them.",
          "The chemical dependency of $title has no power over your will.",
          "You don't need $title to cope. You have undeniable strength.",
          "Breathe in freedom. Exhale the need for $title.",
          "Sobriety is a superpower. Every day without $title is proof.",
          "You are flushing the poison of $title out of your life.",
          "You are stronger than the temporary relief $title promises.",
          "The urge to use $title is just a chemical lie. Don't listen.",
          "Every clean day puts more distance between you and $title.",
        ];
        break;
      case AddictionCategory.socialMedia:
        list = [
          "The endless scroll of $title is stealing your time. Reclaim it.",
          "Don't let the algorithm of $title dictate your life.",
          "Put the screen down. Real life is happening outside of $title.",
          "Every minute away from $title is a minute invested in your future.",
          "You are starving the cheap dopamine hits of $title.",
          "The comparison trap of $title ends today. Focus on your own path.",
          "Your attention span is healing every day you avoid $title.",
          "Stop watching others live on $title and start living your own.",
          "The notifications from $title don't define your worth.",
          "You are taking back control of your focus from $title.",
        ];
        break;
      case AddictionCategory.gaming:
        list = [
          "Level up in real life instead of wasting hours on $title.",
          "The virtual achievements in $title mean nothing out here. Build real stats.",
          "You are escaping the matrix of $title to conquer reality.",
          "The grind belongs in your real life, not inside $title.",
          "Your potential is far greater than your rank in $title.",
          "Unplug from $title and plug into your actual goals.",
          "Every hour away from $title is an hour you can use to build your future.",
          "The escape that $title provides is temporary. Real growth is permanent.",
          "Stop being a hero in $title. Be the hero of your own life.",
          "You are breaking the cycle of digital isolation caused by $title.",
        ];
        break;
      case AddictionCategory.gambling:
        list = [
          "The house always wins. By walking away from $title, you win.",
          "Stop chasing the losses of $title. Chase your potential instead.",
          "Financial freedom is built with hard work, not the illusion of $title.",
          "The thrill of $title is a trap. True peace comes from discipline.",
          "Every day you avoid $title, you are taking back control of your future.",
          "Don't gamble your life away on $title. Invest in yourself.",
          "The urge to bet on $title is a lie. Discipline is the only sure thing.",
          "You are breaking the chains of the $title cycle.",
          "True wealth isn't found in $title. It's built day by day.",
          "Walking away from $title is the greatest wager you've ever won.",
        ];
        break;
      case AddictionCategory.eating:
        list = [
          "Nourish your body. You are stronger than the craving for $title.",
          "You are taking control of your health by saying no to $title.",
          "The temporary comfort of $title is not worth the long-term regret.",
          "Your energy is returning as you break the cycle of $title.",
          "Eat for purpose, not for the emotional escape of $title.",
          "You are respecting your body by walking away from $title.",
          "The sugar crash from $title has no power here. Stay focused.",
          "Discipline feels better than yielding to $title.",
          "Every time you deny $title, you are building a stronger version of yourself.",
          "You are in charge of your choices, not the craving for $title.",
        ];
        break;
      case AddictionCategory.procrastination:
        list = [
          "Time is finite. By defeating $title, you are owning your time.",
          "Action cures fear. Beat $title by doing the hard work now.",
          "Your future self is begging you to overcome $title today.",
          "Discipline is doing it now. Say no to $title.",
          "The pain of discipline weighs ounces. The pain of $title weighs tons.",
          "Stop delaying your greatness. $title is the enemy of progress.",
          "You are building momentum every time you crush $title.",
          "Perfect conditions don't exist. Execute anyway and defeat $title.",
          "Every action you take kills the paralysis of $title.",
          "You are an action-taker. $title has no place in your routine.",
        ];
        break;
      case AddictionCategory.general:
        list = [
          "Every journey starts with a single step. Keep going.",
          "You're building real momentum. Don't stop now.",
          "You are becoming the master of your own mind.",
          "Discipline is the bridge to your goals.",
          "Freedom is not the absence of discipline, but the conquest of yourself.",
          "Strength comes from an indomitable will.",
          "Success is the sum of small efforts, repeated daily.",
          "The secret of your future is hidden in your daily routine.",
          "Your future self will thank you for today.",
          "You are stronger than your strongest excuse.",
        ];
        break;
    }

    // Add general powerful quotes to all lists to ensure variety (pool of ~50)
    list.addAll([
      "Consistency is the playground of excellence.",
      "The harder the struggle, the more glorious the triumph.",
      "Success is walking from failure to failure with no loss of enthusiasm.",
      "Discipline is the ability to do what is right even when it's hard.",
      "You are the architect of your own recovery.",
      "One day at a time. One choice at a time.",
      "You are capable of more than you know.",
      "Stay hungry, stay foolish, stay disciplined.",
      "Integrity is choosing courage over comfort.",
      "Your mind is a powerful thing. When you fill it with positive thoughts, your life will change."
    ]);

    return list;
  }

  static List<String> getUrgeSentences(String title) {
    title = _cleanTitle(title);
    final category = _categorizeTracker(title);
    List<String> list = [];

    switch (category) {
      case AddictionCategory.sexual:
        list = [
          "The urge to view $title is just a spike in dopamine. Ride the wave.",
          "Don't let the edge cycle of $title drag you back down.",
          "Pixels on a screen ($title) are not worth your real-world energy.",
          "Your brain is craving the artificial high of $title. Deny it.",
          "Close your eyes. Breathe. The ghost of $title will pass.",
        ];
        break;
      case AddictionCategory.substance:
        list = [
          "The physical craving for $title is temporary. Your health is permanent.",
          "Don't let the chemical hook of $title lie to you right now.",
          "Inhale clean air. Exhale the desire for $title.",
          "You've survived every urge for $title so far. You'll survive this one.",
          "A moment of weakness for $title is not worth starting over.",
        ];
        break;
      case AddictionCategory.socialMedia:
        list = [
          "The algorithm of $title is trying to pull you in. Don't let it.",
          "The urge to scroll $title is just a habit loop. Break it.",
          "Put the phone down. $title has nothing real to offer you right now.",
          "Your attention is valuable. Don't give it away to $title.",
          "Disconnect from $title and reconnect with yourself.",
        ];
        break;
      case AddictionCategory.gaming:
        list = [
          "The urge to escape into $title will fade. Stay in reality.",
          "Don't trade your real-world progress for virtual stats in $title.",
          "The game of $title is designed to trap you. Step away.",
          "Your real life needs grinding more than $title does.",
          "Turn it off. $title can wait. Your future cannot.",
        ];
        break;
      case AddictionCategory.gambling:
        list = [
          "The urge to chase the loss in $title is a trap. Walk away.",
          "The thrill of $title is an illusion designed to break you.",
          "Keep your money and your dignity. Say no to $title.",
          "The house always wins in $title. Be the house of your own life.",
          "Don't risk your peace of mind for the chaos of $title.",
        ];
        break;
      case AddictionCategory.eating:
        list = [
          "The craving for $title is just emotional hunger. Drink water.",
          "You are not hungry, you are just bored. Walk away from $title.",
          "The sugar rush of $title lasts minutes. The regret lasts hours.",
          "You have the power to say no to $title right now.",
          "Nourish your discipline, starve the urge for $title.",
        ];
        break;
      case AddictionCategory.procrastination:
        list = [
          "The urge to delay and choose $title is fear in disguise.",
          "Do it now. $title is the enemy of your success.",
          "Action destroys the urge for $title. Take one small step.",
          "Don't let $title steal another hour from your life.",
          "The discomfort of starting is nothing compared to the pain of $title.",
        ];
        break;
      case AddictionCategory.general:
        list = [
          "The urge is just a wave. Ride it.",
          "This feeling is temporary. Your integrity is permanent.",
          "Don't trade your future self for a few seconds of pleasure.",
          "You are stronger than the pull of the habit.",
          "Think about why you started. Don't let that person down.",
        ];
        break;
    }

    // Add generic urge sentences
    list.addAll([
      "Your brain is lying to you right now. Don't believe it.",
      "A moment of weakness is not worth a lifetime of regret.",
      "Urges are like clouds; they pass if you just wait.",
      "Focus on your breath. Inhale strength, exhale the urge.",
      "You are the master of your actions, not your impulses.",
      "Imagine the pride you'll feel tomorrow if you stay strong now.",
      "One minute of discipline saves hours of guilt.",
      "Your future is being built by the choices you make today.",
      "Feel the urge, then choose to let it go.",
      "You are rewiring your brain every second you resist."
    ]);

    return list;
  }

  static List<String> getProgressMessages(String title) {
    title = _cleanTitle(title);
    final category = _categorizeTracker(title);
    
    if (category == AddictionCategory.general || title.toLowerCase() == "default tracker") {
      return [
        "🔥 Keep going. You're doing great.",
        "Small discipline daily = big future.",
        "Your future self will thank you.",
        "Progress is built one clean day at a time.",
        "Every clean day rewires your future.",
        "You are significantly stronger than your habit.",
        "One decision today can change your life.",
        "Stay focused. Your consistency is paying off.",
        "Keep building the version of yourself you respect.",
        "Discipline today creates freedom tomorrow.",
      ];
    }
    
    return [
      "🔥 Keep going. You're defeating $title.",
      "Small discipline daily against $title = big future.",
      "Your future self will thank you for leaving $title behind.",
      "Progress is built one clean day away from $title at a time.",
      "Every clean day rewires your brain away from $title.",
      "You are significantly stronger than $title.",
      "One decision to reject $title today can change your life.",
      "Stay focused. Your consistency against $title is paying off.",
      "Keep building the version of yourself that doesn't need $title.",
      "Discipline over $title today creates freedom tomorrow.",
    ];
  }

  static List<String> getRecoveryMessages(String title) {
    title = _cleanTitle(title);
    final category = _categorizeTracker(title);
    
    if (category == AddictionCategory.general || title.toLowerCase() == "default tracker") {
      return [
        "One bad moment does not erase your overall progress.",
        "Stand back up and continue the fight.",
        "Recovery is built by starting again.",
        "Your comeback matters more than your setback.",
        "A relapse is not the end of your journey.",
      ];
    }
    
    return [
      "One bad moment with $title does not erase your overall progress.",
      "Stand back up and continue the fight against $title.",
      "Recovery from $title is built by starting again.",
      "Your comeback from $title matters more than your setback.",
      "A relapse with $title is not the end of your journey.",
    ];
  }

  static List<String> getNeutralMessages(String title) {
    title = _cleanTitle(title);
    final category = _categorizeTracker(title);
    
    if (category == AddictionCategory.general || title.toLowerCase() == "default tracker") {
      return [
        "A new day is a fresh start. Make it count.",
        "Stay mindful of your choices today.",
        "Breathe, focus, and take the fight one step at a time.",
        "You have the power to control your day.",
      ];
    }
    
    return [
      "A new day is a fresh start to conquer $title. Make it count.",
      "Stay mindful of your choices regarding $title today.",
      "Breathe, focus, and take the fight against $title one step at a time.",
      "You have the power to control your day, not $title.",
    ];
  }
}
