//
//  ViewModel.swift
//  RxSwiftMVVMCounterApp
//
//  Created by Oh!ara on 2022/06/10.
//

import Foundation
import RxCocoa
import RxSwift

protocol ViewModelInput {
    func plusButtonDidTap()
    func minusButtonDidTap()
    
    var plusButtonTap: Signal<Void> { get }
    var minusButtonTap: Signal<Void> { get }
}

protocol ViewModelOutput {
    var count: Driver<Int> { get }
    var isEven: Driver<Bool> { get }
}

protocol ViewModelType {
    var input: ViewModelInput { get }
    var output: ViewModelOutput { get }
}

final class ViewModel: ViewModelType, ViewModelInput, ViewModelOutput {
    var plusButtonTap: Signal<Void>
    
    var minusButtonTap: Signal<Void>
    
    var input: ViewModelInput { return self }
    var output: ViewModelOutput { return self }
    
    // output
    var count: Driver<Int>
    var isEven: Driver<Bool>
    
    private let plusButtonDidTapPropaerty = PublishSubject<Void>()
    private let minusButtonDidTapProperty = PublishSubject<Void>()
    
    init(plusButtonTap: Signal<Void>, minusButtonTap: Signal<Void>) {
        
        self.plusButtonTap = plusButtonTap
        self.minusButtonTap = minusButtonTap
        
        count = Observable.merge(plusButtonTap.asObservable().map { _ in 1 },
                                 minusButtonTap.asObservable().map { _ in -1 })
        .scan(0, accumulator: +)
        .startWith(0)
        .asDriver(onErrorDriveWith: .empty())
        
//        count = Observable.merge(plusButtonDidTapPropaerty.map { _ in 1 },
//                                 minusButtonDidTapProperty.map { _ in -1 })
//        .scan(0, accumulator: +)
//        .startWith(0)
//        .asDriver(onErrorDriveWith: .empty())
        
        isEven = count.map { counter in
            counter % 2 == 0
        }
    }
    
    func plusButtonDidTap() {
        plusButtonDidTapPropaerty.onNext(())
    }
    
    func minusButtonDidTap() {
        minusButtonDidTapProperty.onNext(())
    }
    
    
    
    
}
