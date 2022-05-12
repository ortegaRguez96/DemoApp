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
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray5
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private var imageViewUser: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private var labelUserName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private var labelDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 3
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageViewUser.layer.cornerRadius = (self.imageViewUser.bounds.height / 2)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.data = nil
    }
    
    //MARK: - BODY FUNCTIONS
    private func setupData(_ data: DataResult) {
        labelUserName.text = "\(data.user.firstName ?? "") \(data.user.lastName ?? "")"
        labelDescription.text = data.description
        Task {
            self.imageViewImg.image = try await getImage(fromStringURL: data.urls.regular)
            self.imageViewUser.image = try await getImage(fromStringURL: data.user.profileImage.small)
        }
        
    }
    
    private func getImage(fromStringURL url: String) async throws -> UIImage? {
        guard let url = URL(string: url) else { return nil }
        return try await NetworkManager.shared.getImage(fromStringURL: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomCell {
    private func setupView() {
        setupViewConstraints()
    }
    
    private func setupViewConstraints() {
        addSubview(self.imageViewImg)
        let heightImageConstraint = self.imageViewImg.heightAnchor.constraint(equalToConstant: 180)
        heightImageConstraint.priority = .init(rawValue: 999)
        NSLayoutConstraint.activate([
            self.imageViewImg.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            self.imageViewImg.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            self.imageViewImg.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            heightImageConstraint
        ])
        
        addSubview(self.imageViewUser)
        NSLayoutConstraint.activate([
            self.imageViewUser.topAnchor.constraint(equalTo: self.imageViewImg.bottomAnchor, constant: 10),
            self.imageViewUser.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            self.imageViewUser.heightAnchor.constraint(equalToConstant: 40),
            self.imageViewUser.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        addSubview(labelUserName)
        NSLayoutConstraint.activate([
            labelUserName.topAnchor.constraint(equalTo: self.imageViewUser.topAnchor),
            labelUserName.leftAnchor.constraint(equalTo: self.imageViewUser.rightAnchor, constant: 10),
            labelUserName.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
        ])
        
        addSubview(self.labelDescription)
        NSLayoutConstraint.activate([
            self.labelDescription.topAnchor.constraint(equalTo: self.labelUserName.bottomAnchor, constant: 5),
            self.labelDescription.leftAnchor.constraint(equalTo: self.labelUserName.leftAnchor),
            self.labelDescription.rightAnchor.constraint(equalTo: self.labelUserName.rightAnchor),
            self.labelDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
}
