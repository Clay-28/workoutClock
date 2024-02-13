
class Ticker{
  const Ticker();
  Stream<int> tick ({required int seconds}){
    return Stream.periodic(const Duration(seconds: 1),  (x) => seconds + 1 + x);
  }

  Stream<int> breaktick ({required int seconds}){
    return Stream.periodic(const Duration(seconds: 1),  (x) => seconds  - x - 1 );
  }

  Stream<int> additionaltick ({required int seconds}){
    return Stream.periodic(const Duration(seconds: 1),  (x) => seconds  - x - 1 );
  }

  Stream<int> AmrapTick ({required int seconds}){
    return Stream.periodic(const Duration(seconds: 1),  (x) => seconds  - x - 1 );
  }

  Stream<int> Emom ({required int seconds}){
    return Stream.periodic(const Duration(seconds: 1),  (x) {
      return seconds  - x - 1 ;
    });
  }

  Stream<int> EmomDuration ({required int seconds }){
    return Stream.periodic(const Duration(seconds: 1), (x) => seconds - x -1);
  }

  Stream<int> TabataWorking ({required int seconds}){
    return Stream.periodic(const Duration(seconds: 1),  (x) {
      return seconds  - x - 1 ;
    });
  }

  Stream<int> TabataResting ({required int seconds}){
    return Stream.periodic(const Duration(seconds: 1),  (x) {
      return seconds  - x - 1 ;
    });
  }

}