//
//  Config.swift
//  Tesfy
//
//  Created by Pedro Valdivieso on 10/10/2020.
//

struct Variation: Codable {
    var id: String
    var percentage: Double
}

struct Experiment: Codable {
    var id: String
    var percentage: Double
    var variations: [Variation]
    var audience: [String: JSONAny]?
}

struct Feature: Codable {
    var id: String
    var percentage: Double
    var audience: [String: JSONAny]?
}

struct Allocation {
    var id: String
    var rangeEnd: Double
}

struct Datafile: Codable {
    var experiments: [String: Experiment]?
    var features: [String: Feature]?
}

class Config {
    
    private var datafile: Datafile;
    private var maxBuckets: Double;

    init(datafile: String, maxBuckets: Double) {
        let data = datafile.data(using: .utf8)!
        self.datafile = try! JSONDecoder().decode(Datafile.self, from: data)
        self.maxBuckets = maxBuckets;
    }

    private func computeRangeEnd(percentage: Double) -> Double {
        return floor((self.maxBuckets * percentage) / 100)
    }

    func getExperiments() -> [String: Experiment] {
        let experiments: [String: Experiment] = self.datafile.experiments ?? [:]
        return experiments;
    }

    func getExperiment(id: String) -> Experiment? {
        let experiments = self.getExperiments()
        return experiments[id]
    }

//    getFeatures(): { [id: string]: Feature } {
//        const { features = {} } = this.datafile;
//        return features;
//      }
//
//      getFeature(id: string): Feature {
//        const features = this.getFeatures();
//        return features[id];
//      }
//
//      getFeatureAllocation(id: string): Allocation | undefined {
//        const feature = this.getFeature(id);
//
//        if (!feature) {
//          return;
//        }
//
//        const rangeEnd = this.computeRangeEnd(feature.percentage);
//
//        return { id, rangeEnd };
//      }
    
    func getExperimentAllocation(id: String) -> Allocation? {
        
        guard let experiment = self.getExperiment(id: id) else {
            return nil
        }

        let rangeEnd = self.computeRangeEnd(percentage: experiment.percentage)
        
        let allocation = Allocation(id: id, rangeEnd: rangeEnd)

        return allocation
    }

    func getExperimentAllocations(id: String) -> [Allocation] {
        guard let experiment = self.getExperiment(id: id) else {
            return []
        }
        
        var acc: Double = 0
        
        var experimentAllocations: [Allocation] = []
        
        experiment.variations.forEach { (variation: Variation) in
            let id: String = variation.id
            let percentage: Double = variation.percentage
            
            acc += percentage / 100
            let rangeEnd: Double = acc * self.computeRangeEnd(percentage: experiment.percentage)
            
            let allocation = Allocation(id: id, rangeEnd: rangeEnd)
            
            experimentAllocations.append(allocation)
        }
        
        return experimentAllocations
    }
}
