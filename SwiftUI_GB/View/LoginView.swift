//
//  ContentView.swift
//  SwiftUI_GB
//
//  Created by Дмитрий Скок on 18.07.2022.
//

import SwiftUI
import Combine

struct LoginView: View {
    @State private var login = ""
    @State private var password = ""
    @State private var shouldShowLogo: Bool = true
    @State private var showIncorrectCredentialsWarning = false
    @State var showStartView: Bool = false
    
    private let keyboardIsOnPublisher = Publishers.Merge(
        NotificationCenter.default.publisher(
            for: UIResponder.keyboardWillChangeFrameNotification)
            .map{ _ in true},
        NotificationCenter.default.publisher(
            for: UIResponder.keyboardWillHideNotification)
            .map { _ in false}
    )
        .removeDuplicates()
        .throttle(for: 0.1,
                    scheduler: DispatchQueue.main,
                    latest: true
        )
    
    var body: some View {
        ZStack {
            
            if showStartView {
                FriendsView()
            } else {
            
            GeometryReader { geometry in
                imageBackground
                    .frame(maxWidth: geometry.size.width,
                           maxHeight: geometry.size.height)
            }
            
            ScrollView(showsIndicators: false) {
                VStack {
                    if shouldShowLogo {
                        logo
                            .padding(.top, 32)
                    }
                    
                    VStack {
                        areaLogin
                        areaPassword
                    }
                    .frame(maxWidth: 300)
                        .padding(.top, 50)
                    
                    buttonLogIn
                        .offset(y: 20)
                }
            }
            .onReceive(keyboardIsOnPublisher) { isKeyboardOn in
                withAnimation(Animation.easeInOut(duration: 0.5)) {
                    self.shouldShowLogo = !isKeyboardOn
                }
            }
        }
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .alert(isPresented: $showIncorrectCredentialsWarning,
               content: { Alert(title: Text("Error"),
                                message: Text("Incorrect login or password"),
                                dismissButton: .cancel())})
    }
    
    private func verifyLoginData() {
        if login == "1" && password == "1" {
            
        } else {
            showIncorrectCredentialsWarning = true
        }
        password = ""
    }
    
}


private extension LoginView {
    
    var imageBackground: some View {
        Image("teahub")
            .resizable()
            .edgesIgnoringSafeArea(.all)
            .aspectRatio(contentMode: .fill)
    }
    
    var logo: some View {
        Text("VK Client")
            .fontWeight(.heavy)
            .foregroundColor(.white)
            .font(.largeTitle)
    }
    
    var buttonLogIn: some View {
        Button {
            verifyLoginData()
            showStartView = true
        } label: {
            Text("Log in")
        }
        .buttonStyle(.bordered)
        .background(.white)
        .cornerRadius(10)
        .disabled(login.isEmpty || password.isEmpty)
    }
    
    var areaLogin: some View {
        HStack {
            Text("Login")
                .foregroundColor(.white)
            Spacer()
            TextField("Enter email", text: $login)
                .modifier(ConfigTextField())
        }
    }
    
    var areaPassword: some View {
        HStack {
            Text("Password")
                .foregroundColor(.white)
            Spacer()
            SecureField("Enter password", text: $password)
                .modifier(ConfigTextField())
        }
    }
    
}

struct ConfigTextField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: 200)
            .textFieldStyle(.roundedBorder)
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            LoginView()
    }
}
