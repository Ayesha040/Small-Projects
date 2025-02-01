//
//  CreatePinMeetViewController.swift
//  FaheemAyesha-FinalProject
//
//  Created by Ayesha Faheem on 11/25/23.
//

import UIKit
import CoreLocation
import CoreData
import MapKit
import EventKit



protocol PinMeetDelegate: AnyObject {
    func didCreatePinMeet(_ pinmeet: SinglePinMeet)
}

class CreatePinMeetViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    let eventStore = EKEventStore()
    var savedEventID:String = ""
    var calendar = Calendar.current
    var selectedDateTimeComponents = DateComponents()
    var longitude: Double = 0.0
    var latitude: Double = 0.0
    weak var delegate: PinMeetDelegate?
    var singlePM = SinglePinMeet(friendName: "", title: "", longitude: 0.0, latitude: 0.0, isActive: true, dateTime: NSDate(), eventID: "", seconds: 0)
    let locationManager = CLLocationManager()

    @IBOutlet weak var friendsNameTF: UITextField!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    @IBOutlet weak var chooseLocationMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        dateTimePicker.timeZone = TimeZone.current
        chooseLocationMapView.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        chooseLocationMapView.addGestureRecognizer(tapGesture)
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        selectedDateTimeComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: sender.date)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius * 2.0,
            longitudinalMeters: regionRadius * 2.0
        )
        chooseLocationMapView.setRegion(coordinateRegion, animated: true)
        locationManager.stopUpdatingLocation()
    }
    
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            let locationInView = gestureRecognizer.location(in: chooseLocationMapView)
            let tappedCoordinate = chooseLocationMapView.convert(locationInView, toCoordinateFrom: chooseLocationMapView)
            chooseLocationMapView.removeAnnotations(chooseLocationMapView.annotations)
            let annotation = MKPointAnnotation()
            annotation.coordinate = tappedCoordinate
            chooseLocationMapView.addAnnotation(annotation)
            latitude = tappedCoordinate.latitude
            longitude = tappedCoordinate.longitude
        }
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return nil
    }
    
    
    @IBAction func savePinMeet(_ sender: Any) {
        singlePM.friendName = friendsNameTF.text
        singlePM.title = titleTF.text
        singlePM.longitude = longitude
        singlePM.latitude = latitude
        
        if let selectedDate = calendar.date(from: selectedDateTimeComponents) {
           singlePM.dateTime = selectedDate as NSDate
        }
        if let missingFieldsMessage = validateInputs() {
            displayAlert(message: missingFieldsMessage)
        } else {
            // Request access to calendar
            requestCalendarAccess { granted in
                DispatchQueue.main.async {
                    if granted {
                        // Create an event
                        let eventTitle = self.singlePM.title ?? ""
                        let startDate = self.singlePM.dateTime!
                        let calendar = Calendar.current
                        let endOfDay = calendar.startOfDay(for: startDate as Date).addingTimeInterval(24 * 60 * 60 - 1)
                        self.createEvent(title: eventTitle, startDate: startDate, endDate: endOfDay as NSDate) { eventID in
                            DispatchQueue.main.async {
                                if let eventID = eventID {
                                    self.singlePM.eventID = eventID
                                    
                                    let alert = UIAlertController(title: "Success", message: "Your PinMeet has been saved!", preferredStyle: .alert)
                                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                                    alert.addAction(okAction)
                                    self.present(alert, animated: true, completion: nil)
                                    self.setNotification()
                                    self.delegate?.didCreatePinMeet(self.singlePM)
                                } else {
                                    self.displayAlert(message: "Failed to save the PinMeet to the calendar.")
                                }
                            }
                        }
                    } else {
                        self.displayAlert(message: "Calendar access denied. PinMeet not saved to the calendar.")
                    }
                }
            }
        }
    }
    
    //calendar acess
    func requestCalendarAccess(completion: @escaping (Bool) -> Void) {
        let eventStore = EKEventStore()
        if EKEventStore.authorizationStatus(for: .event) != .authorized {
            eventStore.requestAccess(to: .event) { granted, error in
                completion(granted)
            }
        } else {
            completion(true)
        }
    }

    func setNotification() {
        guard let dateTime = singlePM.dateTime else {
            return
        }
        let calendar = Calendar.current
        let currentDate = Date()
        let timeDifference = calendar.dateComponents([.second], from: currentDate, to: dateTime as Date)
        if let secondsUntilEvent = timeDifference.second {
            var secondsUntilOneHourLeft = max(0, secondsUntilEvent - 3600)
            if secondsUntilOneHourLeft == 0 {
                secondsUntilOneHourLeft = 3600 - 1
            }
            let content = UNMutableNotificationContent()
            content.title = "One Hour Left"
            content.body = "PinMeet: \(singlePM.title!) with \(singlePM.friendName!)"
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(secondsUntilOneHourLeft), repeats: false)
            let request = UNNotificationRequest(identifier: "oneHourNotification", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error presenting notification: \(error.localizedDescription)")
                } else {
                    print("One-hour notification scheduled successfully.")
                }
            }
        } else {
        }
    }


    
    func createEvent(title: String, startDate: NSDate, endDate: NSDate, completion: @escaping (String?) -> Void) {
        let eventStore = EKEventStore()
        let event = EKEvent(eventStore: eventStore)
        event.title = title
        event.startDate = startDate as Date
        event.endDate = endDate as Date
        event.calendar = eventStore.defaultCalendarForNewEvents
        let hourBeforeAlarm = EKAlarm(relativeOffset: -86400)
        event.addAlarm(hourBeforeAlarm)
        do {
            try eventStore.save(event, span: .thisEvent)
            let savedEventID = event.eventIdentifier
            completion(savedEventID)
        } catch {
            print("Error: \(error)")
            completion(nil)
        }
        
    }
    
    
    func validateInputs() -> String? {
        var missingFields = [String]()
        if singlePM.friendName!.isEmpty {
            missingFields.append("Friend Name")
        }
        if singlePM.title!.isEmpty {
            missingFields.append("Title")
        }
        if singlePM.dateTime == nil {
            missingFields.append("Date and Time")
        }
        if singlePM.longitude == 0.0 || singlePM.latitude == 0.0 {
            missingFields.append("Location")
        }
        if !missingFields.isEmpty {
            return missingFields.joined(separator: ", ")
        }
        return nil
    }

    func displayAlert(message: String) {
        let alert = UIAlertController(title: "Missing Information", message: "Please provide \(message).", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }

    

}
