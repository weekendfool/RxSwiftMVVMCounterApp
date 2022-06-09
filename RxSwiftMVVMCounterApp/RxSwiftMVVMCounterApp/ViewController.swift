//
//  ViewController.swift
//  RxSwiftMVVMCounterApp
//
//  Created by Oh!ara on 2022/06/10.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var sampleLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    
//    private let viewModel: ViewModelType
    private let disposeBag = DisposeBag()
    
//    init(viewModel: ViewModelType = ViewModel()) {
//
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        bind()
    }

    func bind() {
        let viewModel = ViewModel()
        
        // input
        plusButton.rx.tap
            .subscribe { [viewModel] in
                viewModel.input.plusButtonDidTap()
            }
            .disposed(by: disposeBag)
        
        minusButton.rx.tap
            .subscribe { [viewModel] in
                viewModel.input.minusButtonDidTap()
            }
            .disposed(by: disposeBag)
        
        // output
        viewModel.output
            .count.map { String($0) }
            .drive(sampleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output
            .isEven
            .map { $0 ? UIColor.black : UIColor.red }
            .drive { [sampleLabel] in
                sampleLabel?.textColor = $0
            }.disposed(by: disposeBag)


    }
    

}

