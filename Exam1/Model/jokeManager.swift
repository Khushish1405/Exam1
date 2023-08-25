//
//  jokeManager.swift
//  Exam1
//
//  Created by APPLE on 15/02/23.
//

import Foundation

protocol JokeManagerDelegate {
    func didUpdateJoke(_ jokeManager: JokeManager, joke: JokeModel)
    func didFailWithError(error: Error)
}


struct JokeManager {
    
    var delegate: JokeManagerDelegate?
    
    let url = "https://official-joke-api.appspot.com/random_joke"
    func getJok() {
        performRequest(with: url)
    }
    
    var jokModel: JokeModel?
    
    func performRequest(with urlString: String) {
        
        // step-1: Create a URL
        if let url = URL(string: urlString) {
            
            // step-2: Create a URLSession
            let session = URLSession(configuration: .default)
            // step-3: Give the URLSession a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let joke = self.parseJSON(with: safeData) {
                        self.delegate?.didUpdateJoke(self, joke: joke)
                    }
                }
            }
            // step-4: Start the task
            task.resume()
        }
    }
    
    func parseJSON(with jokeData: Data) -> JokeModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(JokeData.self, from: jokeData)
        
            let setup = decodedData.setup
            let punchline = decodedData.punchline
            
            let joke = JokeModel(setup: setup, punchline: punchline)
            
            return joke

            } catch {
                delegate?.didFailWithError(error: error)
                return nil
            }
    }
    
}

