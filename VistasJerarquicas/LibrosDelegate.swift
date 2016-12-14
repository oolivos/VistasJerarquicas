//
//  LibrosDelegate.swift
//  VistasJerarquicas
//
//  Created by Oscar Javier Olivos on 13/12/16.
//  Copyright © 2016 Oscar Javier Olivos. All rights reserved.
//

import UIKit

@objc protocol LibrosDelegate: class {
    @objc optional func addLibro(titulo: String, isbn : String )
    
    
}
