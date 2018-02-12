//
//  CharacterDetailViewController.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 12..
//  Copyright © 2018. W.UP. All rights reserved.
//

import UIKit
import AlamofireImage

class CharacterDetailViewController: UIViewController {
    var characterId: String {
        didSet {
            self.loadContent()
        }
    }
    @IBOutlet weak var characterNameLabel: UILabel
    @IBOutlet weak var thumbnailImageView: UIImageView
    
    var presenter: CharacterDetailContract.CharacterDetailPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.takeView(view: self)
    }
    
    private func loadContent() {
        if let characterId = self.characterId {
            self.presenter.loadCharacter(characterId: characterId)
        }
    }
}

extension CharacterDetailViewController: CharacterDetailContract.CharacterDetailView {
    
    func showCharacter(character: Character) {
        self.characterNameLabel.text = character.name
        self.thumbnailImageView.af_setImage(withURL: URL(character.characterId))
    }
}
