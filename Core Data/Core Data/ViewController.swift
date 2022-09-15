//
//  ViewController.swift
//  Core Data
//
//  Created by Milena Maia Araújo on 14/09/22.
//

import UIKit

class ViewController: UIViewController {
    
    // get the reference of our core data based on the view context. So, basically, you can interact with core data by this context constant
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        var items: [Person]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        var creationStatus = createNewPerson()
        //print("\n\n")
        var removedPerson = deletePerson(personId: 1)
//        fetchPeople()
    }
    
        func fetchPeople() {
            do {
                self.items = try context.fetch(Person.fetchRequest())
                if let items = items, !items.isEmpty {
                    items.forEach { print("id: \($0.id) age: \($0.age) name: \($0.name!) gender: \($0.gender!)") }
                } else {
                    print("Items is empty")
                }
            } catch {
                print("Something went wrong while fetching the data. Please, try again.")
            }
            
        }
    
    func createNewPerson() -> Bool{
        // creates the new object
        
        let newPerson = Person(context: self.context)
    
        newPerson.name = "James"
        newPerson.age = 22
        newPerson.gender = "Male"
        newPerson.id = 1
        
        
        // saves this object at the core data
        do {
            try self.context.save()
            fetchPeople()
            return true
        } catch {
            print("Something went wrong while saving the data at the core data.")
            return false
        }
        
        // change the view
        
        
    }
    
    func getPersonById (personId: Int) -> Person? {
        let fetch = Person.fetchRequest()
        fetch.predicate = NSPredicate(format: "id == %@", "\(personId)")
        do {
            let person = try context.fetch(fetch).first
            return person
        } catch {
            print(error)
        }
        return nil
//        fetchPeople()
//        var person = self.items?.filter({$0.id == personId}).first
//        print(person)
//        return person
    }
    
    func deletePerson(personId: Int) -> Bool {
        
        // get the person to remove
        let personToRemove = getPersonById(personId: 1)
        if let person = personToRemove {
            // remove the person
            self.context.delete(person)
            
            //re-save the data
            do {
                try self.context.save()
                fetchPeople()
                return true
            } catch{
                print("Failed to save the data while deleting the person \(person)")
            }
        } else {
            print("Cant remove this person because the ID doesnt match.")
            return false
        }

        return false
    }
        // Do any additional setup after loading the view.


}

