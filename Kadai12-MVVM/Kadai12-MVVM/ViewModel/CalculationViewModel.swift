//
//  CalculationViewModel.swift
//  Kadai12-MVVM
//
//  Created by 今村京平 on 2021/08/23.
//

import RxSwift
import RxCocoa
import RealmSwift

protocol CalculationViewModelInput {
    func didTapCalcButton()
    var taxExcludedRelay: PublishRelay<Int32> { get }
    var taxRateRelay: PublishRelay<Int32> { get }
    func didTapDeleteButton()
    func loadTaxRate()
    func didTapView()
}

protocol CalculationViewModelOutput {
    var event: Driver<CalculationViewModel.Event> { get }
}

protocol CalculationViewModelType {
    var inputs: CalculationViewModelInput { get }
    var outputs: CalculationViewModelOutput { get }
}

final class CalculationViewModel: CalculationViewModelInput, CalculationViewModelOutput {

    enum Event {
            case result(Int32)
            case loadTaxRate(Int32)
            case endEditing
        }

    private let model: CalculationModel = Calculation()
    private let disposeBag = DisposeBag()
    private let eventRelay = PublishRelay<Event>()

    private let dataRepository = DataRepository()

    var event: Driver<Event> {
        eventRelay.asDriver(onErrorDriveWith: .empty())
    }

    var taxExcludedRelay = PublishRelay<Int32>()
    var taxRateRelay = PublishRelay<Int32>()

    private var taxExcluded: Int32 = 0
    private var taxRate: Int32 = 0

    init() {
        setupBinding()
    }

    private func setupBinding() {
        model.result
            .map(Event.result)
            .bind(to: eventRelay)
            .disposed(by: disposeBag)

        taxExcludedRelay
            .bind(onNext: { [weak self] value in
                self?.taxExcluded = value
            })
            .disposed(by: disposeBag)

        taxRateRelay
            .bind(onNext: { [weak self] value in
                self?.taxRate = value
            })
            .disposed(by: disposeBag)
    }

    func didTapCalcButton() {
        model.calculation(taxExcluded: taxExcluded, taxRate: taxRate)
        dataRepository.save(taxRate: taxRate)
        eventRelay.accept(.endEditing)
    }

    func didTapDeleteButton() {
        dataRepository.delete()
    }

    func loadTaxRate() {
        guard let taxRate = dataRepository.load() else { return }
        eventRelay.accept(.loadTaxRate(taxRate))
        self.taxRate = taxRate
    }

    func didTapView() {
        eventRelay.accept(.endEditing)
    }
}

extension CalculationViewModel: CalculationViewModelType {
    var inputs: CalculationViewModelInput {
        return self
    }

    var outputs: CalculationViewModelOutput {
        return self
    }
}
