//
//  Tesfy.swift
//  Tesfy
//
//  Created by Pedro Valdivieso on 10/10/2020.
//

public class Tesfy {
    
    private let TOTAL_BUCKETS = 10000.00
    private let TRAFFIC_ALLOCATION_SALT = "tas"
    
    private var config: Config
    private var bucketer: Bucketer
    private var evaluator: AudienceEvaluator
    private var userId: String?
    private var attributes: String?
    private var storage: TesfyStorable?
    private var cache: [String:String]
    
    public init(datafile: String, storage: TesfyStorable? = nil, userId: String? = nil, attributes: String? = nil) {
        self.config = Config(datafile: datafile, maxBuckets: self.TOTAL_BUCKETS)
        self.bucketer = Bucketer(maxBuckets: self.TOTAL_BUCKETS)
        self.evaluator = AudienceEvaluator()
        self.storage = storage
        self.userId = userId
        self.attributes = attributes
        self.cache = [:]
    }
    
    private func computeKey(id: String, userId: String? = "", salt: String? = "") -> String {
        return "\(userId ?? self.userId ?? "")\(id)\(salt ?? "")"
    }
    
    private func getForcedVariation(experimentId: String) -> String? {
        return self.cache[experimentId];
    }
    
    public func getUserId() -> String? {
        return self.userId;
    }

    public func getAttributes() -> String? {
        return self.attributes;
    }

    public func setUserId(userId: String) {
        self.userId = userId;
    }

    public func setAttributes(attributes: String) {
        self.attributes = attributes;
    }

    public func setForcedVariation(experimentId: String, variationId: String) {
        self.cache[experimentId] = variationId;
    }
    
    // TODO
    // Missing features
    
    public func getVariationId(experimentId: String, userId: String?, attributes: String?) -> String? {
        // If forced variation return it
        if let variationId = self.getForcedVariation(experimentId: experimentId) {
            return variationId
        }
        
        // If variation is in storage return it
        if let variationId = self.storage?.get(id: experimentId) {
            return variationId
        }
        
        guard let experiment: Experiment = self.config.getExperiment(id: experimentId) else {
            return nil
        }
        
        if let audience: [String: JSONAny] = experiment.audience {
            if (!self.evaluator.evaluate(audience: audience, attributes: attributes ?? self.attributes)) {
                return nil
            }
        }
        
        var key = self.computeKey(id: experimentId, userId: userId, salt: self.TRAFFIC_ALLOCATION_SALT)
        guard let allocation = self.config.getExperimentAllocation(id: experimentId) else {
            return nil
        }
        
        guard let _ = self.bucketer.bucket(key: key, allocations: [allocation]) else {
            return nil
        }
        
        key = self.computeKey(id: experimentId, userId: userId)
        let allocations = self.config.getExperimentAllocations(id: experimentId)
        
        let variationId = self.bucketer.bucket(key: key, allocations: allocations)
        
        if let storage = self.storage {
            storage.store(id: experimentId, value: variationId)
        }
        
        return variationId
    }
    
    public func getVariationIds(userId: String?, attributes: String?) -> [String: String] {
        let experiments: [String: Experiment] = self.config.getExperiments()
        
        return experiments.reduce(into: [:]) { dict, element in
            dict[element.0] = self.getVariationId(experimentId: element.0, userId: userId, attributes: attributes)
        }
    }
    
}
