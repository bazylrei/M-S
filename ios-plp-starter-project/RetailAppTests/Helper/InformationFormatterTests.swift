import XCTest
@testable import RetailApp

class InformationFormatterTests: XCTestCase {

  func test_formatInformation_with1Information_hasCorrectOutput() {
    let informationFormatterSUT = InformationFormatterImplementation()
    let productInformation = [ProductInformation(sectionTitle: "title", sectionText: "text")]
    let output = informationFormatterSUT.formatInformation(productInformation)
    XCTAssertEqual(output, "title\ntext")
  }

  func test_formatInformation_with3Information_hasCorrectOutput() {
    let informationFormatterSUT = InformationFormatterImplementation()
    let productInformation = [ProductInformation(sectionTitle: "title", sectionText: "text"), ProductInformation(sectionTitle: "title1", sectionText: ""), ProductInformation(sectionTitle: "", sectionText: "text2")]
    let output = informationFormatterSUT.formatInformation(productInformation)
    XCTAssertEqual(output, "title\ntext\n\ntitle1\n\n\n\ntext2")
  }
}


