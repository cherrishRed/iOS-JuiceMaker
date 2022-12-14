# ๐ง Juice Maker

## ๋ชฉ์ฐจ

- [ํ๋ก์ ํธ ์๊ฐ](#ํ๋ก์ ํธ-์๊ฐ)
- [ํค์๋](#ํค์๋)
- [STEP 1](#step-1)
- [STEP 2](#step-2)
- [STEP 3](#step-3)
- [STEP 4](#step-4)

## ํ๋ก์ ํธ ์๊ฐ

SwiftUI ๊ณต๋ถ์ ์ผํ์ผ๋ก 6๊ฐ์ ์  UIKit ์ฝ๋์ ๋ฆฌํํ ๋ง ์งํํ์ต๋๋ค.
[์ด์  ํ๋ก์ ํธ ๋ณด๊ธฐ](https://github.com/cherrishRed/ios-juice-maker)

![](https://i.imgur.com/ZALx7zD.png)

**๐ง ์ฃผ์ค๋ฅผ ์ฃผ๋ฌธํ์ธ์!**

**๐ ํ์ ์ด์ฌ๋ ๊ด์ฐฎ์์ ์ฌ๊ณ ๋ฅผ ์์ ํ์ธ์**

**๐ช ๋๋ง์ ์ปค์คํ ์ฃผ์ค๋ฅผ ๋ง๋์ธ์!**

## ํค์๋
`SwiftUI` `Combine` `Custom Button` `Animation`

### ๐ trouble shooting
- ๋ฌผ๊ฒฐ ์ ๋๋ฉ์ด์ ๊ตฌํ
- ๋ฐ์ดํฐ ์ฐ๋

#### ๋ฌผ๊ฒฐ ์ ๋๋ฉ์ด์ ๊ตฌํ
`๐ค๋ฌธ์ `
์๋ฃ์๊ฐ ๋ฌผ๊ฒฐ์น๋ ์ ๋๋ฉ์ด์์ด ์ง์์ ์ผ๋ก ๋ฐ๋ณต๋๋ ์ ๋๋ฉ์ด์์ ๊ตฌํํ๊ณ  ์ถ์์ต๋๋ค. 
Path๋ฅผ ์ด์ฉํ์ง๋ง, ์์ฐ์ค๋ฌ์ด ์ ๋๋ฉ์ด์ ๋ถ๋ถ์ ๋ฌธ์ ๊ฐ ์์์ต๋๋ค.

`๐คํด๊ฒฐ`
์ผ๊ฐํจ์๋ฅผ ์ด์ฉํด ์์ฐ์ค๋ฌ์ด ๋ฌผ์น๋ ์ ๋๋ฉ์ด์์ ๊ตฌํํ์ต๋๋ค. 

```swift
  func path(in rect: CGRect) -> Path {
    return Path { path in
      path.move(to: .zero)
      
      let progressHeight: CGFloat = (1 - progress) * rect.height
      let height = waveHeight * rect.height
      
      for value in stride(from: 0, through: rect.width, by: 2) {
        let x: CGFloat = value
        
        let sine: CGFloat = sin(Angle(degrees: value + offset).radians)/4
        let y: CGFloat = progressHeight + (height * sine)
        path.addLine(to: CGPoint(x: x, y: y))
      }
      
      path.addLine(to: CGPoint(x: rect.width, y: rect.height))
      path.addLine(to: CGPoint(x: 0, y: rect.height))
    }
  }
```

#### ๋ฐ์ดํฐ ์ฐ๋
`๐ค๋ฌธ์ `
StorageView ์์ ๊ณผ์ผ์ ๊ฐ์๋ฅผ ๋ฐ๊พธ๊ณ  ์ ์ฅ ๋ฒํผ์ ๋๋ ์ ๋์๋ง ์ ์ฅ์ ํ๊ณ  ์ถ์๋ฐ, ์๋ฐฉํฅ ๋ฐ์ธ๋ฉ์ด๊ธฐ ๋๋ฌธ์ ๊ฐ์๋ฅผ ์ด๋ํ๊ธฐ๋ง ํ๋ฉด ๋ฐ๋์ด ๋ฒ๋ฆฌ๋ ๋ฌธ์ ๊ฐ ์์์ต๋๋ค. 

`๐คํด๊ฒฐ`
์๋ฐฉํฅ ๋ฐ์ธ๋ฉ์ ๋์ด๋ฒ๋ฆฌ๊ณ , Combine์ ํ์ฉํด ๋จ๋ฐฉํฅ ๋ฐ์ธ๋ฉ์ผ๋ก ์์ ํ์ต๋๋ค. 
`saveStock` ์ด๋ผ๋ ๋ฉ์๋๋ฅผ ๋ง๋ค์ด, ๋ฒํผ์ ๋๋ฅผ ๋๋ง ์ ๋ณด๊ฐ ์ ์ฅ ๋๋๋ก ๋ณ๊ฒฝํ์ต๋๋ค. 
```swift
  func subscriberCellCount() {
    for vm in childrenViewModel {
      
      childrenViewModel[vm.key]?.$count
        .sink(receiveValue: { [weak self] amount in
          self?.stock[vm.key] = amount
        })
        .store(in: &cancelable)
    }
  }
  
  func saveStock() {
    $stock
      .sink { [weak self] changedStock in
      self?.service.change(stock: changedStock)
    }
    .store(in: &cancelable)
  }
```
