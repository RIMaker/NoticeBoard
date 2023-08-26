//
//  NBColor.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 24.08.2023.
//

import UIKit

enum NBColor {
    
    //MARK: NBMain
    enum NBMain {
        static var backgroundColor: UIColor {
            UIColor.secondarySystemBackground
        }
    }
    
    //MARK: NavigationBar
    enum NavigationBar {
        static var textColor: UIColor {
            UIColor.secondarySystemBackground
        }
    }
    
    //MARK: NBActivityIndicator
    enum NBActivityIndicator {
        
        enum BackgroundColor {
            
            static var backColor: UIColor {
                UIColor.white.withAlphaComponent(0.5)
            }
            static var activityViewColor: UIColor {
                UIColor.white
            }
            
        }
        
        enum IndicatorColor {
            
            static var indicatorColor: UIColor {
                UIColor.lightGray
            }
            
        }
    }
    
    //MARK: NBViewControllerPlaceholder
    enum NBViewControllerPlaceholder {
        
        enum Button {
            static var textColor: UIColor {
                UIColor.black
            }
            
            static var backgroundColor: UIColor {
                UIColor.black.withAlphaComponent(0.2)
            }
        }
        
        static var textColor: UIColor {
            UIColor.black
        }
        
        static var backgroundColor: UIColor {
            UIColor.white
        }
        
        
    }
    
    
}
