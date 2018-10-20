//
//  Result.swift
//  TheMovieDB
//
//  Created by Mohamed Abdul-Hameed on 10/20/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

enum Result<ResponseModel: Codable>{
    case success(ResponseModel)
    case failure(Error)
}
