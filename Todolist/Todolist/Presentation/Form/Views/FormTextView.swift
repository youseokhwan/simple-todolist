//
//  PlaceholderTextView.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/08/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class FormTextView: UITextView {
    private let disposeBag = DisposeBag()
    private var heightForLimit: CGFloat = 0

    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()

        label.textColor = .lightGray
        label.sizeToFit()

        return label
    }()

    var placeholder = "" {
        didSet {
            placeholderLabel.text = placeholder
        }
    }

    override var font: UIFont? {
        didSet {
            placeholderLabel.font = font
        }
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
}

private extension FormTextView {
    func configure() {
        configureViews()
        configureBind()
        configureConstraints()
    }

    func configureViews() {
        textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layer.backgroundColor = UIColor(red: 238.0/255.0,
                                        green: 238.0/255.0,
                                        blue: 238.0/255.0,
                                        alpha: 1).cgColor
        layer.cornerRadius = 10
        addSubview(placeholderLabel)
    }

    func configureBind() {
        rx.text
            .orEmpty
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] text in
                self?.placeholderLabel.isHidden = !text.isEmpty
            })
            .disposed(by: disposeBag)

        rx.didChange
            .subscribe(onNext: { [weak self] in
                let contentHeight = self?.contentSize.height ?? 1
                let lineHeight = Int(self?.font?.lineHeight ?? 1)
                let lineCount = (Int(contentHeight) - 20) / lineHeight

                if lineCount > 4 {
                    self?.snp.remakeConstraints({ make in
                        make.height.equalTo(self?.heightForLimit ?? 0)
                    })
                } else {
                    if lineCount == 4 {
                        self?.heightForLimit = contentHeight
                    }
                    self?.snp.remakeConstraints({ make in
                        make.height.equalTo(contentHeight)
                    })
                }
            })
            .disposed(by: disposeBag)
    }

    func configureConstraints() {
        placeholderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10.5)
            make.leading.equalToSuperview().inset(16.5)
        }

        snp.makeConstraints { make in
            make.height.equalTo(42)
        }
    }
}
