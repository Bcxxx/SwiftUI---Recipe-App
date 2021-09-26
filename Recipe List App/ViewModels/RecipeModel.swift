//
//  RecipeModel.swift
//  Recipe List App
//
//  Created by Peter Mihók on 16/09/2021.
//

import Foundation

class RecipeModel: ObservableObject {
    
    @Published var recipes = [Recipe]()
    
    init() {
        
        //Create an instance of data service and get the data
        self.recipes = DataService.getLocalData()
        
    }
    
    static func getPortion(ingredient:Ingredient, recipeServings:Int, targetServings:Int) -> String {
        
        var portion = ""
        var numerator = ingredient.num ?? 1
        var denominator = ingredient.denom ?? 1
        var wholePortions = 0
        
        if ingredient.num != nil {
            //Get a single serving size by multiplying denominator by the recipe servings
            denominator *= recipeServings
            //Get target portion by multiplying numerator by target servings
            numerator *= targetServings
            //Reduce fraction by greates common divisor
            let divisor = Rational.greatestCommonDivisor(numerator, denominator)
            numerator /= divisor
            denominator /= divisor
            //Get the whole portion if numerator > denominator
            if numerator > denominator {
                wholePortions = numerator / denominator
                numerator %= denominator
            }
            //Express the remainder as a fraction
        }
        
        
        
        
        return String(targetServings)
        
    }
    
}
