//
//  Entity.swift
//  DemoApp
//
//  Created by Rafael Ortega on 11/05/22.
//

import Foundation

// MARK: - DataResponse
struct DataResponse: Codable {
    let total, totalPages: Int
    let results: [DataResult]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
struct DataResult: Codable {
    let id: String
    let user: User
    let urls: Urls
    let description: String?

    enum CodingKeys: String, CodingKey {
        case id, user, urls, description
    }
}

// MARK: - User
struct User: Codable {
    let id: String
    let name, firstName, lastName: String?
    let profileImage: ProfileImage

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case firstName = "first_name"
        case lastName = "last_name"
        case profileImage = "profile_image"
    }
}

// MARK: - Urls
struct Urls: Codable {
    let regular: String

    enum CodingKeys: String, CodingKey {
        case regular
    }
}

// MARK: - ProfileImage
struct ProfileImage: Codable {
    let small: String
}
