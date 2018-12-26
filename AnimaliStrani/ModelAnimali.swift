//
//  ModelAnimali.swift
//  Popescu.Petrisor.TSAM2
//
//  Created by popescu petrisor on 19/12/18.
//  Copyright © 2018 popescu petrisor. All rights reserved.
//

import Foundation
protocol MandaDati{
    func recuperaDati(dati:[Animali])
}
class ModelAnimali{
    
    var delegate:MandaDati?
    func getDatiEsteno(){
        
        let stringUrl="http://www.willyx.it/esercizio/animaliStrani.json"
        let url = URL (string: stringUrl)
        guard url != nil else {
            print ("couldn't get a url object")
            return
        }
       
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!){
            (data,response,error) in
            if error == nil && data != nil {
               
                let decoder = JSONDecoder()
                do {
                   
                    let array = try decoder.decode([Animali].self, from: data!)
                   
                    
                    DispatchQueue.main.async {
                        
                        self.delegate?.recuperaDati(dati: array)
                        
                    }
                    
                }
                catch{
                    print ("couldn't parse the json")
                }
            }
        }
       
        dataTask.resume()
        
    }
    
}
