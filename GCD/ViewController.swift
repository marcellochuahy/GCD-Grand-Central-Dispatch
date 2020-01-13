//
//  ViewController.swift
//  GCD - Grand Central Dispatch (Threads)
//
//  Created by Marcello Chuahy on 12/01/20.
//  Copyright © 2020 Applause Codes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        printLoop(icone: "🔴", threadName: "Teste simples", multiplicador: 1)
        
        // thread_maneiraERRADA()
        // threadsSeriaisCom1Processador()
        // threadsConcorrenciaisComVariosProcessadores()
        // threadsComQualityOfService()
        
    }

    // MARK: - Thread methods
    
    func thread_maneiraERRADA() {
        
        // MUITO ERRADO!
        // ❌ Nunca chamar na thread principal!
        
        let thread_main = DispatchQueue.main
        thread_main.sync {
            printLoop(icone: "🔴", threadName: "Thread Serial 1 (síncrona)", multiplicador: 1)
        }
    }

    func threadsSeriaisCom1Processador() {
        
        let thread_1 = DispatchQueue(label: "br.com.codes.applause.thread_1")
        let thread_2 = DispatchQueue(label: "br.com.codes.applause.thread_2")
        
        // Thread 1
        thread_1.sync {
            printLoop(icone: "🔴", threadName: "Thread Serial 1 (síncrona)", multiplicador: 1)
        }
        
        // Thread 2
        thread_2.async {
            self.printLoop(icone: "🟢", threadName: "Thread Serial 2 (assíncrona)", multiplicador: 1)
        }
        
        // Main Thread
        printLoop(icone: "🔵", threadName: "Main Thread (Serial)", multiplicador: 1)
    }
    
    func threadsConcorrenciaisComVariosProcessadores() {
        
        let thread_1 = DispatchQueue(label: "br.com.codes.applause.thread_1", attributes: .concurrent)
        let thread_2 = DispatchQueue(label: "br.com.codes.applause.thread_2", attributes: .concurrent)
        
        // Thread 1
        thread_1.sync {
            printLoop(icone: "🔴", threadName: "Thread 1 (síncrona)", multiplicador: 1)
        }
        
        // Thread 2A
        thread_2.async {
            self.printLoop(icone: "🟢", threadName: "Thread 2A (assíncrona)", multiplicador: 1)
        }
        
        // Thread 2B
        thread_2.async {
            self.printLoop(icone: "🟢", threadName: "Thread 2B (assíncrona)", multiplicador: 1)
        }
        
        // Thread 2C
        thread_2.async {
            self.printLoop(icone: "🟢", threadName: "Thread 2C (assíncrona)", multiplicador: 1)
        }
        
        // Main Thread
        printLoop(icone: "🔵", threadName: "Main Thread", multiplicador: 1)
    }
    
    func threadsComQualityOfService() {
        
        /**
         
         QoS: Quality of Service
         Execution priority to tasks:
         
         User Interactive
         Work that happens on the main thread, such as animations or drawing operations.
         
         User Initiated
         Work that the user kicks off and should yield immediate results.
         This work must be completed for the user to continue.
         
         Utility
         Work that may take a bit and doesn’t need to finish right away.
         Analogous to progress bars and importing data.
         
         Background
         This work isn’t visible to the user.
         Backups, syncs, indexing, etc.
         
         */
        
        // highest priority
        //
        //  |
        //  |
        //  v
        //
        // lowest priority
        
        let thread_1 = DispatchQueue(label: "br.com.codes.applause.thread_1", qos: .userInteractive, attributes: .concurrent)
        let thread_2 = DispatchQueue(label: "br.com.codes.applause.thread_2", qos: .userInitiated, attributes: .concurrent)
        let thread_3 = DispatchQueue(label: "br.com.codes.applause.thread_3", qos: .utility, attributes: .concurrent)
        let thread_4 = DispatchQueue(label: "br.com.codes.applause.thread_4", qos: .background, attributes: .concurrent)
 
        thread_4.async { self.printLoop(icone: "4️⃣🟢", threadName: "QoS: background", multiplicador: 1) }
        thread_3.async { self.printLoop(icone: "3️⃣🟡", threadName: "QoS: utility", multiplicador: 1) }
        thread_2.async { self.printLoop(icone: "2️⃣🟠", threadName: "QoS: userInitiated", multiplicador: 1) }
        thread_1.async { self.printLoop(icone: "1️⃣🔴", threadName: "QoS: userInteractive", multiplicador: 1) }

    }
    
    // MARK: - Handler methods
    
    func printLoop(icone: String, threadName: String, multiplicador: Int) {
        for i in 1...10 {
            print(icone + " \(threadName) -> \(i)")
        }
    }

}

