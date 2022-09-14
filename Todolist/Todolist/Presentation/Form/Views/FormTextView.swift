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
    private static let maxLineCount = 4

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
        isScrollEnabled = false
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
                guard let self = self,
                      let lineHeight = self.font?.lineHeight else { return }

                let verticalInset = self.textContainerInset.top + self.textContainerInset.bottom
                let maxHeight = lineHeight * CGFloat(Self.maxLineCount) + verticalInset
                let size = CGSize(width: self.frame.width, height: .infinity)
                let estimatedSize = self.sizeThatFits(size)
                let numberOfLine = Int(estimatedSize.height / lineHeight)

                self.isScrollEnabled = numberOfLine > Self.maxLineCount
                self.snp.remakeConstraints { make in
                    make.height.equalTo(min(estimatedSize.height, maxHeight))
                }
            })
            .disposed(by: disposeBag)
    }

    func configureConstraints() {
        placeholderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10.5)
            make.leading.equalToSuperview().inset(16.5)
        }
    }
}
