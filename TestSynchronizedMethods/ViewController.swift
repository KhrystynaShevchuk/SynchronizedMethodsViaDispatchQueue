//
//  ViewController.swift
//  TestSynchronizedMethods
//
//  Created by KhrystynaShevchuk on 9/12/16.
//  Copyright © 2016 KhrystynaShevchuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var completed: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        completed.hidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        
        doConcurrentQueue()
    }

    func doConcurrentQueue(){
        let concurrentQueue = dispatch_queue_create("com.synchronizedMethods.cQueue", DISPATCH_QUEUE_CONCURRENT)
        
        dispatch_async(concurrentQueue) { () -> Void in
            var count: Int = 0
            var sum: Int = 1
            while count <= 10 {
                let number: Int = Int(arc4random_uniform(35) + 5)
                sum += number
                
                dispatch_sync(dispatch_get_main_queue(), {self.label1.text = "\(sum)"})
                
                print("current value #1 = \(sum)")
                count += 1
                sleep(2)
            }
            
            print("first method completed with value \(sum)")
            
        }
        
        dispatch_async(concurrentQueue) { () -> Void in
            var count: Int = 0
            var sum: Int = 0
            while count <= 10 {
                let number: Int = Int(arc4random_uniform(10000) + 5)
                sum += number
                
                dispatch_sync(dispatch_get_main_queue(), {self.label2.text = "\(sum)"})
                
                print("current value #2 = \(sum)")
                count += 1
                sleep(2)
            }
            
            self.completed.hidden = false
            print("second method completed with value \(sum)")
            
        }
    }
}