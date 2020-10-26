//
//  ViewController.swift
//  Tesfy
//
//  Created by gringox on 10/26/2020.
//  Copyright (c) 2020 gringox. All rights reserved.
//

import UIKit
import Tesfy

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
        
        let tesfy = Tesfy(datafile: datafile)
        
        let variationId = tesfy.getVariationId(experimentId: "experiment-1", userId: userId, attributes: attributes)
        print(variationId as Any)
        
//        let variationIds = tesfy.getVariationIds(userId: userId, attributes: attributes)
//        print(variationIds as Any)
    }

}

