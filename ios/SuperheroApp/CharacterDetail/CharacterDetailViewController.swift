//
//  CharacterDetailViewController.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 12..
//  Copyright © 2018. W.UP. All rights reserved.
//

import UIKit
import AlamofireImage
import Dip_UI

class CharacterDetailViewController: UIViewController {
    var characterId: Int? {
        didSet {
            self.loadContent()
        }
    }
    @IBOutlet weak var characterNameLabel: UILabel?
    @IBOutlet weak var thumbnailImageView: UIImageView?

    var presenter: CharacterDetailMvpPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter?.takeView(view: self)
        self.loadContent()
    }

    private func loadContent() {
        if let characterId = self.characterId {
            self.presenter?.loadCharacter(characterId: characterId)
        }
    }
}

extension CharacterDetailViewController: CharacterDetailMvpView {

    func showCharacter(character: Character) {
        self.characterNameLabel?.text = character.name

        if let url = URL(string: character.thumbnailUrl) {
            self.thumbnailImageView?.af_setImage(withURL: url)
        }
    }
}

extension CharacterDetailViewController: StoryboardInstantiatable { }
