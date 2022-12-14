//
//  CustomJuiceView.swift
//  JuiceMaker
//
//  Created by RED on 2022/08/26.
//

import SwiftUI
import Combine

struct CustomJuiceView: View {
  @ObservedObject var viewRouter: ViewRouter
  @ObservedObject var vm: CustomJuiceViewModel
  private var fruits: [Fruit] = Fruit.allCases
  
  init(viewRouter: ViewRouter, vm: CustomJuiceViewModel) {
    self.viewRouter = viewRouter
    self.vm = vm
  }
  
    var body: some View {
      ZStack {
        Rectangle()
          .fill(.yellow)
          .ignoresSafeArea()
      VStack(alignment: .center) {
        VStack(alignment: .leading) {
          Button {
            viewRouter.currentPage = "JuiceMenuView"
          } label: {
            Text("๐ ")
          }
          .buttonStyle(NavButtonStyle(backgroundColor: .white, shadowColor: .blue))
        }
        .frame(width: 300, height: 50, alignment: .leading)
        .padding(.bottom, 30)
        // ์ฃผ์ค ์ด๋ฆ ์๋ ฅ์นธ
        ZStack {
          RoundedRectangle(cornerRadius: 15)
            .fill(.white)
            .frame(width: 250, height: 50, alignment: .center)
          TextField("์ฃผ์ค์ด๋ฆ", text: $vm.juiceName)
            .font(Font.custom("BMJUAOTF", size: 24))
            .multilineTextAlignment(.center)
            .frame(width: 230, height: 50, alignment: .center)
        }
        // ์์
        ZStack {
          RoundedRectangle(cornerRadius: 15)
            .fill(vm.selectedColor)
            .frame(width: 250, height: 50, alignment: .center)
          ColorPicker("์ฃผ์ค ์์", selection: $vm.selectedColor, supportsOpacity: false)
            .frame(width: 230, height: 50, alignment: .center)
            .font(Font.custom("BMJUAOTF", size: 24))
        }
        // ์ฌ๋ฃ ์นธ
        ForEach(vm.recipe.indices, id: \.self) { index in
          IngredientView(vm: vm.childrenViewModel[index])
        }
        // ๋ฒํผ
        Button {
          vm.addNewIngredient()
        } label: {
          Text("PLUS")
            .frame(width: 214)
            .font(Font.custom("BMJUAOTF", size: 20))
        }
        .buttonStyle(SimpleRoundButtonStyle())
        
        Button {
          vm.saveNewJuiceRecipe()
        } label: {
          Text("์๋ก์ด ๋ ์ํผ ์ถ๊ฐ!")
            .font(Font.custom("BMJUAOTF", size: 24))
        }
        .buttonStyle(MyButtonStyle(backgroundColor: .white, shadowColor: .orange))
        .padding(.top, 30)
      }
      .padding()
      .animation(.easeInOut, value: vm.recipe.indices)
      }
    }
}



struct CustomJuiceView_Previews: PreviewProvider {
    static var previews: some View {
      CustomJuiceView(viewRouter: ViewRouter(), vm: CustomJuiceViewModel(service: JuiceService()))
    }
}

//๋ฒํผ ์คํ์ผ
struct SimpleRoundButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding()
      .foregroundColor(configuration.isPressed ? .white : .black)
      .background(configuration.isPressed ? .gray : .white)
      .cornerRadius(15)
  }
}
