//
//  ContentView.swift
//  ScanTextApp
//
//  Created by Enrique Sarmiento on 4/5/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
       TabView{
          ScannerView().tabItem {
             Label("Scan Text", systemImage: "doc.text.viewfinder")
          }
          QRView().tabItem {
             Label("QR Code", systemImage: "qrcode.viewfinder")
          }
       }
    }
}
