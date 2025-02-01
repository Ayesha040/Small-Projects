//
//  HomeViewController.swift
//  FaheemAyesha-FinalProject
//
//  Created by Ayesha Faheem on 11/24/23.
//

import UIKit
import CoreData
import FirebaseAuth
import MapKit
import CoreLocation
import EventKit


let defaults = UserDefaults.standard
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext
var pinMeetsArray:[PinMeet] = []

class HomeViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, PinMeetDelegate {
   
    @IBOutlet weak var viewPinMeets: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager = CLLocationManager()


    override func viewDidLoad() {
        super.viewDidLoad()
        //profile image
        setProfileImageForSettingsButton()
        let defaultImage = UIImage(named: "defaultpfp1")
        settingsButton.setImage(defaultImage, for: .normal)
        //map view
        mapView.delegate = self
        mapView.showsUserLocation = true
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        createExamplePinMeets()
        fetchPinMeets()
    }
    

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
            let region = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: 3000.0,
            longitudinalMeters: 3000.0
        )
        mapView.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
    }
    
    @IBAction func zoomSelfLocation(_ sender: Any) {
        let userLocation = mapView.userLocation
        let center = userLocation.coordinate
        let NS = 3000.0
        let EW = 3000.0
        let region = MKCoordinateRegion(
            center: center,
            latitudinalMeters: NS,
            longitudinalMeters: EW
        )
        mapView.setRegion(region, animated: true)
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
            mapView.removeAnnotations(mapView.annotations)
            for pinMeet in pinMeetsArray {
                addPinToMapView(pinMeet)
            }
        }
    }

    
    func didCreatePinMeet(_ pinmeet: SinglePinMeet) {
        let newPinMeet = PinMeet(context: context)
        newPinMeet.friendName = pinmeet.friendName
        newPinMeet.title = pinmeet.title
        newPinMeet.latitude = pinmeet.latitude!
        newPinMeet.longitude = pinmeet.longitude!
        newPinMeet.eventID = pinmeet.eventID
        appDelegate.saveContext()
        fetchPinMeets()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setProfileImageForSettingsButton()
        fetchPinMeets()
    }
        
    func addPinToMapView(_ pinmeet: PinMeet) {
        let friendName = pinmeet.value(forKey: "friendName") as? String
        let latitude = (pinmeet.value(forKey: "latitude") as? Double)!
        let longitude = (pinmeet.value(forKey: "longitude") as? Double)!
        let annotation = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude:longitude)
        annotation.coordinate = centerCoordinate
        annotation.title = friendName
        mapView.addAnnotation(annotation)
        
    }

    @IBAction func viewPinsAlert(_ sender: Any) {
        let alert = UIAlertController(
                title: "Select PinMeet",
                message: "Choose a PinMeet to view",
                preferredStyle: .actionSheet)
        for pinMeetObj in pinMeetsArray {
            guard let title = pinMeetObj.value(forKey: "title") as? String else {
                continue
            }
            let action = UIAlertAction(title: title, style: .default) { [weak self] _ in
                self?.zoomToPin(pinMeetObj)
            }
            alert.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = viewPinMeets
            popoverController.sourceRect = viewPinMeets.bounds
        }
        present(alert, animated: true, completion: nil)
    }
    
    func zoomToPin(_ pinMeetObj: NSManagedObject) {
        guard
            let latitude = pinMeetObj.value(forKey: "latitude") as? Double,
            let longitude = pinMeetObj.value(forKey: "longitude") as? Double
        else {
            return
        }
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let regionRadius: CLLocationDistance = 500
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(region, animated: true)
    }
    
    
    //profile image
    func setProfileImageForSettingsButton() {
        if let imageData = UserDefaults.standard.data(forKey: "profileImage") {
            if let profileImage = UIImage(data: imageData) {
                let scaledImage = scaleImage(image: profileImage, to: CGSize(width: 50, height: 50))
                settingsButton.setImage(scaledImage, for: .normal)
            }
        }
    }
    
    func scaleImage(image: UIImage, to newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? image
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        settingsButton.layer.cornerRadius = settingsButton.bounds.width / 2
        settingsButton.clipsToBounds = true
    }
    
    
    func createExamplePinMeets() {
        let eventStore = EKEventStore()
        let fetchRequest: NSFetchRequest<PinMeet> = PinMeet.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "friendName IN %@", ["Alice", "Bob"])
        do {
            let results = try context.fetch(fetchRequest)
            if results.isEmpty {
                let calendar = Calendar.current
    
                // Create PinMeet for Alice
                let alicePinMeet = PinMeet(context: context)
                alicePinMeet.friendName = "Alice"
                alicePinMeet.title = "New Coffee Shop"
                alicePinMeet.longitude = -122.4194
                alicePinMeet.latitude = 37.7749
                alicePinMeet.isActive = false
                var dateComponents = DateComponents(year: 2023, month: 12, day: 30, hour: 18, minute: 0)
                if let specificDate = calendar.date(from: dateComponents) {
                    alicePinMeet.dateTime = specificDate
                    createEvent(for: alicePinMeet, in: eventStore)
                }
                
                // Create PinMeet for Bob
                let bobPinMeet = PinMeet(context: context)
                bobPinMeet.friendName = "Bob"
                bobPinMeet.title = "Study Session"
                bobPinMeet.longitude = -97.7431
                bobPinMeet.latitude = 30.2672
                bobPinMeet.isActive = false
                dateComponents.day = 26
                dateComponents.hour = 19
                if let specificDateForBob = calendar.date(from: dateComponents) {
                    bobPinMeet.dateTime = specificDateForBob
                    createEvent(for: bobPinMeet, in: eventStore)
                }
                appDelegate.saveContext()
                addPinToMapView(alicePinMeet)
                addPinToMapView(bobPinMeet)
            }
        } catch {
            print("Error fetching data: \(error)")
        }
    }

    //create calender event for the examples
    func createEvent(for pinMeet: PinMeet, in eventStore: EKEventStore) {
        let event = EKEvent(eventStore: eventStore)
        event.title = pinMeet.title
        event.startDate = pinMeet.dateTime
        event.endDate = pinMeet.dateTime?.addingTimeInterval(3600)
        event.calendar = eventStore.defaultCalendarForNewEvents
        let dayBeforeAlarm = EKAlarm(relativeOffset: -86400)
        event.addAlarm(dayBeforeAlarm)
        do {
            try eventStore.save(event, span: .thisEvent)
            print("Event created for \(pinMeet.friendName!)")
        } catch {
            print("Error creating event: \(error)")
        }
    }


}
