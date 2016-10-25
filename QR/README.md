#QR framework
QR framework provides an easy way to scan and generate QR barcodes.

#How to integrate into a project:
1. Drag and drop QR.framework into the project.
2. Include QR.framework into the project target’s embedded binaries.
3. Import QR into the Swift files as necessary.

#How to QR codes:
1. In your storyboard, subclass a new ViewController as QRScannerViewController and set QR as its module.
2. In prepareForSegue method, QRScannerViewController's delegate
3. Conform to QRScannerViewControllerDelegate protocol to get call backs when a QR code is read or when there is an error. Implement the following methods:
```sh
func didScanBarcodeWith(resultString: String)

func didEncounterError(error: NSError)
```
#How to generate QR codes
Use 

```sh
func createQRFromString(_ str: String, size: CGSize) -> UIImage? 
```

#Requirements:
* iOS 10.0+
* Swift 3.0
* Xcode 8.0
