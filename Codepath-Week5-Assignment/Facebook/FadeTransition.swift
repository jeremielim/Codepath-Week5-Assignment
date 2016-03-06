//
//  FadeTransition.swift
//  transitionDemo
//
//  Created by Timothy Lee on 11/4/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class FadeTransition: BaseTransition {
    var movingImageView: UIImageView!
    var darkView: UIView!
    var photoViewController: PhotoViewController!
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {

        photoViewController = toViewController as! PhotoViewController
        let feedViewController = fromViewController as! NewsFeedViewController
        
        // Hide zoomed photo on destination view
        photoViewController.imageView.alpha = 0
        
        // Hide the original image on the feed view controller
        feedViewController.selectedImageView.alpha = 0
        
        print(feedViewController.selectedImageView.image?.size.width)
        
        // Create moving image view
        movingImageView = UIImageView()
        movingImageView.frame = feedViewController.selectedImageView.frame
        movingImageView.image = feedViewController.selectedImageView.image
        movingImageView.clipsToBounds = feedViewController.selectedImageView.clipsToBounds
        

        if feedViewController.selectedImageView.image?.size.width == 320 {
            movingImageView.contentMode = .ScaleAspectFill
        } else {
            movingImageView.contentMode = .ScaleAspectFit
        }
        
        
        
        containerView.addSubview(movingImageView)
        
        // Create dark overlay
        darkView = UIView()
        darkView.frame = photoViewController.view.frame
        darkView.backgroundColor = UIColor.blackColor()
        fromViewController.view.addSubview(darkView)
        
        // Hide dark view
        darkView.alpha = 0
        
        feedViewController.selectedImageView.alpha = 0
        
        UIView.animateWithDuration(duration, animations: {
            // Change width and height of zoomed in image
            self.movingImageView.frame = self.photoViewController.imageView.frame
            
            self.darkView.alpha = 0.5
            
        }) { (finished: Bool) -> Void in
            // Hide moving image
            self.movingImageView.removeFromSuperview()
            
            // Show zoomed photo
            self.photoViewController.imageView.alpha = 1
            self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        let feedViewController = toViewController as! NewsFeedViewController
        
        
        self.photoViewController.imageView.alpha = 0
        
        fromViewController.view.alpha = 1
        UIView.animateWithDuration(duration, animations: {
            self.movingImageView.frame = feedViewController.selectedImageView.frame
            self.darkView.alpha = 0
            
        }) { (finished: Bool) -> Void in
            feedViewController.selectedImageView.alpha = 1
            self.movingImageView.removeFromSuperview()
            self.darkView.removeFromSuperview()
            self.finish()
        }
    }
}
