//
//  DataService.swift
//  Recipe List App
//
//  Created by Peter Mihók on 16/09/2021.
//

import Foundation

class DataService {
    
    static func getLocalData() -> [Recipe] {
        
        //Parse local json file
        
        //Get a url path to the json file
        let pathString = Bundle.main.path(forResource: "recipes", ofType: "json")
        
        //Check if the pathString is not nil, otherwise...
        guard pathString != nil else {
            return [Recipe]()
        }

        //Create a url object
        let url = URL(fileURLWithPath: pathString!)
        
        //Create a data object
        
        do {
            let data = try Data(contentsOf: url)
            
            //Decode the data with JSON decoder
            let decoder = JSONDecoder()
            
            do {
                let recipeData = try decoder.decode([Recipe].self, from: data)
                
                //Add the unique IDs
                for i in recipeData {
                    i.id = UUID()
                    
                    //Add unique IDs to recipe ingredients
                    for j in i.ingredients {
                        j.id = UUID()
                    }
                }
                
                // Return the recipes
                return recipeData
            }
            catch {
                //Error with parsin json
                print(error)
            }
 
        }
        catch {
            //Error with getting data
            print(error)
        }
        
        return [Recipe]()
    }
    
}
