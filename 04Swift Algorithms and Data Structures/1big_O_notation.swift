import Foundation

open class Big_O_Notation {

    let numberList : Array<Int> = [1,2,3,4,5,6,7,8,9,10]

    func linearSearch(_ key:Int) {

        for number in numberList {
            if number == key {
                print("value at \(key) found")
                break
            }
        }
    }

    func binarySearch(_ key: Int, imin: Int, imax: Int) {

        let midIndex : Double = round(Double((imin + imax) / 2 ))
        let midNumber = numberList[Int(midIndex)]

        if midNumber > key {
            binarySearch(key, imin: imin, imax: Int(midIndex) - 1)
        }
        else if (midNumber < key ) {
            binarySearch(key, imin: Int(midIndex) + 1, imax: imax)
        }
        else {
            print("value \(key) found.")
        }

    }
    
    // https://www.weheartswift.com/binary-search-applications/
    func binarySearch(_ array: [Int], target: Int) -> Bool {

        var left = 0
        var right = array.count - 1

        while (left <= right) {
            let mid = (left + right) / 2
            let value = array[mid]

            if (value == target) {
                return true
            }

            if (value < target) {
                left = mid + 1
            }

            if (value > target) {
                right = mid - 1
            }
        }
        
        return false
    }
}
