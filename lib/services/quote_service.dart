enum AddictionCategory {
  sexual,
  substance,
  socialMedia,
  gaming,
  gambling,
  eating,
  procrastination,
  general,
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

  static String cleanTitle(String title) {
    String cleaned = title.toLowerCase().trim();

    // Remove common negative prefixes
    final prefixes = [
      "no more ",
      "no ",
      "quit ",
      "quitting ",
      "stop ",
      "stopping ",
      "giving up ",
      "free from ",
      "without ",
      "end ",
    ];

    for (var prefix in prefixes) {
      if (cleaned.startsWith(prefix)) {
        cleaned = cleaned.substring(prefix.length).trim();
        break; // Only remove the first matching prefix
      }
    }

    if (cleaned.isEmpty) return title; // Fallback if they just typed "No"

    // Capitalize each word for a cleaner look in the sentence
    return cleaned
        .split(' ')
        .map((word) {
          if (word.isEmpty) return '';
          return word[0].toUpperCase() + word.substring(1);
        })
        .join(' ');
  }

  static List<String> getMotivations(String title) {
    title = cleanTitle(title);
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
          "Your brain is healing from the artificial highs.",
          "Don't trade your vital energy for temporary pleasure. Build an empire instead.",
          "The illusion of $title is fading. Your true strength is returning.",
          "You are reclaiming your mind from the grip of $title.",
          "Stay strong. The withdrawal from $title is just weakness leaving your body.",
          "Your focus and clarity are returning every single day.",
          "Respect yourself enough to walk away from artificial stimulation.",
          "You are building immense self-control by denying $title.",
          "The fog is lifting. Embrace the clear reality in front of you.",
          "Your energy belongs to you, not to a screen.",
          "Channel your drive into real connection and growth, away from $title.",
          "You are outgrowing the need for $title.",
          "Every victory over $title strengthens your willpower.",
          "Choose reality. Choose genuine connections.",
          "You are breaking the chains of instant gratification.",
          "Your mind is becoming sharper and more resilient.",
          "Step away from $title and step into your full potential.",
          "Lust is a fleeting shadow. Discipline is an enduring light.",
          "You are proving that you master your instincts, not the other way around.",
          "By letting go of $title, you are making room for true greatness.",
          "Your journey of self-mastery is just beginning.",
          "Refuse to be a slave to your impulses. Be a king of your actions.",
          "You don't need $title to feel alive. Real life is enough.",
          "Your vitality is returning. Use it to build something incredible.",
          "Every time you say no to $title, you say yes to your future.",
          "The pull of $title is temporary. Your self-respect is permanent.",
          "You are rewriting your brain's reward system. This is true power.",
          "Don't let a pixelated fantasy hold you back from real achievements.",
          "You are becoming the person you always knew you could be.",
          "Walk tall. You are defeating $title day by day.",
          "Let the urges wash over you. You are the rock that remains.",
          "You are reclaiming your innocence and your focus.",
          "A life free from $title is a life full of endless possibilities.",
          "You are cultivating a pure, driven, and unstoppable mind.",
          "No more hiding. You are stepping into the light.",
          "Your capacity for real joy is expanding as you leave $title behind.",
          "Take pride in your restraint. It is your greatest asset.",
          "You are shedding the weight of $title and rising higher.",
          "The path of discipline is steep, but the view is breathtaking.",
          "You are choosing long-term fulfillment over short-term escape.",
          "Honor your commitment. $title has nothing left to offer you.",
          "You are building a fortress of mental clarity and strength.",
          "The craving will pass, but the pride of beating $title will last.",
          "You are transforming your energy into a force for good.",
          "Keep moving forward. The best version of you is waiting.",
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
          "Your body is a temple. Treat it with the respect it deserves.",
          "You are taking back control of your biology from $title.",
          "Clarity of mind is far better than any artificial high.",
          "You are breaking the chains of dependency, one day at a time.",
          "Feel the life returning to your body. Honor that progress.",
          "You don't need $title to feel normal. Normal is being free.",
          "The withdrawal is just the sound of $title losing its grip.",
          "You are investing in a longer, healthier, and happier life.",
          "The fog of $title is clearing. Embrace the sharp edges of reality.",
          "You are proving that your spirit is stronger than any substance.",
          "Every time you resist $title, your body thanks you.",
          "You are cultivating natural energy and true resilience.",
          "Don't numb the pain. Face it and grow stronger without $title.",
          "You are waking up from the chemical slumber. Stay awake.",
          "Your future self is grateful for the boundaries you set against $title today.",
          "You are reclaiming your finances, your health, and your freedom.",
          "The temporary escape of $title is a trap. Stay in the real world.",
          "You are building a life that you don't need to escape from.",
          "Every breath without $title is a breath of true freedom.",
          "You are restoring the balance in your mind and body.",
          "The journey of recovery from $title is a journey of heroism.",
          "You are turning your pain into power, without relying on $title.",
          "Choose clarity. Choose health. Choose freedom.",
          "You are a warrior, fighting the invisible enemy of $title and winning.",
          "Your natural state is vibrant and clear. Don't cloud it.",
          "You are washing away the residue of $title from your life.",
          "Stand firm. The chemical storm will pass, leaving you stronger.",
          "You are rebuilding your life on a foundation of truth, not $title.",
          "The best high is the feeling of absolute self-control.",
          "You are proving that $title does not define you.",
          "Every clean day is a masterpiece of discipline and strength.",
          "You are stepping out of the shadow of $title and into the light.",
          "Your potential is limitless when you aren't held back by $title.",
          "You are healing. Be patient with yourself, but firm against $title.",
          "The craving is a lie. Your health and freedom are the truth.",
          "You are writing a new, triumphant chapter in your life, free from $title.",
          "Embrace the raw, unfiltered beauty of life without $title.",
          "You are becoming a beacon of strength and recovery.",
          "Keep your guard up and your head high. You are beating $title.",
          "Your life is too valuable to waste on $title. Keep climbing.",
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
          "Your time is your most valuable asset. Don't give it away to a feed.",
          "You are breaking out of the digital echo chamber. Think for yourself.",
          "Disconnect to reconnect. The real world is waiting for you.",
          "You are building a life of intention, not a life of distraction.",
          "The highlight reels on $title are illusions. Your real life is beautiful.",
          "You are reclaiming your mental space from the noise of $title.",
          "Boredom is the birthplace of creativity. Embrace it, don't numb it with $title.",
          "You are choosing deep work and meaningful connection over shallow scrolling.",
          "The world is so much bigger than the screen of $title.",
          "You are regaining your ability to focus deeply and think clearly.",
          "Don't be a consumer of $title. Be a creator of your own life.",
          "Your peace of mind is worth more than staying updated on $title.",
          "You are unhooking yourself from the constant need for validation.",
          "Look up. The sky, the trees, the people around you—that is reality.",
          "You are detoxing your brain from the constant stimulation of $title.",
          "Every hour without $title is an hour of true freedom.",
          "You are protecting your energy from the negativity of $title.",
          "Stop comparing your behind-the-scenes to their $title highlight reel.",
          "You are cultivating a rich inner life, independent of $title.",
          "The algorithm wants your attention. Give it to your goals instead.",
          "You are becoming present in the moment, free from the pull of $title.",
          "Your worth is not measured in likes, comments, or followers.",
          "You are breaking the cycle of constant digital distraction.",
          "Step out of the virtual world and into the physical one.",
          "You are reclaiming your morning routines from the grip of $title.",
          "Your thoughts are becoming your own again, free from $title's influence.",
          "You are choosing real conversations over digital interactions.",
          "The urge to check $title is fading. Your focus is returning.",
          "You are building a life that looks good to you, not just good on $title.",
          "You are mastering your attention, the ultimate currency of the modern age.",
          "Leave the infinite scroll behind. Pursue infinite growth instead.",
          "You are protecting your mental health by stepping away from $title.",
          "Your life is a story worth living, not just a story worth posting.",
          "You are finding joy in the simple, unplugged moments.",
          "The digital noise is silencing. Listen to your own voice.",
          "You are breaking the habit loop. You are in control, not $title.",
          "Your relationships are deepening as you put $title away.",
          "You are trading empty content for meaningful experiences.",
          "The freedom of being disconnected is exhilarating. Enjoy it.",
          "Keep your eyes on your own path. You are doing great.",
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
          "Real life has the best graphics and the highest stakes. Play it.",
          "You are trading virtual rewards for tangible success.",
          "Your skills in $title don't pay the bills. Build skills that do.",
          "You are reclaiming your time and energy from the digital world.",
          "The real world is an open world waiting for you to explore it.",
          "You are defeating the ultimate boss: your own procrastination.",
          "The dopamine hit of winning in $title is a fraction of the joy of real achievement.",
          "You are building a legacy, not a save file.",
          "Step away from the controller and take control of your destiny.",
          "You are transforming your gaming focus into laser-sharp ambition.",
          "The virtual world will always be there. Your youth and time will not.",
          "You are choosing the hard path of reality over the easy path of $title.",
          "Your health, relationships, and career are leveling up as you leave $title.",
          "You are becoming the main character in your own life.",
          "The urge to play $title is just a desire for accomplishment. Accomplish something real.",
          "You are unplugging from the simulation and waking up.",
          "Your competitive spirit belongs in the real world, not in $title.",
          "You are breaking the habit of escaping your problems through gaming.",
          "Face your real-life challenges head-on instead of hiding in $title.",
          "You are building a life that is more exciting than any game.",
          "The camaraderie in $title is a shadow of real-life friendship. Seek it out.",
          "You are reclaiming your sleep schedule and your physical health.",
          "Your mind is expanding beyond the boundaries of $title's map.",
          "You are taking back your attention and focusing it on what matters.",
          "The virtual grind is an illusion. The real grind brings true rewards.",
          "You are proving that you can delay gratification and work for long-term goals.",
          "Your reality is becoming your new favorite game to play.",
          "You are stepping out of the comfort zone of $title and into the growth zone.",
          "The urge to boot up $title is a test of your resolve. Pass it.",
          "You are writing your own epic story, one real-life day at a time.",
          "Leave the digital avatars behind and cultivate your true self.",
          "You are finding adventure in the physical world, free from $title.",
          "Your focus is shifting from a screen to the horizon of your potential.",
          "You are breaking the spell of $title and seeing clearly again.",
          "The energy you poured into $title is now fueling your real-life success.",
          "You are building a kingdom of discipline, not a digital fantasy.",
          "Your progress in life is saving automatically. Keep moving forward.",
          "You are choosing reality, with all its flaws and beauty, over $title.",
          "The game is over. Your real life begins now.",
          "Keep your head up. You are winning the most important game of all.",
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
          "You are protecting your hard-earned money and your peace of mind.",
          "The dopamine rush of $title is a fleeting illusion. True security is lasting.",
          "You are choosing steady, reliable progress over reckless chance.",
          "Your financial future is too important to leave to $title.",
          "You are rebuilding your life on a foundation of certainty, not luck.",
          "The casino wants your hope. Don't give it to them.",
          "You are taking back your power from the odds and the algorithms.",
          "Every day without a bet on $title is a deposit into your future.",
          "You are escaping the rollercoaster of wins and devastating losses.",
          "Your worth is not determined by a winning streak or a bad beat.",
          "You are choosing a life of stability and self-respect over $title.",
          "The thrill of the gamble is nothing compared to the peace of financial control.",
          "You are breaking the cycle of chasing the next big hit in $title.",
          "You are investing your time and money into things that actually grow.",
          "The only sure bet is the investment you make in your own discipline.",
          "You are walking away from the table and into a brighter future.",
          "Your decisions are now guided by logic, not the emotional pull of $title.",
          "You are regaining the trust of yourself and those around you.",
          "The urge to gamble on $title is a deceptive voice. Silence it with action.",
          "You are proving that you are stronger than the lure of easy money.",
          "Your life is not a game of chance. You are the architect of your fate.",
          "You are closing the door on $title and opening the door to true abundance.",
          "The illusion of the big win is fading. The reality of hard work is setting in.",
          "You are taking control of the steering wheel. No more leaving it to chance.",
          "Every time you resist $title, you are building a wall of financial defense.",
          "You are finding joy in the journey, not just the unpredictable outcome.",
          "The anxiety of the bet is being replaced by the calm of discipline.",
          "You are refusing to be a pawn in the industry of $title.",
          "Your future wealth is guaranteed by your daily actions, not by $title.",
          "You are breaking the habit loop and rewiring your brain for stability.",
          "The thrill of overcoming the urge is the best win you can have today.",
          "You are choosing reality over the intoxicating fantasy of $title.",
          "Your self-worth is no longer tied to the outcome of a wager.",
          "You are building a legacy of prudence and strength, leaving $title behind.",
          "The house edge is gone. You are the master of your own odds now.",
          "You are turning your losses into lessons and moving forward without $title.",
          "Your mind is clearing from the fog of the gamble. Stay sharp.",
          "You are walking the path of the wise, away from the foolishness of $title.",
          "Keep your focus on what you can control. Let go of $title completely.",
          "You are a winner because you chose to stop playing the game.",
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
          "Food is fuel, not therapy. You are learning to cope without $title.",
          "You are transforming your relationship with food into one of respect.",
          "The urge to binge on $title will pass. Your health goals are permanent.",
          "You are choosing vitality and longevity over the fleeting taste of $title.",
          "Your body is a temple, not a dumping ground for $title.",
          "You are breaking the emotional eating loop. Feel the emotion, skip $title.",
          "You are proving that your willpower is stronger than your appetite.",
          "Every healthy choice is an act of self-love. Reject $title.",
          "You are reclaiming your body's natural signals and ignoring the noise of $title.",
          "The guilt of giving in to $title is far worse than the discipline of saying no.",
          "You are fueling your potential, not feeding your comfort zone with $title.",
          "You are building physical and mental resilience by resisting $title.",
          "Your palate is changing. You are craving health, not $title.",
          "You are stepping off the rollercoaster of diets and binges on $title.",
          "You are nourishing your mind with discipline and your body with real food.",
          "The craving for $title is a habit, and habits can be broken.",
          "You are choosing a life of energy and clarity over the sluggishness of $title.",
          "You are finding comfort in your strength, not in the bottom of $title.",
          "Your physical transformation starts with a mental victory over $title.",
          "You are listening to your body's true needs, not the artificial craving for $title.",
          "You are taking back your power from the food industry and $title.",
          "Every time you say no to $title, you are casting a vote for the new you.",
          "You are treating your body like the masterpiece it is. No more $title.",
          "You are discovering the joy of feeling light, energetic, and free from $title.",
          "The emotional void cannot be filled with $title. Fill it with purpose.",
          "You are mastering your impulses and becoming the boss of your diet.",
          "You are choosing to be fit, strong, and healthy over consuming $title.",
          "Your cravings for $title are losing their grip on you every single day.",
          "You are building a sustainable, healthy lifestyle that has no room for $title.",
          "The satisfaction of achieving your goals tastes better than $title ever could.",
          "You are honoring your commitment to yourself. Say no to $title.",
          "You are finding new, healthy ways to reward yourself instead of using $title.",
          "You are breaking the association between stress and eating $title.",
          "Your body is healing from the inside out as you avoid $title.",
          "You are choosing long-term wellness over short-term indulgence in $title.",
          "You are proving that you can sit with discomfort without turning to $title.",
          "Your discipline around $title is radiating into every other area of your life.",
          "You are becoming mindful, intentional, and strong in the face of $title.",
          "The cycle is broken. You are moving forward, healthier and happier.",
          "Keep nourishing your success. You are conquering $title completely.",
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
          "Done is better than perfect. Start now and banish $title.",
          "You are trading excuses for execution. Goodbye $title.",
          "The hardest part is starting. Push through the resistance of $title.",
          "You are taking back your productivity from the grip of $title.",
          "Your goals will not achieve themselves. Defeat $title and get to work.",
          "You are proving that you can be relied upon, starting with yourself.",
          "The friction of starting is temporary. The reward of finishing is lasting.",
          "You are breaking the habit of waiting for motivation. You rely on discipline.",
          "Every completed task is a nail in the coffin of $title.",
          "You are stepping into the arena and doing the work, right now.",
          "The anxiety of procrastination is worse than the effort of the work. Crush $title.",
          "You are choosing the satisfaction of accomplishment over the relief of delay.",
          "Your potential is unlocked through consistent, immediate action against $title.",
          "You are rewriting your identity: from procrastinator to producer.",
          "Do not negotiate with $title. The answer is action.",
          "You are building a reputation for getting things done. Keep moving.",
          "The mountain is climbed one step at a time. Take the first step now.",
          "You are escaping the trap of overthinking by simply doing.",
          "Your energy flows where your action goes. Direct it away from $title.",
          "You are mastering the art of starting. $title has lost its power.",
          "The resistance you feel is a sign you are moving in the right direction. Push through $title.",
          "You are choosing progress over perfection and action over $title.",
          "Your future is created by what you do today, not tomorrow. Defeat $title.",
          "You are reclaiming your schedule and dictating your own pace.",
          "The relief of having it done is far sweeter than the delay of $title.",
          "You are building momentum. An object in motion stays in motion. Keep moving.",
          "Do the hardest task first. Eat the frog and destroy $title.",
          "You are turning your intentions into reality through immediate action.",
          "The cost of delay is too high. You are investing in action today.",
          "You are proving that your word to yourself means something. Say no to $title.",
          "Discipline equals freedom. You are earning your freedom by beating $title.",
          "You are silencing the inner voice that says \"later\". The time is now.",
          "Every moment of focus is a victory over the distraction of $title.",
          "You are becoming a relentless executor of your goals.",
          "The gap between where you are and where you want to be is closed by action.",
          "You are choosing the temporary discomfort of effort over the permanent regret of $title.",
          "You are breaking the cycle of panic-induced work. You work with intention.",
          "Your focus is a laser. $title cannot scatter your energy anymore.",
          "You are taking radical responsibility for your output. Goodbye $title.",
          "Keep attacking the day. You are the master of your time.",
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
          "Consistency is the playground of excellence.",
          "The harder the struggle, the more glorious the triumph.",
          "Success is walking from failure to failure with no loss of enthusiasm.",
          "Discipline is the ability to do what is right even when it's hard.",
          "You are the architect of your own recovery.",
          "One day at a time. One choice at a time.",
          "You are capable of more than you know.",
          "Stay hungry, stay foolish, stay disciplined.",
          "Integrity is choosing courage over comfort.",
          "Your mind is a powerful thing. Fill it with positive thoughts.",
          "You are writing a story of triumph. Make this chapter count.",
          "The pain of regret is far worse than the pain of discipline.",
          "You are building a foundation of rock, not sand.",
          "Every choice to stay strong compounds over time.",
          "You are turning your struggles into your greatest strengths.",
          "Keep the promise you made to yourself. You are worth it.",
          "You are stepping into a higher level of existence.",
          "The resistance you feel is just weakness leaving your body.",
          "You are cultivating a mind that cannot be broken.",
          "Focus on the step in front of you, not the whole staircase.",
          "You are forging your character in the fire of discipline.",
          "Don't trade what you want most for what you want right now.",
          "You are proving to yourself that you are unbreakable.",
          "The view from the top is worth the climb. Keep ascending.",
          "You are breaking old chains and forging a new destiny.",
          "Your potential is limited only by your level of discipline.",
          "You are a force of nature when you focus your energy.",
          "Embrace the discomfort; it is the feeling of growth.",
          "You are creating a masterpiece out of your life. Keep working.",
          "The power to change is in your hands right now.",
          "You are not defined by your past, but by the choices you make today.",
          "Stay the course. The storm will pass, and you will remain.",
          "You are a warrior of light, fighting the darkness of your habits.",
          "Every day of discipline is a day of true freedom.",
          "You are building a legacy of strength and resilience.",
          "The mind is a muscle. You are making it stronger every day.",
          "You are choosing a life of purpose over a life of pleasure.",
          "Your resolve is absolute. Nothing can sway you from your path.",
          "You are discovering the immense power that lies within you.",
          "Keep moving forward. You are an unstoppable force.",
        ];
        break;
    }

    return list;
  }

  static List<String> getUrgeSentences(String title) {
    title = cleanTitle(title);
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
          "This feeling of wanting $title is temporary, your progress is permanent.",
          "Acknowledge the urge, let it sit, then watch it fade. $title has no power.",
          "Don't negotiate with the craving. $title is a dead end.",
          "Your mind is trying to trick you back into the comfort of $title. Stay awake.",
          "Focus your energy elsewhere. The urge for $title is just misplaced drive.",
          "You are stronger than a fleeting thought about $title.",
          "Remember the emptiness that follows $title. Choose fulfillment instead.",
          "The pull is strong, but your will is stronger. Defeat $title now.",
          "Breathe deeply. Oxygen is better than the artificial rush of $title.",
          "You don't have to act on every impulse. Let $title pass by.",
          "Stand up, move around, break the pattern. $title cannot follow you.",
          "The urge is a storm. Be the deep ocean beneath it. $title cannot disturb you.",
          "You are rewiring your brain right now by saying no to $title.",
          "Don't give away your vital energy for five seconds of $title.",
          "Visualize your goal. $title is an obstacle. Walk around it.",
          "The craving is just a sensation. You are the observer. Ignore $title.",
          "Distract yourself with purpose. $title thrives on boredom.",
          "You have survived every urge before this. You will survive $title again.",
          "Don't let the primal brain win. Your higher self says no to $title.",
          "The discomfort you feel resisting $title is the feeling of growth.",
          "Acknowledge the trigger, then intentionally choose to ignore $title.",
          "You are building an iron will. This urge for $title is just practice.",
          "Think of the guilt you'll feel if you give in to $title. Stay strong.",
          "The desire for $title is an illusion. Your strength is reality.",
          "Splash cold water on your face. Shock the system away from $title.",
          "You are the master of your body. $title is an unwelcome guest.",
          "The urge to seek $title is a lie telling you that you need it. You don't.",
          "Starve the urge. Feed your focus. Leave $title behind.",
          "Every second you resist $title, the urge gets slightly weaker.",
          "You are a fortress. The arrows of $title cannot penetrate your walls.",
          "Redirect your passion. $title is a waste of your incredible potential.",
          "The craving is loud, but your discipline is a silent, unshakeable force against $title.",
          "Don't let a moment of weakness with $title erase days of strength.",
          "You are choosing freedom over the prison of $title.",
          "The urge is an echo of the past. Your future does not include $title.",
          "Clench your fists. Feel your real strength. Deny $title.",
          "You are taking back control from the autopilot of $title.",
          "The immediate gratification of $title is a poison pill. Don't swallow it.",
          "Your integrity is on the line. Defend it against $title.",
          "You are making the hard choice now to have an easy life later, free from $title.",
          "The voice telling you to indulge in $title is not your friend. Ignore it.",
          "You are cultivating a pure mind. The dirt of $title has no place here.",
          "Stay vigilant. The urge for $title is sneaky, but you are ready.",
          "You are conquering the animal within. Say no to $title.",
          "Breathe through the fire. You are emerging stronger without $title.",
        ];
        break;
      case AddictionCategory.substance:
        list = [
          "The physical craving for $title is temporary. Your health is permanent.",
          "Don't let the chemical hook of $title lie to you right now.",
          "Inhale clean air. Exhale the desire for $title.",
          "You've survived every urge for $title so far. You'll survive this one.",
          "A moment of weakness for $title is not worth starting over.",
          "The withdrawal pangs are just $title leaving your system. Let it go.",
          "Your body is asking for $title, but your mind is saying no. Listen to your mind.",
          "The urge to use $title will peak and then it will crash. Ride it out.",
          "Don't trade your sobriety for a fleeting high from $title.",
          "You are stronger than a chemical. Defeat the urge for $title.",
          "The craving for $title is an echo of an old habit. It is not a command.",
          "Drink a glass of water. Flush the thought of $title out of your mind.",
          "Remember why you quit $title. Hold onto that reason tightly right now.",
          "The voice telling you one more time with $title won't hurt is a liar.",
          "You are rebuilding your life. Don't let $title tear it down again.",
          "The physical discomfort of resisting $title is a sign of profound healing.",
          "You are taking back your biological independence from $title.",
          "Don't romanticize the past with $title. Remember the pain it caused.",
          "The urge is a test of your resolve. Show $title what you are made of.",
          "You are cultivating natural peace. You don't need the artificial calm of $title.",
          "Distract your hands and your mind. The urge for $title will fade.",
          "You are breaking the chains right now by not giving in to $title.",
          "The intense desire for $title will pass if you just give it time.",
          "You are choosing a clear head over the fog of $title.",
          "Don't negotiate with your addiction to $title. The answer is an absolute no.",
          "You are a survivor. The craving for $title is just a bump in the road.",
          "Focus on your breathing. You are alive, and you don't need $title.",
          "The urge for $title is a phantom limb. The real you is whole without it.",
          "You are building a fortress of sobriety. Keep the gates closed to $title.",
          "Every urge you beat makes the next one for $title weaker.",
          "You are choosing your future over a toxic relationship with $title.",
          "The chemical lie of $title is loud right now, but the truth of your strength is absolute.",
          "You are proving that your spirit cannot be broken by $title.",
          "Get up, change your environment. Leave the urge for $title behind.",
          "You are reclaiming your dignity and your life from $title.",
          "The urge is a wave crashing against a rock. You are the rock. $title is just water.",
          "Don't let a temporary feeling derail your permanent progress away from $title.",
          "You are finding comfort in your own resilience, not in $title.",
          "The pull of $title is strong, but your commitment to yourself is stronger.",
          "You are doing the hard work of recovery. Resisting $title is the work.",
          "You are healing your brain's reward system. Say no to the shortcut of $title.",
          "The craving is just noise. Focus on the signal of your goals, ignoring $title.",
          "You are choosing life over the slow death of $title.",
          "Every minute you hold out against $title is a monumental victory.",
          "You are rewriting your story. The villain $title does not win this chapter.",
          "The discomfort is the price of freedom from $title. Pay it gladly.",
          "You are building unshakeable confidence every time you defeat the urge for $title.",
          "Your health is your true wealth. Don't squander it on $title.",
          "The urge is a shadow. Turn on the light of your discipline and banish $title.",
          "Stay the course. You are an inspiration to yourself for beating $title.",
        ];
        break;
      case AddictionCategory.socialMedia:
        list = [
          "The algorithm of $title is trying to pull you in. Don't let it.",
          "The urge to scroll $title is just a habit loop. Break it.",
          "Put the phone down. $title has nothing real to offer you right now.",
          "Your attention is valuable. Don't give it away to $title.",
          "Disconnect from $title and reconnect with yourself.",
          "The FOMO you feel about $title is an illusion. You are missing nothing.",
          "The urge to check notifications on $title is just a phantom buzz. Ignore it.",
          "You are breaking the cycle of constant digital checking. Leave $title alone.",
          "The infinite scroll of $title is a trap. Keep your eyes on the real world.",
          "Your peace of mind is fragile. Protect it from the noise of $title.",
          "The urge to compare your life to others on $title will pass. Focus on you.",
          "Breathe. You don't need the external validation of $title right now.",
          "The digital world can wait. Your physical reality needs you. Ignore $title.",
          "You are detoxing from the constant stream of information on $title.",
          "The urge to open $title is a reflex. Consciously choose to stop it.",
          "You are reclaiming your downtime. Rest without the stimulation of $title.",
          "The content on $title will always be there. Your time will not.",
          "You are choosing deep focus over the fragmented attention of $title.",
          "The urge to post on $title is an ego trap. Live your life privately right now.",
          "You are finding contentment in silence, away from the chatter of $title.",
          "Leave the phone in another room. The urge for $title cannot follow you there.",
          "You are unhooking your self-worth from the metrics of $title.",
          "The digital dopamine hit of $title is cheap. Seek lasting fulfillment instead.",
          "You are building the ability to be alone with your thoughts, without $title.",
          "The urge is a sign that you are bored. Do something productive instead of $title.",
          "You are protecting your energy from the outrage and negativity on $title.",
          "The curated lives on $title are fake. Your messy, beautiful reality is real.",
          "You are taking back control of your mornings and evenings from $title.",
          "The urge to consume content on $title is blocking your ability to create.",
          "You are choosing to be present with the people around you, not the screen of $title.",
          "The digital noise is deafening. Find your quiet center away from $title.",
          "You are breaking the addiction to the glowing rectangle. Defeat $title.",
          "The urge is just a conditioned response. Break the conditioning. Ignore $title.",
          "You are choosing real experiences over digital representations on $title.",
          "The validation you seek on $title can only truly come from within yourself.",
          "You are reclaiming your capacity for sustained thought, free from $title's interruptions.",
          "The urge to check $title is a symptom of anxiety. Breathe through it instead.",
          "You are building a life that doesn't require constant broadcasting on $title.",
          "The physical world is rich with texture and detail. Notice it, instead of $title.",
          "You are refusing to be a product for the advertisers on $title.",
          "The urge to scroll $title is a numbing behavior. Feel your feelings instead.",
          "You are choosing slow, deliberate living over the frantic pace of $title.",
          "The digital connection of $title is shallow. Seek deep, real-world bonds.",
          "You are taking back your power from the designers who built $title to hook you.",
          "The urge to refresh $title is an endless cycle. Step off the wheel.",
          "You are finding joy in the unplugged moments. Let $title fade away.",
          "The anxiety of being offline is temporary. The peace of mind is lasting. Say no to $title.",
          "You are building a boundary between yourself and the endless demands of $title.",
          "The urge is a whisper. Your resolve is a shout. Defeat $title.",
          "Keep your head up and your phone down. You are mastering $title.",
        ];
        break;
      case AddictionCategory.gaming:
        list = [
          "The urge to escape into $title will fade. Stay in reality.",
          "Don't trade your real-world progress for virtual stats in $title.",
          "The game of $title is designed to trap you. Step away.",
          "Your real life needs grinding more than $title does.",
          "Turn it off. $title can wait. Your future cannot.",
          "The urge to play $title is a desire to avoid discomfort. Face it head on.",
          "You are breaking the habit of using $title as a coping mechanism.",
          "The virtual world of $title offers fake achievements. Seek real ones.",
          "The dopamine rush of winning in $title is an illusion. Build real competence.",
          "You are reclaiming your time from the endless grind of $title.",
          "The urge to level up in $title is distracting you from leveling up your life.",
          "The game of $title will eventually end. Your life continues. Focus on life.",
          "You are choosing to face your responsibilities instead of hiding in $title.",
          "The competitive drive you feel for $title belongs in your career and goals.",
          "You are unhooking yourself from the artificial reward system of $title.",
          "The urge is a sign of stress. Relax in the real world, not in $title.",
          "You are taking back control of your sleep schedule from the grip of $title.",
          "The virtual friends in $title are no substitute for real-world connection.",
          "You are choosing to be a creator in reality, not just a player in $title.",
          "The urge to boot up $title is strong, but your discipline is stronger.",
          "You are escaping the simulation of $title and engaging with the physical world.",
          "The epic quests are out here in reality, not inside the code of $title.",
          "You are building real-world skills instead of mastering the mechanics of $title.",
          "The urge to escape into $title is a lie telling you reality is too hard. It's not.",
          "You are breaking the cycle of isolation caused by excessive hours in $title.",
          "The frustration of losing in $title is a waste of energy. Apply that energy elsewhere.",
          "You are choosing to invest your mental bandwidth into learning, not $title.",
          "The urge to play just one more round of $title is a trap. Walk away now.",
          "You are finding adventure in your own life, rather than on the screen of $title.",
          "The digital achievements of $title will be forgotten. Your real legacy will not.",
          "You are taking control of your posture and your health by leaving $title.",
          "The urge is just a habit loop looking for a quick fix. Deny it. Defeat $title.",
          "You are proving that you can delay gratification and say no to $title.",
          "The virtual economy of $title is meaningless. Focus on your real finances.",
          "You are choosing the complex beauty of the real world over the scripted world of $title.",
          "The urge to play $title is a symptom of procrastination. Do the work instead.",
          "You are taking back your identity from the avatar you created in $title.",
          "The real world has no respawns. Make this life count. Ignore $title.",
          "You are choosing to be present with your family and friends, not with $title.",
          "The urge to check the leaderboards in $title is an ego trip. Let it go.",
          "You are building a life that is so engaging you don't need to escape to $title.",
          "The digital dopamine of $title is frying your receptors. Let them heal.",
          "You are reclaiming your creativity from the rigid rules of $title.",
          "The urge is a temporary wave of boredom. Ride it out without using $title.",
          "You are choosing the hard, fulfilling path of reality over the easy path of $title.",
          "The game developers built $title to keep you hooked. Break their spell.",
          "You are finding real joy in physical hobbies, away from the screen of $title.",
          "The urge to immerse yourself in $title is fading. Your focus is sharp.",
          "You are building a kingdom in your own life. Leave the digital kingdom of $title.",
          "Keep the console off. You are the main character of your reality, not $title.",
        ];
        break;
      case AddictionCategory.gambling:
        list = [
          "The urge to chase the loss in $title is a trap. Walk away.",
          "The thrill of $title is an illusion designed to break you.",
          "Keep your money and your dignity. Say no to $title.",
          "The house always wins in $title. Be the house of your own life.",
          "Don't risk your peace of mind for the chaos of $title.",
          "The urge to place a bet on $title is a lie telling you that you can win big.",
          "You are breaking the cycle of hope and despair that $title brings.",
          "The adrenaline rush of $title is a poison to your financial stability.",
          "You are reclaiming control over your impulses and your wallet from $title.",
          "The urge to gamble on $title is a symptom of deeper unrest. Address the root.",
          "You are choosing the slow, steady path of wealth over the reckless gamble of $title.",
          "The near-misses in $title are designed to keep you hooked. See through the manipulation.",
          "You are protecting your family's future by refusing to engage with $title.",
          "The urge is a siren song leading you to the rocks. Steer clear of $title.",
          "You are taking back your power from the odds, the bookies, and $title.",
          "The belief that the next bet on $title will fix everything is a dangerous delusion.",
          "You are choosing financial peace over the agonizing anxiety of $title.",
          "The urge to risk it all on $title is fading. Your rational mind is taking over.",
          "You are building a life of certainty, free from the volatile swings of $title.",
          "The illusion of control in $title is the ultimate trap. Surrender the need to bet.",
          "You are recognizing the urge for $title as a toxic craving, and denying it.",
          "The fleeting high of a win in $title is never worth the devastating low of a loss.",
          "You are choosing self-respect over the degradation of chasing money in $title.",
          "The urge to gamble on $title is an attempt to escape reality. Face your reality.",
          "You are breaking the association between money and adrenaline created by $title.",
          "The house edge in $title is a mathematical certainty. You cannot beat the math.",
          "You are investing your time and money into guaranteed growth, away from $title.",
          "The urge is a test of your financial discipline. Pass the test. Ignore $title.",
          "You are reclaiming your mental clarity from the obsessive thoughts of $title.",
          "The fantasy of the jackpot in $title is preventing you from building real wealth.",
          "You are choosing logic and reason over the emotional rollercoaster of $title.",
          "The urge to bet on $title is just an old neural pathway. Let it wither and die.",
          "You are protecting your integrity. You do not need the deceit that comes with $title.",
          "The flashing lights and sounds of $title are a distraction. Focus on your goals.",
          "You are acknowledging the urge for $title without acting on it. That is true power.",
          "The belief that you are due for a win in $title is a fallacy. Walk away.",
          "You are choosing a life where your success is determined by effort, not the chance of $title.",
          "The urge to hide your losses in $title is a heavy burden. Drop the burden and stop betting.",
          "You are breaking the habit of turning to $title when you feel stressed or bored.",
          "The thrill of the gamble on $title is a counterfeit emotion. Seek genuine joy.",
          "You are taking back the steering wheel of your life from the unpredictable chaos of $title.",
          "The urge is loud, but your commitment to financial freedom from $title is absolute.",
          "You are proving that you value hard work over the deceptive promise of easy money in $title.",
          "The cycle of winning, losing, and chasing in $title is broken. You are free.",
          "You are finding excitement in your own potential, not in the spin of a wheel in $title.",
          "The urge to risk your hard-earned money on $title is a betrayal of your own effort.",
          "You are choosing to be a builder of wealth, not a gambler of it on $title.",
          "The anxiety of the unknown outcome in $title is replaced by the calm of deliberate action.",
          "You are a master of your finances. $title has no place in your budget or your mind.",
          "Stay vigilant. The urge for $title is a liar. Your discipline is the truth.",
        ];
        break;
      case AddictionCategory.eating:
        list = [
          "The craving for $title is just emotional hunger. Drink water.",
          "You are not hungry, you are just bored. Walk away from $title.",
          "The sugar rush of $title lasts minutes. The regret lasts hours.",
          "You have the power to say no to $title right now.",
          "Nourish your discipline, starve the urge for $title.",
          "The urge to binge on $title is a desire to numb your feelings. Feel them instead.",
          "You are breaking the cycle of eating $title for comfort. Find comfort elsewhere.",
          "The physical craving for $title is just a spike in blood sugar. Let it pass.",
          "You are taking back control of your body from the grip of $title.",
          "The urge is strong, but your commitment to your health is stronger. Ignore $title.",
          "You are choosing long-term vitality over the fleeting taste of $title.",
          "The artificial flavors of $title are tricking your brain. Don't fall for it.",
          "You are building a relationship with food based on respect, not an addiction to $title.",
          "The urge to mindlessly eat $title is a habit loop. Break the loop right now.",
          "You are proving that you are not a slave to your cravings for $title.",
          "The guilt that follows eating $title is a heavy weight. Choose to remain light.",
          "You are honoring your hunger, but denying the toxic craving for $title.",
          "The urge is a symptom of stress. Take a deep breath instead of taking a bite of $title.",
          "You are choosing to fuel your body with real nutrients, not the empty calories of $title.",
          "The desire for $title is a temporary wave. Stand firm and let it crash over you.",
          "You are reclaiming your palate from the hyper-palatable trap of $title.",
          "The urge to overeat $title is fading as you practice mindful discipline.",
          "You are choosing the feeling of being lean and energetic over the sluggishness of $title.",
          "The comfort $title provides is an illusion. True comfort comes from self-mastery.",
          "You are taking a pause before acting on the urge for $title. The pause is your power.",
          "The craving for $title is an old program running in your brain. Write a new program.",
          "You are choosing to respect your digestive system by keeping $title out of it.",
          "The urge to reach for $title is an automatic reflex. Catch it and stop it.",
          "You are finding sweetness in your achievements, not in the sugar of $title.",
          "The temporary satisfaction of $title is a poor trade for your self-esteem.",
          "You are building a fortress of health. $title is not allowed inside.",
          "The urge is loud, but your logic is clear: $title is poison to your goals.",
          "You are choosing to sit with the discomfort of denying $title. That is how you grow.",
          "The cycle of dieting and giving in to $title ends today. You are making a permanent change.",
          "You are taking back your power from the food industry that designed $title to hook you.",
          "The urge to treat yourself with $title is a misunderstanding. Treat yourself with health.",
          "You are finding new ways to cope with a bad day that don't involve $title.",
          "The craving for $title is losing its volume as your willpower turns up the dial.",
          "You are choosing a clear mind and a strong body over the brain fog of $title.",
          "The urge is a test of your daily commitment. Pass the test and say no to $title.",
          "You are building a body that you are proud of. $title will only delay that.",
          "The satisfaction of resisting $title is a deeper, more lasting joy than eating it.",
          "You are breaking the emotional attachment to $title. It is just food, and you don't need it.",
          "The urge to celebrate with $title is an old habit. Celebrate with life instead.",
          "You are choosing to be intentional with every bite. Mindless consumption of $title is over.",
          "The physical sensation of the craving for $title is just a feeling. It cannot force you to act.",
          "You are a master of your impulses. $title has no authority over you.",
          "The cycle of craving, giving in to $title, and feeling guilty is broken. You are free.",
          "You are nourishing your potential by starving the desire for $title.",
          "Stay strong. The healthiest version of you is saying no to $title right now.",
        ];
        break;
      case AddictionCategory.procrastination:
        list = [
          "The urge to delay and choose $title is fear in disguise.",
          "Do it now. $title is the enemy of your success.",
          "Action destroys the urge for $title. Take one small step.",
          "Don't let $title steal another hour from your life.",
          "The discomfort of starting is nothing compared to the pain of $title.",
          "The urge to put it off until tomorrow is a lie. $title thrives in tomorrow.",
          "You are breaking the cycle of avoidance and $title. Lean into the work.",
          "The resistance you feel is a sign the work is important. Push through $title.",
          "You are taking back your momentum from the paralysis of $title.",
          "The urge to seek distraction in $title is just your brain avoiding effort. Don't let it.",
          "You are choosing the hard path of execution over the easy path of $title.",
          "The relief of procrastination is temporary. The anxiety of $title is lasting.",
          "You are building a habit of immediate action. Say no to $title.",
          "The urge to wait for inspiration is a trap. Action creates inspiration. Defeat $title.",
          "You are choosing to be a professional, not an amateur who gives in to $title.",
          "The friction of starting is the hardest part. Overcome it and $title dies.",
          "You are unhooking yourself from the instant gratification of $title. Focus on the long term.",
          "The urge to just check one more thing before starting is the voice of $title. Silence it.",
          "You are reclaiming your schedule from the chaos of $title.",
          "The anxiety of the unfinished task is worse than doing the task. Crush $title now.",
          "You are choosing to be reliable to yourself. Don't let $title make you a liar.",
          "The urge to quit when it gets hard is $title trying to win. Keep going.",
          "You are building the muscle of discipline every time you act instead of choosing $title.",
          "The illusion that you will have more energy later is a trick of $title. Use your energy now.",
          "You are taking radical responsibility for your output. $title has no place here.",
          "The urge to over-prepare is just another form of $title. Start messy.",
          "You are choosing progress, no matter how small, over the stagnation of $title.",
          "The comfort zone of $title is a beautiful place, but nothing ever grows there.",
          "You are breaking the habit of negotiating with yourself. The decision is made: defeat $title.",
          "The urge to seek perfection is fueling your $title. Done is better than perfect.",
          "You are finding flow in your work, leaving the fragmented attention of $title behind.",
          "The temporary discomfort of discipline is the toll you pay to escape $title.",
          "You are taking back your power from the overwhelming feeling that causes $title.",
          "The urge to delay is a test of your commitment to your goals. Pass the test against $title.",
          "You are building a reputation as someone who gets things done, without $title.",
          "The relief of crossing it off the list is a thousand times better than the delay of $title.",
          "You are choosing to face the challenge directly, rather than hiding behind $title.",
          "The urge to self-sabotage through $title is an old pattern. Break the pattern today.",
          "You are taking back the steering wheel. $title is no longer driving your day.",
          "The momentum of starting will carry you through. Take the first step and kill $title.",
          "You are proving that you are in control of your actions, not the urge for $title.",
          "The excuse that you work better under pressure is a lie from $title. Work steadily.",
          "You are choosing the satisfaction of accomplishment over the empty relief of $title.",
          "The urge to mindlessly consume instead of producing is $title at work. Switch to creation.",
          "You are building a life of intention. $title is accidental. Be intentional.",
          "The inner voice telling you to take a break before you've started is $title. Ignore it.",
          "You are a force of execution. $title is an obstacle you are obliterating right now.",
          "The cycle of delay, panic, and rushed work is over. You are defeating $title.",
          "You are reclaiming your potential from the graveyard of good intentions caused by $title.",
          "Start immediately. The urge for $title evaporates in the face of relentless action.",
        ];
        break;
      case AddictionCategory.general:
        list = [
          "The urge is just a wave. Ride it.",
          "This feeling is temporary. Your integrity is permanent.",
          "Don't trade your future self for a few seconds of pleasure.",
          "You are stronger than the pull of the habit.",
          "Think about why you started. Don't let that person down.",
          "Your brain is lying to you right now. Don't believe it.",
          "A moment of weakness is not worth a lifetime of regret.",
          "Urges are like clouds; they pass if you just wait.",
          "Focus on your breath. Inhale strength, exhale the urge.",
          "You are the master of your actions, not your impulses.",
          "Imagine the pride you'll feel tomorrow if you stay strong now.",
          "One minute of discipline saves hours of guilt.",
          "Your future is being built by the choices you make today.",
          "Feel the urge, then choose to let it go.",
          "You are rewiring your brain every second you resist.",
          "Acknowledge the craving, then calmly walk in the opposite direction.",
          "The discomfort of resisting is the feeling of becoming stronger.",
          "You have survived 100% of the urges you've faced. You will survive this one.",
          "Don't negotiate with your weaknesses. Stand firm.",
          "The easy choice is the wrong choice right now. Choose the hard path.",
          "Your higher self is watching. Make a choice you can be proud of.",
          "The intense feeling will peak and then subside. Just hold on.",
          "You are building an iron mind. This is just training.",
          "Don't let a temporary emotion dictate a permanent decision.",
          "You are taking back control, one resisted urge at a time.",
          "The craving is an echo of the past. Your future is different.",
          "Distract yourself with purpose. Action kills the urge.",
          "You are choosing your long-term goals over short-term gratification.",
          "The voice telling you to give in is not your true voice. Ignore it.",
          "You are proving your resilience to yourself right now.",
          "Every time you say no to the urge, you say yes to freedom.",
          "The struggle is temporary, the triumph is lasting.",
          "You are a fortress. The urge cannot break your walls.",
          "Breathe deeply. The panic of the craving will settle down.",
          "You are breaking old chains. It is painful, but necessary.",
          "The urge is a test. Prove how much you want your goal.",
          "You are finding comfort in your discipline, not your habit.",
          "The desire will pass, but the pride of staying strong remains.",
          "You are choosing life over the slow decay of bad habits.",
          "The immediate reward is a trap. Keep your eyes on the horizon.",
          "You are cultivating a spirit of indomitable will.",
          "The craving is just a thought. You are not your thoughts.",
          "You are reclaiming your power. Do not give it away again.",
          "The physical sensation is uncomfortable, but harmless. Let it be.",
          "You are writing a story of triumph. Don't let this urge ruin the chapter.",
          "Stay vigilant. The urge is deceptive, but your resolve is clear.",
          "You are choosing self-respect over self-destruction.",
          "The habit is starving. Let it starve. Do not feed it.",
          "You are emerging from the fog. Stay in the light.",
          "Keep your guard up. You are winning this fight.",
        ];
        break;
    }

    return list;
  }

  static List<String> getProgressMessages(String title) {
    title = cleanTitle(title);
    final category = _categorizeTracker(title);

    if (category == AddictionCategory.general ||
        title.toLowerCase() == "default tracker") {
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
    title = cleanTitle(title);
    final category = _categorizeTracker(title);

    if (category == AddictionCategory.general ||
        title.toLowerCase() == "default tracker") {
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
    title = cleanTitle(title);
    final category = _categorizeTracker(title);

    if (category == AddictionCategory.general ||
        title.toLowerCase() == "default tracker") {
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
