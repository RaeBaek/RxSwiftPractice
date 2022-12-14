import RxSwift

let disposeBag = DisposeBag()

print("-------toArray-------")
Observable.of("A", "B", "C")
    .toArray()
    .subscribe(onSuccess: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-------map-------")
Observable.of(Date())
    .map { date -> String in
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: date)
    }

    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-------flatMap-------")
protocol 선수 {
    var 점수: BehaviorSubject<Int> { get }
}

struct 양궁선수: 선수 {
    var 점수: BehaviorSubject<Int>
}

let 🇰🇷국가대표 = 양궁선수(점수: BehaviorSubject<Int>(value: 10))
let 🇺🇸국가대표 = 양궁선수(점수: BehaviorSubject<Int>(value: 8))

let 올림픽경기 = PublishSubject<선수>()

올림픽경기
    .flatMap { 선수 in
        선수.점수
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

올림픽경기.onNext(🇰🇷국가대표)
🇰🇷국가대표.점수.onNext(10)

올림픽경기.onNext(🇺🇸국가대표)
🇰🇷국가대표.점수.onNext(10)
🇺🇸국가대표.점수.onNext(9)

print("-------flatMapLatest-------")
struct 높이뛰기선수: 선수 {
    var 점수: BehaviorSubject<Int>
}

let 서울 = 높이뛰기선수(점수: BehaviorSubject<Int>(value: 220))
let 제주 = 높이뛰기선수(점수: BehaviorSubject<Int>(value: 218))

let 전국체전 = PublishSubject<선수>()

전국체전
    .flatMapLatest { 선수 in
        선수.점수
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

전국체전.onNext(서울)
서울.점수.onNext(222)

전국체전.onNext(제주)
제주.점수.onNext(219)
서울.점수.onNext(223)
제주.점수.onNext(221)

print("-------materialize and dematerialize-------")
enum 반칙: Error {
    case 부정출발
}

struct 달리기선수: 선수 {
    var 점수: BehaviorSubject<Int>
}

let 김토끼 = 달리기선수(점수: BehaviorSubject<Int>(value: 0))
let 박치타 = 달리기선수(점수: BehaviorSubject<Int>(value: 1))

let 달리기100M = BehaviorSubject<선수>(value: 김토끼)

달리기100M
    .flatMapLatest { 선수 in
        선수.점수
            .materialize()
    }
    .filter {
        guard let error = $0.error else {
            return true
        }
        print(error)
        return false
    }
    .dematerialize()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

김토끼.점수.onNext(1)
김토끼.점수.onError(반칙.부정출발)
김토끼.점수.onNext(2)

달리기100M.onNext(박치타)

print("-------전화번호 11자리-------")
let input = PublishSubject<Int?>()

let list: [Int] = [1]

input
    .flatMap {
        $0 == nil
            ? Observable.empty()
            : Observable.just($0)
    }
    .map { $0! }                // 옵셔널 처리
    .skip(while: { $0 != 0 })   // 전화번호는 0부터 시작하니까 시작이 0인지 아닌지 구분
    .take(11)                   // 0부터 시작하면 11자리를 받는다 ex)010-1234-5678
    .toArray()                  // toArray로 Single로 만들어준다
    .asObservable()             // asObservable로 다시 변환한다
    .map {
        $0.map { "\($0)" }      // Array 안의 Int 값을 String 값으로 변환
    }
    .map { numbers in
        var numberList = numbers
        numberList.insert("-", at: 3)   //010-  3번째 인덱스
        numberList.insert("-", at: 8)   //010-1234- 8번째 인덱스
        let number = numberList.reduce(" ", +)
        return number
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

input.onNext(10)    //전화번호는 0부터 시작이므로 10이 들어가면 걸러지게 됨
input.onNext(0)
input.onNext(nil)
input.onNext(1)
input.onNext(0)
input.onNext(1)
input.onNext(2)
input.onNext(nil)
input.onNext(3)
input.onNext(4)
input.onNext(nil)
input.onNext(5)
input.onNext(6)
input.onNext(7)
input.onNext(8)
input.onNext(3)
input.onNext(5)
