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
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {

        let photoViewController = toViewController as! PhotoViewController
        let feedViewController = fromViewController as! NewsFeedViewController
        
        toViewController.view.alpha = 0
        
        // Clear photo background
        photoViewController.view.backgroundColor = UIColor.clearColor()
        
        // Hide zoomed photo on destination view
        photoViewController.imageView.alpha = 0
        
        // Hide the original image on the feed view controller
        feedViewController.selectedImageView.alpha = 0
        
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
        darkView.backgroundColor = UIColor.blackColor()
        darkView.frame = photoViewController.view.frame
        fromViewController.view.addSubview(darkView)
        
        // Hide dark view
        darkView.alpha = 0
        
        feedViewController.selectedImageView.alpha = 0
        
        UIView.animateWithDuration(duration, animations: {
            // Change width and height of zoomed in image
            self.movingImageView.frame = photoViewController.imageView.frame
            
            self.darkView.alpha = 1
            
            toViewController.view.alpha = 1
            
        }) { (finished: Bool) -> Void in
            //
            photoViewController.view.backgroundColor = UIColor.blackColor()
            
            // Remove dark view
            self.darkView.removeFromSuperview()
            
            // Hide moving image
            self.movingImageView.removeFromSuperview()
            
            // Show zoomed photo
            photoViewController.imageView.alpha = 1
            self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        let photoViewController = fromViewController as! PhotoViewController
        let feedViewController = toViewController as! NewsFeedViewController
        
        fromViewController.view.alpha = 1
        
        // Clear photo background
        photoViewController.view.backgroundColor = UIColor.clearColor()
        
        // Hide the current photo
        photoViewController.imageView.alpha = 0
        
        // Create moving image view
        movingImageView = UIImageView()
        movingImageView.frame = photoViewController.imageView.frame
        movingImageView.image = photoViewController.imageView.image
        movingImageView.clipsToBounds = photoViewController.imageView.clipsToBounds
        
        
        
        if feedViewController.selectedImageView.image?.size.width == 320 {
            movingImageView.contentMode = .ScaleAspectFill
        } else {
            movingImageView.contentMode = .ScaleAspectFit
        }
        
        containerView.addSubview(movingImageView)
        
        // Create dark overlay
        darkView = UIView()
        darkView.frame = photoViewController.view.frame
        darkView.backgroundColor = UIColor.blueColor()
        fromViewController.view.addSubview(darkView)
        
        
        fromViewController.view.alpha = 1
        
        if photoViewController.offsetScroll == nil {
            print("nil")
            self.darkView.alpha = 1
        } else {
            print(photoViewController.offsetScroll)
            movingImageView.transform = CGAffineTransformMakeTranslation(0, abs(photoViewController.offsetScroll!))
            self.darkView.alpha = 0
        }
        
        
        UIView.animateWithDuration(duration, animations: {
            fromViewController.view.alpha = 0
            
            self.darkView.alpha = 0
            
            self.movingImageView.frame = feedViewController.selectedImageView.frame
            self.darkView.alpha = 0
            
        }) { (finished: Bool) -> Void in
            self.darkView.removeFromSuperview()
            
            // Hide moving image
            self.movingImageView.removeFromSuperview()
            
            // Show original image
            feedViewController.selectedImageView.alpha = 1
            
            
            self.darkView.removeFromSuperview()
            self.finish()
        }
    }
}
