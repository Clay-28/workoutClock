
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
}