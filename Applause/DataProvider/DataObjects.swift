//
//  DataObjects.swift
//  Applause
//
//  Created by Sokolowski, Kamil on 07/11/2019.
//  Copyright © 2019 TypeIT Kamil Sokołowski. All rights reserved.
//

import Foundation

public struct Repository: Decodable {
    let id: Int
    let name: String
    let url: String
    let size: Int
    let description: String?
    let language: String?
}
