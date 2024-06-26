//
//  TextRecognizer.swift
//  ScanTextApp
//
//  Created by Enrique Sarmiento on 4/5/24.
//

import Foundation
import Vision
import VisionKit

class TextRecognizer {
   
   let cameraScan: VNDocumentCameraScan
   
   init(cameraScan: VNDocumentCameraScan){
      self.cameraScan = cameraScan
   }
   
   func recognizerText(completionHandler: @escaping ([String]) -> Void){
      DispatchQueue.main.async {
         
         let image = (0..<self.cameraScan.pageCount).compactMap {
            self.cameraScan.imageOfPage(at:$0).cgImage
         }
         
         let imageRequest = image.map {
            (image: $0, request: VNRecognizeTextRequest())
         }
         
         let textPage = imageRequest.map { image, request -> String in
            let handler = VNImageRequestHandler(cgImage: image, options: [:])
            
            do {
               try handler.perform([request])
               guard let observations = request.results else { return ""}
               
               return observations.compactMap({$0.topCandidates(1).first?.string}).joined(separator: "\n")
               
            }catch let error as NSError {
               print("DEBUG: error on textpage do catch", error.localizedDescription)
               return ""
            }
            
         }
         
         completionHandler(textPage)
      }
   }
}
