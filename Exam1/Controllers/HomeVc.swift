//
//  HomeVc.swift
//  Exam1
//
//  Created by APPLE on 15/02/23.
//

import UIKit

class HomeVc: UIViewController,JokeManagerDelegate, CatManagerDelegate {
    
    var catNames: [deetail] = []
    
    @IBOutlet var collectionView: UICollectionView!

    @IBOutlet var jokeLabel: UILabel!
    @IBOutlet var jokeLabel1: UILabel!
    
    var jokeManager = JokeManager()
    var catManager = CatManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jokeManager.delegate = self
        jokeManager.getJok()
        
        catManager.delegate = self
        catManager.getJok()
        
//        collectionView.dataSource = self
//        collectionView.delegate = self
        
    }
    
    func didUpdateJoke(_ jokeManager: JokeManager, joke: JokeModel) {
        
        DispatchQueue.main.async {
            
            self.jokeLabel.text = joke.setup
            self.jokeLabel1.text = joke.punchline
            
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
    func didUpdatecat(_ catManager: CatManager, cat: CatData) {
        catNames = cat.data
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func didFailWithErrors(error: Error) {
        print(error)
    }
    
}

extension HomeVc: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(catNames.count)
        return catNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCellCollectionViewCell
        cell.name.text = catNames[indexPath.row].breed
        return cell
    }
}
