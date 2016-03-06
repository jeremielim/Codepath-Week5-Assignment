//
//  PhotoViewController.swift
//  Facebook
//
//  Created by Jeremie Lim on 3/4/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var doneButton: UIImageView!
    @IBOutlet weak var photoActions: UIImageView!
    
    var image: UIImage!
    var offsetScroll: CGFloat?
    var imageTag: Int!
    var imageArray: [UIImageView]!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageArray = [
            imageView,
            imageView2,
            imageView3,
            imageView4,
            imageView5,
        ]
        
        // Resize scroll view
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 1600, height: 568)

        // Set the selected image on the correct view and position them for scrolling
        
        imageArray[imageTag].image = image

        scrollView.contentOffset.x = 320 * CGFloat(imageTag)
        
        // Setup image ratio for display
        if image.size.width == 320 {
            imageArray[imageTag].contentMode = .ScaleAspectFill
        } else {
            imageArray[imageTag].contentMode = .ScaleAspectFit
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapDone(sender: UITapGestureRecognizer) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // This method is called as the user scrolls
        let movingAlpha = convertValue(1, r1Min: scrollView.contentOffset.y, r1Max: 3.0, r2Min: 1, r2Max: 0)
        
        // Check if content is scrolling down to fade out done and actions
        if scrollView.contentOffset.y < 0 {
            view.backgroundColor = UIColor(white: 0, alpha: movingAlpha/2)
            
            doneButton.alpha = movingAlpha
            photoActions.alpha = movingAlpha
        
        }
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView,
        willDecelerate decelerate: Bool) {
        // This method is called right as the user lifts their finger
        
            
        // Close image if scrolling over a 100
        if scrollView.contentOffset.y < -100 {
            dismissViewControllerAnimated(true, completion: nil)
            
            offsetScroll = scrollView.contentOffset.y
            
            view.backgroundColor = UIColor.clearColor()
        }
            
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // This method is called when the scrollview finally stops scrolling.
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        doneButton.alpha = 1
        photoActions.alpha = 1
    }
    
    // Make view scrollable
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView {
        return imageView
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
