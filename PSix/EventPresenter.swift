//
//  EventPresenter.swift
//  PSix
//
//  Created by Turzion, Avihu on 4/27/15.
//  Copyright (c) 2015 PayPal. All rights reserved.
//

import Foundation

class EventPresenter {
    
    private static let formatter = NSDateFormatter()
    
    private static var eventCoverImages = [NSURL:UIImage]()
    
    private static func doesTextFitInWidth(text: String, width: CGFloat, font: UIFont) -> Bool {
        return width >= (text as NSString).sizeWithAttributes([NSFontAttributeName: font]).width
    }
    
    private let event: Event
    
    init(_ event: Event) {
        self.event = event
    }
    
    func getCoverImageAsync(callback: (UIImage) -> ()) {
        if let coverImageUrl = event.coverImageUrl {
            if let preloadedImage = EventPresenter.eventCoverImages[coverImageUrl] {
                callback(preloadedImage)
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    if let coverImageData = NSData(contentsOfURL: coverImageUrl) {
                        EventPresenter.eventCoverImages[coverImageUrl] = UIImage(data: coverImageData)
                        callback(EventPresenter.eventCoverImages[coverImageUrl]!)
                    }
                }
            }
        }
    }
    
    func getDayHourOfStartConsideringWidth(boxWidth: CGFloat, font: UIFont) -> String {
        if let startDate = event.startTime {
            EventPresenter.formatter.dateFormat = "EEEE, H:mm"
            let extendedText = EventPresenter.formatter.stringFromDate(startDate)
            if !EventPresenter.doesTextFitInWidth(extendedText, width: boxWidth, font: font) {
                EventPresenter.formatter.dateFormat = "E, H:mm"
                return EventPresenter.formatter.stringFromDate(startDate)
            }
            return extendedText as String
        }
        return ""
    }
    
    var attendanceFee: String {
        if event.amountPerAttendee > 0 {
            return "$\(event.amountPerAttendee)"
        }
        return ""
    }
    
    var paymentStatus: String {
        if event.attending.count > 0 {
            if let amountToCollect = event.totalMoneyToCollect {
                let amountCollected = event.moneyCollected ?? 0
                return "$\(amountCollected) / $\(amountToCollect)"
            }
        }
        return ""
    }
    
    var title: String {
        return event.name ?? ""
    }
    
    var location: String {
        return event.location ?? ""
    }
    
}