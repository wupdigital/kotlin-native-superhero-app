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
    @IBOutlet weak var descriptionLabel: UITextView?
    @IBOutlet weak var thumbnailImageView: UIImageView?

    var presenter: CommonCharacterDetailMvpPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter?.takeView(view_: self)
        self.loadContent()
    }

    private func loadContent() {
        if let characterId = self.characterId {
            self.presenter?.loadCharacter(characterId: characterId)
        }
    }
}

extension CharacterDetailViewController: CommonCharacterDetailMvpView {

    func showCharacter(character: CommonCharacter) {
        self.characterNameLabel?.text = character.name
        self.descriptionLabel?.text = character.desc
        if let url = URL(string: character.thumbnailUrl) {
            self.thumbnailImageView?.af_setImage(withURL: url)
        }
    }

    func showNoCharacter() {
        let alert = UIAlertController(title: "Info", message: "Character not found", preferredStyle: UIAlertControllerStyle.alert)
        self.present(alert, animated: true, completion: nil)
    }

    func showErrorMessage(message: String) {
        let alert = UIAlertController(title: "Info", message: message, preferredStyle: UIAlertControllerStyle.alert)
        self.present(alert, animated: true, completion: nil)
    }
}

extension CharacterDetailViewController: StoryboardInstantiatable { }
