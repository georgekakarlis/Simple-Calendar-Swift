//
//  ViewController.swift
//  Calendar
//
//  
//
import EventKitUI
import EventKit
import UIKit

class ViewController: UIViewController , EKEventViewDelegate {
    
    let store = EKEventStore()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
 @objc   func didTapAdd() {
    
    store.requestAccess(to: .event) { [weak self] success , error in
        if success, error == nil {
            DispatchQueue.main.async {
                guard let store = self?.store else {return}
                
                let newEvent = EKEvent(eventStore: store)
                newEvent.title = "Youtube events video"
                newEvent.startDate = Date()
                newEvent.endDate = Date()
                
                let otherVC = EKEventEditViewController()
                otherVC.eventStore = store
                otherVC.event = newEvent
                self?.present(otherVC, animated: true, completion: nil)
                
                let vc = EKEventViewController()
                vc.event = newEvent
                 vc.delegate = self
                let navVC = UINavigationController(rootViewController: vc)
                self?.present(navVC, animated: true)
            }
        }
    }
    
        
    }
    func eventViewController(_ controller : EKEventViewController, didCompleteWith
                                action : EKEventViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
}

