//
//  NotificationViewController.swift
//  NotificationViewController
//
//  Created by Krunal Sutariya on 09/05/22.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
        let attachments = notification.request.content.attachments
        for attachment in attachments {
            if attachment.identifier == "picture" {
                guard let data = try? Data(contentsOf: attachment.url) else {
                    return
                }
                imgView.image = UIImage(data: data)
            }
        }
    }

}
