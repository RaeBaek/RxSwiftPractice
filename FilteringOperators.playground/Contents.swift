import RxSwift

let disposeBag = DisposeBag()

print("-------ignoreElements-------")
let 취침모드😴 = PublishSubject<String>()

취침모드😴
    .ignoreElements()
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)

취침모드😴.onNext("🔊")
취침모드😴.onNext("🔊")
취침모드😴.onNext("🔊")

취침모드😴.onCompleted()

print("-------elementAt-------")
let 두번울면깨는사람 = PublishSubject<String>()

두번울면깨는사람
    .element(at: 2)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

두번울면깨는사람.onNext("🔊")   //index0
두번울면깨는사람.onNext("🔊")   //index1
두번울면깨는사람.onNext("😜")   //index2
두번울면깨는사람.onNext("🔊")   //index3

print("-------filter-------")
Observable.of(1, 2, 3, 4, 5, 6, 7, 8)   //[1, 2, 3, 4, 5, 6, 7, 8]
    .filter { $0 % 2 == 0 }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-------skip-------")
Observable.of("😀", "😅", "😇", "🥰", "😛", "🧐")
    .skip(5)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-------skipWhile-------")
Observable.of("😀", "😅", "😇", "🥰", "😛", "🧐", "😎", "☹️")
    .skip(while: {
        $0 != "🧐"
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-------skipUntil-------")
let 손님 = PublishSubject<String>()
let 문여는시간 = PublishSubject<String>()

손님  //현재 Observable
    .skip(until: 문여는시간) //다른 Observable
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

손님.onNext("😀")
손님.onNext("😅")

문여는시간.onNext("땡!")

손님.onNext("🥰")
손님.onNext("😇")

print("-------take-------")
Observable.of("🥇", "🥈", "🥉", "😀", "😜")
    .take(3)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-------takeWhile-------")
Observable.of("🥇", "🥈", "🥉", "😀", "😜")
    .take(while: {
        $0 != "🥉"
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-------enumerated-------")
Observable.of("🥇", "🥈", "🥉", "😀", "😜")
    .enumerated()
    .takeWhile {
        $0.index < 3
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-------takeUntil-------")
let 수강신청 = PublishSubject<String>()
let 신청마감 = PublishSubject<String>()

수강신청
    .take(until: 신청마감)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

수강신청.onNext("🙋‍♀️")
수강신청.onNext("🙋")

신청마감.onNext("끝!")

수강신청.onNext("🙋‍♂️")

print("-------distincUntilChanged-------")
Observable.of("저는", "앵무새", "앵무새", "앵무새", "앵무새", "입니다", "입니다", "입니다", "입니다", "입니다", "저는", "앵무새", "일까요?", "일까요?")
    .distinctUntilChanged()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
