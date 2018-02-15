//
//  CharacterDetailViewController.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 12..
//  Copyright © 2018. W.UP. All rights reserved.
//

import AlamofireImage
import Common
import Dip_UI
import UIKit

class CharacterDetailViewController: UIViewController {
    var characterId: Int32? {
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

    func showCharacter(character: CommonCharacter) {
        self.characterNameLabel?.text = character.name

        if let url = URL(string: character.thumbnailUrl) {
            self.thumbnailImageView?.af_setImage(withURL: url)
        }
    }
}

extension CharacterDetailViewController: StoryboardInstantiatable { }
