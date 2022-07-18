//
//  ContentView.swift
//  SwiftUI_GB
//
//  Created by Дмитрий Скок on 18.07.2022.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var login = ""
    @State private var password = ""
    @State private var shouldShowLogo: Bool = true
    
    private let keyboardIsOnPublisher = Publishers.Merge(
        NotificationCenter.default.publisher(
            for: UIResponder.keyboardWillChangeFrameNotification)
            .map{ _ in true},
        NotificationCenter.default.publisher(
            for: UIResponder.keyboardWillHideNotification)
            .map { _ in false}
    )
        .removeDuplicates()
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Image("teahub")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
            }
            
            ScrollView(showsIndicators: false) {
                VStack {
                    if shouldShowLogo {
                        Text("VK Client")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .padding(.top, 32)
                    }
                    
                    VStack {
                        HStack {
                            Text("Login")
                                .foregroundColor(.white)
                            Spacer()
                            TextField("Enter email", text: $login)
                                .frame(maxWidth: 200)
                                .textFieldStyle(.roundedBorder)
                        }
                        
                        HStack {
                            Text("Password")
                                .foregroundColor(.white)
                            Spacer()
                            SecureField("Enter password", text: $password)
                                .frame(maxWidth: 200)
                                .textFieldStyle(.roundedBorder)
                        }
                    }.frame(maxWidth: 300)
                        .padding(.top, 50)
                    Button(action: { print("Hello") }) {
                        Text("Log in")
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .offset(y: 20)
                    .disabled(login.isEmpty || password.isEmpty)
                }
            }
            .onReceive(keyboardIsOnPublisher) { isKeyboardOn in
                withAnimation(Animation.easeInOut(duration: 0.5)) {
                    self.shouldShowLogo = !isKeyboardOn
                }
            }
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
