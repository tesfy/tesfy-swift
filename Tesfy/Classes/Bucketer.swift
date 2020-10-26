//
//  Bucketer.swift
//  Tesfy
//
//  Created by Pedro Valdivieso on 10/10/2020.
//

import MurmurHash_Swift

class Bucketer {
    
    static let HASH_SEED: UInt32 = 1
    static let MAX_HASH_VALUE: Double = pow(2.0, 32.0) - 1.0
    
    private var maxBuckets: Double
    
    init(maxBuckets: Double) {
        self.maxBuckets = maxBuckets
    }
    
    private func computeBucketId(id: String) -> Double {
        let hashValue: UInt32 = MurmurHash3.x86_32.digest(id, seed: Bucketer.HASH_SEED)
        let ratio = Double(hashValue) / Bucketer.MAX_HASH_VALUE

        return floor(ratio * Double(self.maxBuckets));
    }
    
    func bucket(key: String, allocations: [Allocation]) -> String? {
        let bucketId = self.computeBucketId(id: key)
        
        guard let allocation: Allocation = allocations.first(where: { bucketId < $0.rangeEnd }) else {
            return nil
        }
        
        return allocation.id
    }
    
}
