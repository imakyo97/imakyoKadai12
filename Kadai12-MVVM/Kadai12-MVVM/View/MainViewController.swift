//
//  MainViewController.swift
//  Kadai12-MVVM
//
//  Created by 今村京平 on 2021/08/23.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {

    @IBOutlet private weak var taxExcludedTextField: UITextField!
    @IBOutlet private weak var taxRateTextField: UITextField!
    @IBOutlet private weak var calcButton: UIButton!
    @IBOutlet private weak var includingTaxLabel: UILabel!
    @IBOutlet private weak var deleteButton: UIButton!
    @IBOutlet private var tapGesture: UITapGestureRecognizer!

    private let viewModel: CalculationViewModelType = CalculationViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        viewModel.inputs.loadTaxRate()
    }

    private func setupBinding() {
        taxExcludedTextField.rx.text
            .map { Int32($0!) ?? 0 }
            .bind(to: viewModel.inputs.taxExcludedRelay)
            .disposed(by: disposeBag)

        taxRateTextField.rx.text
            .map { Int32($0!) ?? 0 }
            .bind(to: viewModel.inputs.taxRateRelay)
            .disposed(by: disposeBag)

        calcButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.viewModel.inputs.didTapCalcButton()
            })
            .disposed(by: disposeBag)

        tapGesture.rx.event
            .bind(onNext: { [weak self] _ in
                self?.viewModel.inputs.didTapView()
            })
            .disposed(by: disposeBag)

        viewModel.outputs.event
            .drive(onNext: { [weak self] event in
                switch event {
                case .result(let result):
                    self?.includingTaxLabel.text = String(result)
                case .loadTaxRate(let taxRate):
                    self?.taxRateTextField.text = String(taxRate)
                case .endEditing:
                    self?.view.endEditing(true)
                }
            })
            .disposed(by: disposeBag)

        deleteButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.viewModel.inputs.didTapDeleteButton()
            })
            .disposed(by: disposeBag)
    }
}
