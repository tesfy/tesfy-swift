//
//  ViewController.swift
//  Tesfy
//
//  Created by gringox on 10/26/2020.
//  Copyright (c) 2020 gringox. All rights reserved.
//

import UIKit
import Tesfy

class TesfyStorage: TesfyStorable {
    var storage: [String: String]
    
    init(storage: [String: String]? = [:]) {
        self.storage = storage ?? [:]
    }
    
    func get(id: String) -> String? {
        return storage[id]
    }
    
    func store(id: String, value: String?) {
        self.storage[id] = value
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let datafile = """
            {
                "experiments": {
                    "experiment-1": {
                        "id": "experiment-1",
                        "percentage": 90,
                        "variations": [{
                            "id": "0",
                            "percentage": 50
                        }, {
                            "id": "1",
                            "percentage": 50
                        }]
                    },
                    "experiment-2": {
                        "id": "experiment-2",
                        "percentage": 100,
                        "variations": [{
                            "id": "0",
                            "percentage": 100
                        }],
                        "audience": {
                            "==": [{ "var": "countryCode" }, "us"]
                        }
                    }
                },
                "features": {
                    "feature-1": {
                        "id": "feature-1",
                        "percentage": 50
                    }
                }
            }
        """
        
        let userId = "4qz936x2-62ex"
        let attributes = """
            { "countryCode": "us" }
        """
        
        let tesfyStorage = TesfyStorage()
        let tesfy = Tesfy(datafile: datafile, storage: tesfyStorage)
                
        let variationId = tesfy.getVariationId(experimentId: "experiment-1", userId: userId, attributes: attributes)
        print("experiment-1 variationId: \(variationId as Any)")
        
        print("")
        
        let variationIds = tesfy.getVariationIds(userId: userId, attributes: attributes)
        print("variationIds: \(variationIds as Any)")
        
        print("")
        
        let isFeatureEnabled = tesfy.isFeatureEnabled(featureId: "feature-1", userId: userId, attributes: attributes)
        print("feature-1 isFeatureEnabled: \(isFeatureEnabled as Any)")
        
        print("")
        
        let featuresEnabled = tesfy.getEnabledFeatures(userId: userId, attributes: attributes)
        print("featuresEnabled: \(featuresEnabled as Any)")
    }

}

