//
//  PinMeetsViewController.swift
//  FaheemAyesha-FinalProject
//
//  Created by Ayesha Faheem on 11/26/23.
//

import UIKit
import CoreData
import MapKit
import EventKit



class PinMeetsViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource, PinMeetDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let textCellIdentifier = "TextCell"
    let eventStore = EKEventStore()
    var savedEventID = ""
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchPinMeets()
        startTimer()
    }
    
    func didCreatePinMeet(_ pinmeet: SinglePinMeet) {
        let newPinMeet = PinMeet(context: context)
        newPinMeet.friendName = pinmeet.friendName
        newPinMeet.title = pinmeet.title
        newPinMeet.dateTime = pinmeet.dateTime as Date?
        newPinMeet.latitude = pinmeet.latitude!
        newPinMeet.longitude = pinmeet.longitude!
        newPinMeet.eventID = pinmeet.eventID
        appDelegate.saveContext()
        fetchPinMeets()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(updateTimeRemaining), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    func retrievePinMeets() -> [NSManagedObject] {
        let fetchRequest: NSFetchRequest<PinMeet> = PinMeet.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching data: \(error)")
            return []
        }
    }
    
    func fetchPinMeets() {
        if let pinMeets = retrievePinMeets() as? [PinMeet] {
            pinMeetsArray = pinMeets
            tableView.reloadData()
        }
    }
    
    @objc func updateTimeRemaining() {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pinMeetsArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        cell.layer.cornerRadius = 10
        let pinmeet = pinMeetsArray[indexPath.row]

        cell.textLabel?.text = pinmeet.value(forKey: "title") as? String
        cell.textLabel?.font = UIFont(name: "ChalkboardSE-Bold", size: 17)
        cell.detailTextLabel?.numberOfLines = 4
        
        if let friendName = pinmeet.value(forKey: "friendName") as? String,
           let dateTime = pinmeet.value(forKey: "dateTime") as? Date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd h:mm a"
            let formattedDate = dateFormatter.string(from: dateTime)
            let calendar = Calendar.current
            let currentDate = Date()
            let timeDifference = calendar.dateComponents([.day, .hour, .minute], from: currentDate, to: dateTime)
            var timeRemaining = "Time Remaining: "
            
            if let days = timeDifference.day, let hours = timeDifference.hour, let minutes = timeDifference.minute {
                if days == 0 && hours == 0 && minutes <= 0 { //remove pinMeet when time has passed
                    if let eventID = pinmeet.eventID {
                        deleteEvent(eventIdentifier: eventID)
                    }
                    context.delete(pinmeet)
                    pinMeetsArray.remove(at: indexPath.row)
                    tableView.reloadData()
                    do {
                        try context.save()
                    } catch {
                        print("Error saving context after deletion: \(error)")
                    }
                    return cell
                } else {
                    if days > 0 {
                        timeRemaining += "\(days) Day\(days != 1 ? "s" : ""), "
                    }
                    timeRemaining += "\(hours) hr\(hours != 1 ? "s" : ""), \(minutes) min\(minutes != 1 ? "s" : "")"
                }
            }
            cell.detailTextLabel?.text = "\(friendName)\n\(formattedDate)\n\(timeRemaining)"
            cell.detailTextLabel?.font = UIFont(name: "ChalkboardSE-Regular", size: 13)
        } else {
            cell.detailTextLabel?.text = "Unknown"
        }
        return cell
    }

    //selecting cell opens directions in apple Maps
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pinmeet = pinMeetsArray[indexPath.row]
        let coordinate = CLLocationCoordinate2D(latitude: pinmeet.latitude, longitude: pinmeet.longitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        mapItem.name = pinmeet.title
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMaps(launchOptions: launchOptions)
    }
    
    //swiping on a cell deletes it
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let pinMeetToDelete = pinMeetsArray[indexPath.row]
            if let eventID = pinMeetToDelete.eventID {
                deleteEvent(eventIdentifier: eventID)
            }
            context.delete(pinMeetToDelete)
            pinMeetsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)

            do {
                try context.save()
            } catch {
                print("Error saving context after deletion: \(error)")
            }
        }
    }

    //deleting pinmeet from event
    func deleteEvent(eventIdentifier: String) {
        if let eventToRemove = eventStore.event(withIdentifier: eventIdentifier) {
            do {
                try eventStore.remove(eventToRemove, span: .thisEvent)
                print("Event removed successfully")
            } catch {
                print("Error removing event: \(error)")
            }
        } else {
            print("Event not found")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createPMSegue" {
            if let createPinMeetVC = segue.destination as? CreatePinMeetViewController {
                createPinMeetVC.delegate = self
            }
        }
    }
}





