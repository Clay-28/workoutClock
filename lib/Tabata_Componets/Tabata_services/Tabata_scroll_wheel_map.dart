
class TabataServices{


  Map<int,List<dynamic>> roundScrollMap({required int totalRounds}){
    Map<int,List<dynamic>> data = {};
    int index = 0;
    while(index < totalRounds){
      data[index] = ['${index + 1} Rounds', index + 1];
      index ++;
    }
    return data;
  }

  Map<int,List<dynamic>> workRestRoundScrollMap({required int totalRounds}){
    Map<int,List<dynamic>> data = {};
    int index = 0;
    while(index < totalRounds){
      if(index == 0){
        data[index] = ['Continuous', 0];
      }if(index > 0 && index < 56){
        data[index] = ['${index + 4} seconds', index + 4];
      }if(index >= 56 && index < 92) {
        int seconds = ((((index - 56) * 15) + 60) % 60);
        int minutes = ((((index - 56) * 15) + 60) ~/ 60);
        data[index] = ['$minutes:$seconds minutes', seconds+(minutes*60)];
      }if(index >= 92 && index < 142){
        data[index] = ['${(index - 92) + 10} minutes', ((index - 92) + 10) * 60];
      }if(index >= 142){
        data[index] = ['${(((index - 142) * 10) + 60)} minutes', (((index - 142) * 10) + 60) * 60];
      }
      index ++;
    }
    return data;
  }

}


void main(){

  //TabataServices().roundScrollMap(totalRounds: 101).forEach((key, value) {print('$key:$value');});
  TabataServices().workRestRoundScrollMap(totalRounds: 150).forEach((key, value) {
    if(key > 50 && key < 100){
      print('$key:$value');
    }
  });

}