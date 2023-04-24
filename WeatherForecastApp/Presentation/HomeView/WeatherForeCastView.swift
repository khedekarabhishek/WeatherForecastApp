//
//  SampleSwiftUIView.swift
//  WeatherForecastApp
//
//  Created by Abhishek Khedekar on 22/04/23.
//

import SwiftUI

struct WeatherForeCastViewUIModel: Codable {
    let urlString: String
    let description: String
    let mainModel: MainModel

    init(urlString: String,
         description: String,
         mainModel: MainModel) {
        self.urlString = urlString
        self.description = description
        self.mainModel = mainModel
    }
}

struct WeatherForeCastView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var textFieldText = ""
    @FocusState var isInputActive: Bool

    var body: some View {
        VStack(alignment: .center) {
            TextField("Type city name here...",
                      text: $textFieldText)
                .textFieldStyle(.roundedBorder)
                .focused($isInputActive)
                .submitLabel(.done)
                .disableAutocorrection(true)
                .padding(.top, 30)
                .onSubmit({
                    viewModel.getForeCastData(cityName: textFieldText)
                  print("textfield value is: \(textFieldText)")
                })
            if let uiModel = viewModel.weatherForeCastViewUIModel {
                ScrollView(.vertical) {
                    VStack(alignment: .center, spacing: 16) {
                        VStack(alignment: .center, spacing: 4) {
                            AsyncImage(
                                url: URL(string: uiModel.urlString),
                                content: { image in
                                    image.resizable()
                                },
                                placeholder: {
                                    ProgressView()
                                }
                            )
                                .frame(width: 50, height: 50)
                            Text(uiModel.description)
                        }
                        VStack(alignment: .leading, spacing: 20) {
                            WeatherDataRowView(key: "Temperature", value: String(uiModel.mainModel.temp))
                            WeatherDataRowView(key: "Feels Like", value: String(uiModel.mainModel.feelsLike))
                            WeatherDataRowView(key: "Min Temp", value: String(uiModel.mainModel.tempMin))
                            WeatherDataRowView(key: "Max Temp", value: String(uiModel.mainModel.tempMax))
                            WeatherDataRowView(key: "Pressure", value: String(uiModel.mainModel.pressure))
                            WeatherDataRowView(key: "Humidity", value: String(uiModel.mainModel.humidity))
                        }
                    }
                }
            } else {
                Spacer()
                Text("No data to display")
                Spacer()
            }
        }
        .onAppear(perform: {
            viewModel.getModelFromDefaults()
        })
        .padding(.horizontal, 16)
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .background(.blue)
    }
    
}

//struct SampleSwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherForeCastView(viewModel: HomeViewModel())
//    }
//}

private struct WeatherDataRowView: View {
    let key: String
    let value: String

    var body: some View {
        HStack {
            Text(key)
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
            Text(value)
                .font(.subheadline)
                .foregroundColor(.white)
        }
    }
}
