//
//  CustomTableViewCell.swift
//  PruebaTecninca
//
//  Created by Rafael Ortega on 10/05/22.
//

import Foundation
import UIKit

class CustomCell: UITableViewCell {
    
    //MARK: - COMPONENTS
    private var imageViewImg: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray5
        return imageView
    }()
    
    private var imageViewUser: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray5
        return imageView
    }()
    
    private var labelName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    //MARK: - PROPIERTIES
    var data: DataResult? {
        didSet {
            guard let data = data else { return }
            setupData(data)
        }
    }
    
    //MARK: - LIFE CYCLE
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.data = nil
    }
    
    private func setupData(_ data: DataResult) {
        labelName.text = data.user.firstName
        Task {
            self.imageViewImg.image = try await getImage(fromStringURL: data.urls.regular)
            self.imageViewUser.image = try await getImage(fromStringURL: data.user.profileImage.small)
        }
        
    }
    
    private func getImage(fromStringURL url: String) async throws -> UIImage? {
        guard let url = URL(string: url) else { return nil }
        return try await NetworkManager.shared.getImage(fromStringURL: url)
    }
    
    private func setupView() {
        setupViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CustomCell {
    private func setupViewConstraints() {
        addSubview(self.imageViewImg)
        [
            self.imageViewImg.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            self.imageViewImg.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            self.imageViewImg.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            self.imageViewImg.heightAnchor.constraint(equalToConstant: 120)
        ].forEach({$0.isActive = true})
        
        addSubview(self.imageViewUser)
        [
            self.imageViewUser.topAnchor.constraint(equalTo: self.imageViewImg.bottomAnchor, constant: 10),
            self.imageViewUser.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            self.imageViewUser.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            self.imageViewUser.widthAnchor.constraint(equalToConstant: 40),
            self.imageViewUser.heightAnchor.constraint(equalToConstant: 40)
        ].forEach({$0.isActive = true})
        self.imageViewUser.layer.masksToBounds = true
        self.imageViewUser.layer.cornerRadius = 20
        
        addSubview(self.labelName)
        [
            self.labelName.centerYAnchor.constraint(equalTo: self.imageViewUser.centerYAnchor),
            self.labelName.leftAnchor.constraint(equalTo: self.imageViewUser.rightAnchor, constant: 5),
            self.labelName.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
        ].forEach({$0.isActive = true})
    }
}
