import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank {
  stable var currentValue: Float = 300;
  // currentValue := 300;

  stable var startTime = Time.now();   //nanoseconds since 1970-01-01.
  // startTime := Time.now();
  Debug.print(debug_show(startTime));

  public func topUp(amount: Float) {
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };

  public func withdraw(amount: Float){
    let tempValue: Float = currentValue - amount; 
    if(tempValue >= 0){
      currentValue -= amount;
      Debug.print(debug_show(currentValue));
    } else {
      Debug.print("Amount too large, currentValue less than zero.")
    }
  };

  public query func checkBalance() : async Float {
    return currentValue;
  };

  public func compound() {
    let currentTime = Time.now();
    let timeElapsedInNanoSecond = currentTime - startTime;
    let timeElapsedInSecond = timeElapsedInNanoSecond / 1000000000;

    // 1% interest per second
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedInSecond));

    // reset to the pervious compoundede time
    startTime := currentTime;

  }
}