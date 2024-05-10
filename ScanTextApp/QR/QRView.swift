//
//  QRView.swift
//  ScanTextApp
//
//  Created by Enrique Sarmiento on 4/5/24.
//

import SwiftUI
import CodeScanner

struct QRView: View {
   
   @State private var showScanner: Bool = false
   @State private var qrtext: String = "Scanear QR"
   
   func scan(result: Result<ScanResult, ScanError>){
      showScanner = false
      switch result {
      case .success(let result):
         let details = result.string.components(separatedBy: "")
         qrtext = details[0]
      case .failure(let error):
         print("DEBUG: fallo el scaneo", error.localizedDescription)
     
      }
   }
   
    var body: some View {
       NavigationView{
          VStack(alignment: .center){
             Button {
                showScanner = true
             } label: {
                Text("Scanear")
             }.sheet(isPresented: $showScanner) {
                CodeScannerView(codeTypes: [.qr], completion: scan)
             }
             
             Text(qrtext)

          }.navigationTitle("Scanear QR")
       }
    }
}
