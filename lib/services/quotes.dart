import 'dart:math';

class Quotes{

  List<String> quotesList = [
    '"The only person you are destined to become is the person you decide to be." -Ralph Waldo Emerson',
    ''' "A year from now you may wish you had started today." - Karen Lamb ''',
    ''' "If you don't find the time,\nIf you don't do the work,\nYou won't find the results" -Arnold S. ''',
    ''' "Most people fail, not because of lack of desire, but, because of lack of commitment." - Vince Lombardi" ''',
    ''' "Some people want it to happen, some wish it would happen, others make it happen." - Michael Jordan ''',
    ''' "Discipline is the bridge between goals and accomplishment." - Jim Rohn ''',
    ''' "We cannot start over. But we can begin now and make a new ending.” -Zig Ziglar ''',
    ''' "Every champion was once a contender that refused to give up." -Sylvester Stallone ''',
    ''' "The past doesn’t matter. Take today." -Becky Sauerbrunn''',
    ''' "There is always going to be a reason why you can’t do something; your job is to constantly look for the reasons why you can achieve your dreams." -Shannon Miller''',
    ''' "Do you know what my favorite part of the game is? The opportunity to play." -Mike Singletary ''',
    ''' "It’s not the will to win that matters—everyone has that. It’s the will to prepare to win that matters." -Paul Bryant''',
    ''' "Success is not final, failure is not fatal: it is the courage to continue that counts." - Winston Churchill''',
  ];


  List<String> randomQuote(){
    int randomInt = Random().nextInt(quotesList.length-1);
    Map<int, List<String> > data = {};
    int index = 0;
    for(var item in quotesList){
      try{
        var quote = item.split('-');
        data[index] = quote;
      }catch(error){
        print(error);
      }
      index++;
    }

    return data.values.elementAt(randomInt);
  }

}