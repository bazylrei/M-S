import UIKit

protocol InformationFormatter {
  func formatInformation(_ information: [ProductInformation]) -> String
}

struct InformationFormatterImplementation: InformationFormatter {
  func formatInformation(_ information: [ProductInformation]) -> String {
    return information.map { "\($0.sectionTitle)\n\($0.sectionText)" }.joined(separator: "\n\n")
  }
}

