//
//  PageStepperView.swift
//  DemoApp
//
//  Created by Rafael Ortega on 11/05/22.
//

import Foundation
import UIKit

protocol PageStepperDelegate {
    func setPage(_ pageNumber: Int)
}

class PageStepperView: UIView {
    
    //MARK: - COMPONENTS
    private lazy var buttonPrevious: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(setPreviousPage(_:)), for: .touchUpInside)
        button.setTitle("Previous", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.contentHorizontalAlignment = .left
        let config = UIButton.Configuration.plain()
        button.configuration = config
        button.configuration?.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 0)
        return button
    }()
    
    private lazy var buttonNext: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(setNextPage(_:)), for: .touchUpInside)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.contentHorizontalAlignment = .right
        let config = UIButton.Configuration.plain()
        button.configuration = config
        button.configuration?.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 10)
        return button
    }()
    
    private var labelPage: UILabel = {
        let label = UILabel()
        label.text = "Page 1"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.addArrangedSubview(self.buttonPrevious)
        stack.addArrangedSubview(self.labelPage)
        stack.addArrangedSubview(self.buttonNext)
        return stack
    }()
    
    //MARK: - PROPERTIES
    var delegate: PageStepperDelegate?
    
    var currentPage: Int = 1 {
        didSet {
            labelPage.text = "Page \(currentPage)"
        }
    }
    
    //MARK: - LIFE CYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stack)
        backgroundColor = UIColor.white.withAlphaComponent(0.6)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stack.frame = bounds
    }
    
    //MARK: - BODY FUNCTIONS
    @objc private func setNextPage(_ sender: UIButton) {
        self.currentPage += 1
        self.delegate?.setPage(self.currentPage)
    }
    
    @objc private func setPreviousPage(_ sender: UIButton) {
        guard self.currentPage > 1 else { return }
        self.currentPage -= 1
        self.delegate?.setPage(self.currentPage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
