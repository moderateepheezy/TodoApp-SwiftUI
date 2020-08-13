//
//  OnboardingView.swift
//  TodoApp
//
//  Created by Afees Lawal on 04/08/2020.
//

import SwiftUI

struct OnboardingView: View {

    @Binding var getStartedTapped: Bool

    var body: some View {
        GeometryReader { geo in
            VStack{
                Spacer()

                Image("onboarding-logo")
                    .resizable()
                    .frame(width: 186, height: 210)
                    .padding(.top, 60)

                Spacer()

                Text(Str.App.Onboarding.title)
                    .font(.setFont(size: 22, weight: .medium))
                    .foregroundColor(.primaryTextColor)

                Text(Str.App.Onboarding.subtitle)
                    .foregroundColor(.infoColor)
                    .multilineTextAlignment(.center)
                    .font(.setFont(size: 17))
                    .padding(10)

                Spacer()

                Button(action: {
                    self.getStartedTapped.toggle()
                    UserDefaults.standard.set(true, forKey: "firstTimeLogin")
                }){
                    Text(Str.App.Onboarding.getStarted)
                        .font(.setFont(size: 15, weight: .medium))
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50, alignment: .center)
                .foregroundColor(.white)
                .background(TodoGradient().cornerRadius(10))
                .shadow(color: Color.shadowColor, radius: 10, x: 0, y: 5)

                Spacer()

            }
            .padding(.init(top: 0, leading: 30, bottom: 0, trailing: 30))
            .edgesIgnoringSafeArea(.bottom)

        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color.backgroundColor)
        .edgesIgnoringSafeArea(.all)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(getStartedTapped: .constant(true))
            .previewLayout(.device)
            .preferredColorScheme(.light)
    }
}
