//
//  CreatUserRequestDTO.swift
//  iEO
//
//  Created by Demian Yoo on 4/22/25.
//

import Foundation

struct CreateUserRequestDTO: Encodable {
    let email: String
    let nickname: String
}
