// actor {
//     public func greet(name : Text) : async Text {
//         return "Hello, " # name # "!";
//     };
// };
import Nat "mo:base/Nat";
import Array "mo:base/Array"

actor {
  private func quickSort(sourceArr: [var Int], i: Nat, j: Nat): () {
    if(sourceArr.size() < 2) {
      return;
    };
    if(i < j) {
      var val: Int = sourceArr[i];
      var l: Nat = i;
      var r: Nat = j;

      while(l < r) {
        //从后往前找第一个小于val的数字
        while(l < r and sourceArr[r] > val) {
          r -= 1;
        };
        //找到了数字
        if(l < r) {
          sourceArr[l] := sourceArr[r];
        };
        //从前往后找第一个大于val的数字
        while (l < r and sourceArr[l] < val) {
          l += 1;
        };
        //找到了数字
        if(l < r) {
          sourceArr[r] := sourceArr[l];
        };
      };

      sourceArr[l] := val;

      if(r > 0) {
        quickSort(sourceArr, i, l - 1);
      };
      
      quickSort(sourceArr, l + 1, j);
    };
  };

  public func qsort(sourceArr: [Int]): async [Int] {
    let dynamicSourceArr:[var Int] = Array.thaw(sourceArr);
    quickSort(dynamicSourceArr, 0, dynamicSourceArr.size() - 1);
    return Array.freeze(dynamicSourceArr);
  }
}
