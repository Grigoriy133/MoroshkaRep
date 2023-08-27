//
//  ContentView.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 28.07.2023.
//

import SwiftUI

struct AutorizationView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isAuth = true
    @State private var login = ""
    @State private var password = ""
    @State private var passwordReating = ""
    @State var isShowingTabView = false
    @State var isAlertShowing = false
    @State var alertMessage = ""
    
    var body: some View {
        VStack {
            VStack {
                Text(isAuth ? "Авторизация" : "Регистрация")
                    .padding(.horizontal, 40)
                    .padding(isAuth ? 20 : 40)
                    .background(LinearGradient(colors: [Color("BlueColor"), Color("BlueColor2")], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(20)
                    .foregroundColor(Color.white)
                    .font(.title.bold())
                                }
            Spacer().frame(height: 50)
            VStack(spacing: 20) {
                customView(view: TextField("Введите логин", text: $login), color: Color.white)
                customView(view: SecureField("Введите пароль", text: $password),  color: Color.white)
                if !isAuth {
                    customView(view: SecureField("Повторите пароль", text: $passwordReating),  color: Color.white)
                }
                Spacer().frame(height: 5)
               
                customView(view: Button(isAuth ? "Войти" : "Зарегестрироваться"){
                    if isAuth {
                        
                        AuthService.shared.signIn(email: login, password: password){result in
                            switch result {
                            case .success(_):
                                isShowingTabView.toggle()
                            case .failure(let error):
                                alertMessage = "Ошибка авторизации \(error.localizedDescription)"
                                isAlertShowing.toggle()
                            }
                            
                        }
                 
                    } else {
                        
                        guard password == passwordReating else {
                            self.alertMessage = "Пароли не совпадают"
                            self.isAlertShowing.toggle()
                            return
                        }
                        
                        AuthService.shared.registrate(email: self.login, password: self.password) { result in
                            switch result {
                            case .success(let user):
                                
                                alertMessage = "Вы успешно зарегестрировались \(user)"
                                self.isAlertShowing.toggle()
                                
                                self.login = ""
                                self.password = ""
                                self.passwordReating = ""
                                self.isAuth.toggle()
                                
                            case .failure(let error):
                                alertMessage = "Ошибка регистрации \(error.localizedDescription)"
                                self.isAlertShowing.toggle()
                            }
                            
                        }
                        
                    }
                }, color: Color("mainColor2"))
                .foregroundColor(Color.white)
                
                customView(view: Button(isAuth ? "Регистрация" : "Отмена"){
                   //смена значния
                    isAuth.toggle()
                }, color: Color("mainColor2"))
                .foregroundColor(Color.white)
            }
            .padding(.vertical, 16)
            .background(Color("w"))
            .cornerRadius(15)
            .padding(isAuth ? 30: 10)
        }
        .background(
            Image("back")
            .blur(radius: isAuth ? 0 : 6))
        .animation(Animation.easeInOut(duration: 0.5), value: isAuth)
        .fullScreenCover(isPresented: $isShowingTabView){
            if AuthService.shared.currentUser?.uid == AuthService.shared.adminId {
                AdminView()
            } else {
                let mainTabBarViewModel = MainTabBarViewModel(user: AuthService.shared.currentUser!)
                MainTabView(viewModel: mainTabBarViewModel)
            }
        }
        .alert(alertMessage, isPresented: $isAlertShowing) {
            Button {}
        label: {
            Text("Ok")
        }
        }
    }
    
}

extension AutorizationView {
    func customView<V: View>(view: V, color: Color) -> some View {
           return view
            .frame(maxWidth: .infinity)
            .padding()
            .background(color)
            .cornerRadius(12)
            .padding(.horizontal, 40)
            .multilineTextAlignment(.center)
       }
}
