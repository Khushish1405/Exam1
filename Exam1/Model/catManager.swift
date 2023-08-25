//
//  catManager.swift
//  Exam1
//
//  Created by APPLE on 15/02/23.
//

import Foundation

protocol CatManagerDelegate {
    func didUpdatecat(_ catManager: CatManager, cat: CatData)
    func didFailWithErrors(error: Error)
}

struct CatManager {
    
    var delegate: CatManagerDelegate?
    let catUrl = "https://catfact.ninja/breeds"
    
    func getJok() {
        performRequest(with: catUrl)
    }
    
    var catModel: CatModel?
    
    func performRequest(with urlString: String) {
        
        // step-1: Create a URL
        if let url = URL(string: urlString) {
            
            // step-2: Create a URLSession
            let session = URLSession(configuration: .default)
            // step-3: Give the URLSession a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithErrors(error: error!)
                    return
                }
                if let safeData = data {
                    if let cate = self.parseJSON(with: safeData) {
                        self.delegate?.didUpdatecat(self, cat: cate)
                    }
                }
            }
            // step-4: Start the task
            task.resume()
        }
    }
    
    func parseJSON(with catData: Data) -> CatData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CatData.self, from: catData)

            let breeds = decodedData.data
            var cat = CatModel(breed: breeds)
            print(cat)
            return decodedData

        } catch {
            delegate?.didFailWithErrors(error: error)
            return nil
        }
    }
}
