//
//  Storage.swift
//  Tesfy
//
//  Created by Pedro Valdivieso on 26/10/2020.
//

public protocol TesfyStorable {
    func get(id: String) -> String?
    func store(id: String, value: String?)
}
