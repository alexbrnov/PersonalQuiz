//
//  ResultViewController.swift
//  PersonalQuiz
//
//  Created by Alexey Efimov on 07.08.2023.
//

import UIKit

final class ResultViewController: UIViewController {
    // MARK: - IB Outlets
    @IBOutlet var resultLablel: UILabel!
    @IBOutlet var resultDefinitionLabel: UILabel!
    
    // MARK: - Public Properties
    var answers: [Answer]!
    
    // MARK: - Private Properties
    private var mostFrequentAnimal: Animal {
        getMostFrequentAnimal(from: answers)
    }
    
    // MARK: - Overrides Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
        
        resultLablel.text = "Вы - \(String(mostFrequentAnimal.rawValue))!"
        resultDefinitionLabel.text = mostFrequentAnimal.definition
    }
    // MARK: - IB Actions
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    // MARK: - Public Methods
    deinit {
        print("\(type(of: self)) has been deallocated")
    }
}

// MARK: - Private Methods
private extension ResultViewController {
    func getMostFrequentAnimal(from answers: [Answer]) -> Animal {
        var animalCounts: [Animal: Int] = [:]
        var maxCount = 0
        
        for answer in answers {
            if let existingCount = animalCounts[answer.animal] {
                animalCounts[answer.animal] = existingCount + 1
            } else {
                animalCounts[answer.animal] = 1
            }
        
            if let count = animalCounts[answer.animal], count > maxCount {
                maxCount = count
            }
        }
        
        let mostFrequentAnimals = animalCounts.filter { $0.value == maxCount }.map { $0.key }
        guard let resultAnimal: Animal = mostFrequentAnimals.first else { return .cat }
        return resultAnimal
    }
}

