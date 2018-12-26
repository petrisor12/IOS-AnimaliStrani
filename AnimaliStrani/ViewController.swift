//
//  ViewController.swift
//  Popescu.Petrisor.TSAM2
//
//  Created by popescu petrisor on 19/12/18.
//  Copyright © 2018 popescu petrisor. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MandaDati {
    var dati = [Animali]()
    var modelAnimali=ModelAnimali()
    var i:Int=0
    var energiaTotale:Int = 0
    var energiaMassima:Int = 0
    var timer:Timer?
    var bool1:Bool=true
   
    
     let tmp="http://www.willyx.it/esercizio/"
    @IBOutlet weak var stackViewLeading: NSLayoutConstraint!
    
    @IBOutlet weak var stackViewTrailing: NSLayoutConstraint!
    @IBOutlet weak var labelEnergiaMassima: UILabel!
    @IBOutlet weak var labelEnergiaTotale: UILabel!
    @IBOutlet weak var imgImageView: UIImageView!
   
    @IBAction func buttonRigenera(_ sender: Any) {
       //genero i nuovi dati e faccio partire il timer
        insertDati()
        bool1=true
       
        
        
    }
    //button per aggiungere energia
    @IBAction func buttonAggiungiEnergia(_ sender: Any) {
        if bool1==true
        {energiaTotale = energiaTotale+2
            showEnergia()}
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        modelAnimali.delegate = self
        modelAnimali.getDatiEsteno()
       goTimer()
        
    }
    func  goTimer(){
         timer=Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        
    }
    @objc func timerElapsed(){
        
        if (energiaTotale<=0 && bool1 == true){
           
        morteAnimale()
        return
        } else if energiaTotale > 0 {
            energiaTotale = energiaTotale-10
            if energiaTotale<0{
                energiaTotale=0
            }
            showEnergia()
        }
        
        
        
       
    }
     //func per recupero dati tramite procedura delegate
    func recuperaDati(dati: [Animali]) {
        print("i dati ci sono")
        self.dati = dati
        insertDati()
    }
    //funz per vizualizzatione dati 
    func insertDati(){
        
       var  s = Int.random(in: 0..<dati.count-1)
        if i<dati[s].immagini!.count-1{
            i=i+1
        }
        else {
            i = 0
        }
        
        let url : URL = URL(string: tmp + "\(dati[s].immagini![i])")!
       imgImageView.load(url: url)
        labelEnergiaMassima.text = "\(dati[s].energiaMax!)"
        energiaTotale = dati[s].energiaMax!
        showEnergia()
        
        
    }
    //func per mostrare energia
    func showEnergia(){
        labelEnergiaTotale.text = "\(energiaTotale)"
        
    }
    //func  per quando l'energia diventa 0
    func morteAnimale(){
        bool1=false
        let tmp1="http://www.willyx.it/esercizio/imgs/rip.jpg"
        let url1 : URL = URL(string: tmp1 )!
        imgImageView.load(url: url1)
       slideIn()
        labelEnergiaMassima.text="0"
        labelEnergiaTotale.text="0"
        
    }
    func slideIn(){
        // set the starting state
       
       stackViewLeading.constant = 1000
        stackViewTrailing.constant = -1000
        view.layoutIfNeeded()
        //animate to the ending state
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
           
            self.stackViewLeading.constant = 0
            self.stackViewTrailing.constant = 0
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        
    }
    
    
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
