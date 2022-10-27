import Foundation
import RxSwift

// Just는 단 하나만 내보낸다.
print("----Just----")
Observable<Int>.just(1)
    .subscribe(onNext: {
        print($0)
    })

// 여러개를 내보낼 수 있는 Of
print("----Of(1)----")
Observable<Int>.of(1, 2, 3, 4, 5)
    .subscribe(onNext: {
        print($0)
    })

print("----Of(2)----")
Observable.of([1, 2, 3, 4, 5])
    .subscribe(onNext: {
        print($0)
    })

// From은 반드시 Array 형태만 받을 수 있다.
print("----From----")
Observable.from([1, 2, 3, 4, 5])
    .subscribe(onNext: {
        print($0)
    })

// Observable은 단독으로 있을때는 아무것도 할 수 없기에 .subscribe로 구독을 해주어야 이벤트 방출이 가능하다.
print("------subscribe1------")
Observable.of(1, 2, 3)
    .subscribe {
        print($0)
    }

print("------subscribe2------")
Observable.of(1, 2, 3)
    .subscribe {
        if let element = $0.element {
            print(element)
        }
    }

print("------subscribe3------")
Observable.of(1, 2, 3)
    .subscribe(onNext: {
        print($0)
    })

// Empty는 빈 이벤트를 방출하고 Completed만 방출한다.
print("------empty------")
Observable<Void>.empty()
    .subscribe {
        print($0)
    }

// Never는 정말 아무런 이벤트를 방출하지 않아 debug로 확인해야한다.
print("------never------")
Observable<Void>.never()
    .debug("never")
    .subscribe(
        onNext: {
            print($0)
        },
        onCompleted: {
            print("Completed")
        }
    )

// start와 count로 순차적으로 하나씩 내뱉는다.
print("------range------")
Observable.range(start: 1, count: 9)
    .subscribe(onNext: {
        print("2 * \($0) = \(2*$0)")
    })

// Observable을 생성하고 subscribe을 했다면 반드시 dispose 해주어 메모리 누수가 일어나지 않게 해야한다.
// 이것이 Observable의 하나의 생명주기라고 볼 수 있다.
print("------dispose------")
Observable.of(1, 2, 3)
    .subscribe(onNext: {
        print($0)
    })
    .dispose()

print("------disposeBag------")
let disposeBag = DisposeBag()

Observable.of(1, 2, 3)
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)

// Observable의 각각의 이벤트를 내뱉는 시퀀스를 생성
print("------create1------")
Observable.create { observer -> Disposable in
    observer.onNext(1)
    //    observer.on(.next(1))
    observer.onCompleted()
    //    observer.on(.completed)
    observer.onNext(2)
    return Disposables.create()
}
.subscribe(onNext: {
    print($0)
})
.disposed(by: disposeBag)

print("------create2------")
enum MyError: Error {
case anError
}

Observable<Int>.create { observer -> Disposable in
    observer.onNext(1)
    observer.onError(MyError.anError)
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}
.subscribe(
    onNext: {
        print($0)
    },
    onError: {
        print($0.localizedDescription)
    },
    onCompleted: {
        print("Completed")
    },
    onDisposed: {
        print("disposed")
    }
)
.disposed(by: disposeBag)

// Observable Factory를 통해 Observable 시퀀스를 만드는 Observable 내부에 Observable이 생성되는 개념이다.
print("------deffered1------")
Observable.deferred {
    Observable.of(1, 2, 3)
}
.subscribe {
    print($0)
}
.disposed(by: disposeBag)

print("------deffered2------")
var 뒤집기: Bool = false

let factory: Observable<String> = Observable.deferred {
    뒤집기 = !뒤집기
    
    if 뒤집기 {
        return Observable.of("☝️")
    } else {
        return Observable.of("👎")
    }
}

for _ in 0...3 {
    factory.subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
}
