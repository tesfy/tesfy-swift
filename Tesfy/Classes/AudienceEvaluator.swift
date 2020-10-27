//
//  AudienceEvaluator.swift
//  Tesfy
//
//  Created by Pedro Valdivieso on 17/10/2020.
//

import jsonlogic

class AudienceEvaluator {
    
    private func getStringFromJSONAny(dictionary: [String: JSONAny]?) throws -> String {
        guard dictionary != nil else { return "" }
        let data = try JSONEncoder().encode(dictionary)
        guard let string = String(data: data, encoding: String.Encoding.utf8) else { return "" }
        return string
    }
    
    func evaluate(audience: [String: JSONAny]?, attributes: String?) -> Bool {
        do {
            guard let _ = attributes else { return false }
            let rule = try self.getStringFromJSONAny(dictionary: audience)
            let result: Bool = try applyRule(rule, to: attributes)
            return result
        } catch {
            return false
        }
    }
    
}
