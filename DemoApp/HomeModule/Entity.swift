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

    enum CodingKeys: String, CodingKey {
        case id
        case user
        case urls
    }
}

// MARK: - User
struct User: Codable {
    let id: String
    let username, name, firstName, lastName: String?
    let bio, location: String?
    let profileImage: ProfileImage

    enum CodingKeys: String, CodingKey {
        case id
        case username, name
        case firstName = "first_name"
        case lastName = "last_name"
        case bio, location
        case profileImage = "profile_image"
    }
}

// MARK: - Urls
struct Urls: Codable {
    let full, regular, small: String
    let thumb: String?

    enum CodingKeys: String, CodingKey {
        case full, regular, small, thumb
    }
}

// MARK: - ProfileImage
struct ProfileImage: Codable {
    let small, medium, large: String
}
