//
//  ScannerView.swift
//  ScanTextApp
//
//  Created by Enrique Sarmiento on 4/5/24.
//

import SwiftUI

struct ScannerView: View {
   @State private var showScanner: Bool = false
   @State private var texts: [ScanData] = []
   
   func makeScanner () -> Scanner {
      Scanner { textPage in
         if let outputText = textPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines){
            let newScanData = ScanData(content: outputText)
            texts.append(newScanData)
         }
         showScanner = false
      }
   }
   
    var body: some View {
       NavigationView{
          VStack{
             if texts.count > 0 {
                List{
                   ForEach(texts){ text in
                      NavigationLink(destination: ScrollView{
                         Text(text.content).multilineTextAlignment(.leading)
                            .padding()
                      }) {
                         Text(text.content).lineLimit(1)
                      }
                   }
                }
             }else{
                Text("No hay nada escaneado")
             }
          }.navigationTitle("Scannear documento")
             .toolbar{
                Button {
                   showScanner = true
                } label: {
                   Image(systemName: "doc.text.viewfinder")
                }.sheet(isPresented: $showScanner) {
                   makeScanner()
                }
                

             }
       }
    }
}
