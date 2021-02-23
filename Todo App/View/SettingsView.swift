//
//  SettingsView.swift
//  Todo App
//
//  Created by Dandy Ferdiansyah on 22/02/21.
//

import SwiftUI

struct SettingsView: View {
  
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var iconSettings: IconNames
  
  var body: some View {
    NavigationView{
      VStack(alignment: .center, spacing: 8){
        
        Form{
          
          Section(header: Text("Choose the app icon")){
            Picker(selection: $iconSettings.currentIndex, label:
              HStack{
                ZStack{
                  RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .strokeBorder(Color.primary, lineWidth: 2)
                  
                  Image(systemName: "paintbrush")
                    .font(.system(size: 28, weight: .bold, design: .default))
                    .foregroundColor(Color.primary)
                }
                .frame(width: 44, height: 44)
                
                Text("App Icons".uppercased())
                  .fontWeight(.bold)
                  .foregroundColor(Color.primary)
              }){
              ForEach(0..<iconSettings.iconNames.count){ index in
                HStack{
                  Image(uiImage: UIImage(named: self.iconSettings.iconNames[index] ?? "Blue") ?? UIImage())
                    .resizable()
                    .renderingMode(.original)
                    .scaledToFit()
                    .frame(width: 44, height: 44)
                    .cornerRadius(8)
                  
                  Spacer().frame(width: 8)
                  
                  Text(self.iconSettings.iconNames[index] ?? "Blue")
                    .frame(alignment: .leading)
                }
                .padding(3)
              }
            }
            .onReceive([self.iconSettings.currentIndex].publisher.first()) { (value) in
              let index = self.iconSettings.iconNames.firstIndex(of: UIApplication.shared.alternateIconName) ?? 0
              
              if index != value{
                UIApplication.shared.setAlternateIconName(self.iconSettings.iconNames[value]){ error in
                  if let error = error {
                    print(error.localizedDescription)
                  } else{
                    print("Success! you have changed the app icon")
                  }
                }
              }
            }
          }
          .padding(.vertical, 3)
          
          Section(header: Text("Follow us on social media")){
            FormRowLinkView(icon: "globe", color: Color.pink, text: "website", link: "https://mufti.web.app")
            
            FormRowLinkView(icon: "link", color: Color.blue, text: "twitter", link: "https://twitter.com/muftiramdhani25")
            
            FormRowLinkView(icon: "play.rectangle", color: Color.green, text: "course", link: "https://github.com/muftiramdhani25")
          }
          .padding(.vertical, 3)
          
          Section(header: Text("About the Application")){
            FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
            
            FormRowStaticView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "iPhone / iPod")
            
            FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "Mufti Ramdhani")
            
            FormRowStaticView(icon: "paintbrush", firstText: "Designer", secondText: "Edi Sunardi")
            
            FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.0.0")
          }
          .padding(.vertical, 3)
        }
        .listStyle(GroupedListStyle())
        .environment(\.horizontalSizeClass, .regular)
        
        // options + g
        // emoji = control + command + spaci (barengan)
        Text("Copyright © Allright reserved.\nBetter Apps ♡ less code")
          .multilineTextAlignment(.center)
          .font(.footnote)
          .padding(.top, 6)
          .padding(.bottom, 8)
          .foregroundColor(Color.secondary)
      }
      .navigationBarItems(trailing:
                            Button(action: {
                              self.presentationMode.wrappedValue.dismiss()
                            }){
                              Image(systemName: "xmark")
                            })
      .navigationBarTitle("Settings", displayMode: .inline)
      .background(Color("ColorBackground").edgesIgnoringSafeArea(.all))
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView().environmentObject(IconNames())
  }
}
