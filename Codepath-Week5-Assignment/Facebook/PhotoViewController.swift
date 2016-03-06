//
//  PhotoViewController.swift
//  Facebook
//
//  Created by Jeremie Lim on 3/4/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {
    
    var image: UIImage!
    var offsetScroll: CGFloat?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var doneButton: UIImageView!
    @IBOutlet weak var photoActions: UIImageView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 320, height: 569)

        
        imageView.image = image
        
        if image.size.width == 320 {
            imageView.contentMode = .ScaleAspectFill
        } else {
            imageView.contentMode = .ScaleAspectFit
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
            
        if scrollView.contentOffset.y < -30 {
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

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
