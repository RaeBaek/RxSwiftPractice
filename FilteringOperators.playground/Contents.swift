import RxSwift

let disposeBag = DisposeBag()

print("-------ignoreElements-------")
let μ·¨μΉ¨λͺ¨λπ΄ = PublishSubject<String>()

μ·¨μΉ¨λͺ¨λπ΄
    .ignoreElements()
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)

μ·¨μΉ¨λͺ¨λπ΄.onNext("π")
μ·¨μΉ¨λͺ¨λπ΄.onNext("π")
μ·¨μΉ¨λͺ¨λπ΄.onNext("π")

μ·¨μΉ¨λͺ¨λπ΄.onCompleted()

print("-------elementAt-------")
let λλ²μΈλ©΄κΉ¨λμ¬λ = PublishSubject<String>()

λλ²μΈλ©΄κΉ¨λμ¬λ
    .element(at: 2)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

λλ²μΈλ©΄κΉ¨λμ¬λ.onNext("π")   //index0
λλ²μΈλ©΄κΉ¨λμ¬λ.onNext("π")   //index1
λλ²μΈλ©΄κΉ¨λμ¬λ.onNext("π")   //index2
λλ²μΈλ©΄κΉ¨λμ¬λ.onNext("π")   //index3

print("-------filter-------")
Observable.of(1, 2, 3, 4, 5, 6, 7, 8)   //[1, 2, 3, 4, 5, 6, 7, 8]
    .filter { $0 % 2 == 0 }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-------skip-------")
Observable.of("π", "π", "π", "π₯°", "π", "π§")
    .skip(5)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-------skipWhile-------")
Observable.of("π", "π", "π", "π₯°", "π", "π§", "π", "βΉοΈ")
    .skip(while: {
        $0 != "π§"
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-------skipUntil-------")
let μλ = PublishSubject<String>()
let λ¬Έμ¬λμκ° = PublishSubject<String>()

μλ  //νμ¬ Observable
    .skip(until: λ¬Έμ¬λμκ°) //λ€λ₯Έ Observable
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

μλ.onNext("π")
μλ.onNext("π")

λ¬Έμ¬λμκ°.onNext("λ‘!")

μλ.onNext("π₯°")
μλ.onNext("π")

print("-------take-------")
Observable.of("π₯", "π₯", "π₯", "π", "π")
    .take(3)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-------takeWhile-------")
Observable.of("π₯", "π₯", "π₯", "π", "π")
    .take(while: {
        $0 != "π₯"
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-------enumerated-------")
Observable.of("π₯", "π₯", "π₯", "π", "π")
    .enumerated()
    .takeWhile {
        $0.index < 3
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-------takeUntil-------")
let μκ°μ μ²­ = PublishSubject<String>()
let μ μ²­λ§κ° = PublishSubject<String>()

μκ°μ μ²­
    .take(until: μ μ²­λ§κ°)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

μκ°μ μ²­.onNext("πββοΈ")
μκ°μ μ²­.onNext("π")

μ μ²­λ§κ°.onNext("λ!")

μκ°μ μ²­.onNext("πββοΈ")

print("-------distincUntilChanged-------")
Observable.of("μ λ", "μ΅λ¬΄μ", "μ΅λ¬΄μ", "μ΅λ¬΄μ", "μ΅λ¬΄μ", "μλλ€", "μλλ€", "μλλ€", "μλλ€", "μλλ€", "μ λ", "μ΅λ¬΄μ", "μΌκΉμ?", "μΌκΉμ?")
    .distinctUntilChanged()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
