//
//  ViewController.swift
//  Donaid
//
//  Created by Kamal Ezz on 2015-07-23.
//  Copyright (c) 2015 Kamal Ezz. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    var logInViewController: PFLogInViewController! = PFLogInViewController()
    var signUpViewController: PFSignUpViewController! = PFSignUpViewController()
  
    
    
    override func viewDidDisappear(animated: Bool) {
        
            PFUser.logOut()

        

        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
       if (PFUser.currentUser() == nil) {
        
        LogoutButton.hidden = true
        
        var logInViewController  = PFLogInViewController()
        var signUpViewController = PFSignUpViewController()
        
        logInViewController.delegate = self
        signUpViewController.delegate = self
        
        logInViewController.signUpController = signUpViewController
        
        self.presentViewController(logInViewController, animated: true, completion: nil)
        
        
        

        /*          WORKING!!!!!!!!!!!!!!!!!!!
        self.logInViewController.fields = PFLogInFields.UsernameAndPassword | PFLogInFields.LogInButton | PFLogInFields.SignUpButton | PFLogInFields.PasswordForgotten | PFLogInFields.DismissButton | PFLogInFields.Facebook | PFLogInFields.Twitter
        
                var logInLogoTitle = UILabel()
                logInLogoTitle.text = "Donaid"
            
                self.logInViewController.logInView!.logo = logInLogoTitle
            
                self.logInViewController.delegate=self

                var signUpLogoTitle = UILabel()
                signUpLogoTitle.text = "Donaid"
            
            self.signUpViewController.signUpView?.logo=signUpLogoTitle
            
            self.signUpViewController.delegate = self
            
            self.logInViewController.signUpController = self.signUpViewController
        }
       else  {//performSegueWithIdentifier("start", sender: self)
        LogoutButton.hidden = false

        println("Login Successfullll!")
       // self.dismissViewControllerAnimated(true, completion: nil)

        */////////////////////////
        
}
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

            //Parse Login
    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        
        if (username.isEmpty || password.isEmpty){
            let alert = UIAlertView()
            alert.title = "Alert"
            alert.message = "Please enter Username and Password."
            alert.addButtonWithTitle("Dismiss")
            alert.show()
            return false
        }else  {
            //self.dismissViewControllerAnimated(true, completion: nil)

            return true
            
        }
        
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
       // if (![[PFUser.objectForKey:@"emailVerified"] boolValue])
       // let ver = PFUser.objectForKey("emailVerified") as String
       // if (PFUser.objectForKey("emailVerified"))
            

        
         var currentUser = PFUser.currentUser()
        
        
       // var x = currentUser!.objectForKey("emailVerified") as! String
        let x = (currentUser!.valueForKey("emailVerified") as! Bool)
            if (x)
        {
            println(" VERIFIED")
            //self.dismissViewControllerAnimated(true, completion: nil)
            

        }
                
        else {    println("NOT VERIFIED !")
                let alert = UIAlertView()
                alert.title = "Email not verified"
                alert.message = "Please check your registered email to verify account."
                alert.addButtonWithTitle("Dismiss")
                alert.show()
                PFUser.logOut()
                let check = PFUser.currentUser()
                
        }
        self.dismissViewControllerAnimated(true, completion: nil)


        
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        let alert = UIAlertView()
        alert.title = "Alert"
        alert.message = "Failed to login."
        alert.addButtonWithTitle("Dismiss")
        alert.show()


        println("Failed to login bro!")
        

    }
            //Parse Sign Up
    

    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        println("User signed up!")

        //self.dismissViewControllerAnimated(true, completion: nil)
    //    logInViewController.logInView?.passwordField = 'nil'
        
        

 self.presentViewController(self.logInViewController, animated: true, completion: nil)
        
    }

    
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
        println("Failed to sign up.....")

    }
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
        println("User dismissed sign up.")
    }
    
    // Mark: Actions
    
    @IBAction func simpleAction (sender: AnyObject){
        var storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        var vc: UINavigationController = storyboard.instantiateViewControllerWithIdentifier("newViewController") as! UINavigationController
        
        if (PFUser.currentUser() == nil) {
            LogoutButton.hidden = true
            
            self.logInViewController.fields = PFLogInFields.UsernameAndPassword | PFLogInFields.LogInButton | PFLogInFields.SignUpButton | PFLogInFields.PasswordForgotten | PFLogInFields.DismissButton | PFLogInFields.Facebook | PFLogInFields.Twitter
            
            var logInLogoTitle = UILabel()
            logInLogoTitle.text = "Donaid"
            
            self.logInViewController.logInView!.logo = logInLogoTitle
            
            self.logInViewController.delegate=self
            
            var signUpLogoTitle = UILabel()
            signUpLogoTitle.text = "Donaid"
            
            self.signUpViewController.signUpView?.logo=signUpLogoTitle
            
            self.signUpViewController.delegate = self
            
            self.logInViewController.signUpController = self.signUpViewController

            self.presentViewController(self.logInViewController, animated: true, completion: nil)

          //  performSegueWithIdentifier("start", sender: self)
        }
        else
        {
            self.presentViewController(vc, animated: true, completion: nil)
            // performSegueWithIdentifier("start", sender: self)

        }

/*
    @IBAction func LogOut (sender: AnyObject){
        PFUser.logOut()
        
    }*/

        }
    @IBOutlet weak var LogoutButton: UIButton!
    

    @IBAction func LogoutButtonAction(sender: AnyObject) {
        let actionSheetController: UIAlertController = UIAlertController(title: "Logout Confirmation", message: "Are you sure you want to logout?", preferredStyle: .ActionSheet)
        let YesAction: UIAlertAction = UIAlertAction(title: "Yes", style: .Cancel) { action -> Void in
         //   PFLogInFields.UsernameAndPassword.rawValue=nil
            PFUser.logOut()
            
            //let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewControllerWithIdentifier("logInViewController") as! UIViewController
           // let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PFLogInViewController") as! UIViewController
   //var vc: UINavigationController = storyboard.instantiateViewControllerWithIdentifier("PFLoginViewController") as! UINavigationController
           // self.presentViewController(vc, animated: true, completion: nil)
            //
            //letStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ViewController") as! UIViewController
                self.dismissViewControllerAnimated(true, completion: nil)
            
            self.LogoutButton.hidden =  true
            
        
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(YesAction)
        //Create and add first option action
        let CancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Default) { action -> Void in
            //Code for launching the camera goes here
        }
        actionSheetController.addAction(CancelAction)
        //Create and add a second option action
        
        //We need to provide a popover sourceView when using it on iPad
        actionSheetController.popoverPresentationController?.sourceView = sender as! UIView;
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    
    }
    
    
}
