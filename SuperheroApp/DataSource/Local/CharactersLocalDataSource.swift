//
//  CharactersLocalDataSource.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 11..
//  Copyright © 2018. W.UP. All rights reserved.
//

import CoreData

class CharactersLocalDataSource : CharactersDataSource {
    
    private let managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    func loadCharacters(page: Page, complete: @escaping ([Character]) -> Void, fail: @escaping () -> Void) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CharacterEntity")
        fetchRequest.fetchLimit = page.limit
        fetchRequest.fetchOffset = page.offset
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        do {
            let result = try managedObjectContext.fetch(fetchRequest)
            
            var characters = Array<Character>()
            
            for entity in result {
                let characterId = entity.value(forKey: "id") as! Int
                let name = entity.value(forKey: "name") as! String
                let thumbnailUrl = entity.value(forKey: "thumbnailUrl") as! String
                
                let character = Character(characterId: characterId, name: name, thumbnailUrl: thumbnailUrl)
                characters.append(character)
            }
            
            complete(characters)
            
        } catch {
            fail()
        }
    }
    
    func loadCharacter(characterId: String, complete: @escaping (Character?) -> Void, fail: @escaping () -> Void) {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CharacterEntity")
        fetchRequest.predicate = NSPredicate(format: "id == %@", characterId)
        
        do {
            let result = try managedObjectContext.fetch(fetchRequest)
            
            let entity = result.first
            
            let characterId = entity!.value(forKey: "id") as! Int
            let name = entity!.value(forKey: "name") as! String
            let thumbnailUrl = entity!.value(forKey: "thumbnailUrl") as! String
            
            let character = Character(characterId: characterId, name: name, thumbnailUrl: thumbnailUrl)
            complete(character)
            
        } catch {
            fail()
        }
    }
    
    func saveCharacters(characters: Array<Character>, complete: @escaping () -> Void, fail: @escaping () -> Void) {
        
        for character in characters {
            let entity = NSEntityDescription .insertNewObject(forEntityName: "CharacterEntity", into: self.managedObjectContext)
            entity.setValue(character.characterId, forKey: "id")
            entity.setValue(character.name, forKey: "name")
            entity.setValue(character.thumbnailUrl, forKey: "thumbnailUrl")
        }
        do {
            try self.managedObjectContext.save()
            complete()
        } catch {
            fail()
        }
    }
}
