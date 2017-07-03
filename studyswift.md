##Swift
##一、闭包
####一、闭包表达式
场景：对字符串数组排序

```
 let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
 func backward(s1: String, _ s2: String) -> Bool {
    return s1 > s2
 }
 let reversedNames = names.sorted(by:backward)
 print("\(reversedNames)")
 // reversedNames 为 ["Ewa", "Daniella", "Chris", "Barry", "Alex"]

```
描述：在内联闭包表达式中，函数和返回值类型都写在大括号内，而不是大括号外。闭包的函数体部分由关键字in引入。该关键字表示闭包的参数和返回值类型定义已经完成，闭包函数体即将开始。
#####1.语法
```
	{ (parameters) -> returnType in    statements    }

```
例子：

```
    let reversedNames = names.sorted(by:{(s1: String, s2: String) -> Bool in
       return s1 < s2
    })
    
    print("\(reversedNames)")

```
#####2.根据上下文推断类型
描述：因为排序闭包函数是作为 sorted(by:) 方法的参数传入的，Swift 可以推断其参数和返回值的类型。 sorted(b y:) 方法被一个字符串数组调用，因此其参数必须是 (String, String) -> Bool 类型的函数。这意味着ng, String) 和 Bool 类型并不需要作为闭包表达式定义的一部分。因为所有的类型都可以被正确推断，返回箭 头( -> )和围绕在参数周围的括号也可以被省略

#####代码

```
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )

```
提示：实际上，通过内联闭包表达式构造的闭包作为参数传递给函数或方法时，总是能够推断出闭包的参数和返回值类型。这意味着闭包作为函数或者方法的参数时，你几乎不需要利用完整格式构造内联闭包。
#####3.单表达式闭包隐式返回
描述：单行表达式闭包可以通过省略 return 关键字来隐式返回单行表达式的结果，如上版本的例子可以改写为:

```
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )

```
#####4.参数名称缩写
描述：Swift自动为内联闭包提供了参数名称缩写功能，你可以直接通过 $0 ， $1 ， $2 来顺序调用闭包的参数，以此类推。如果你在闭包表达式中使用参数名称缩写，你可以在闭包定义中省略参数列表，并且对应参数名称缩写的类型会通过函数类型进行推断。 in关键字也同样可以被省略，因为此时闭包达式完全由闭包函数体构成:

```
reversedNames = names.sorted(by: { $0 > $1 } )

```
#####3.运算符方法
描述：实际上还有一种更简短的方式来编写上面例子中的闭包表达式。Swift 的 String 类型定义了关于大于 号(>)的字符串实现，其作为一个函数接受两个 String 类型的参数并返回 Bool 类型的值。而这正好与sorted(by:)方法的参数需要的函数类型相符合。因此，你可以简单地传递一个大于号，Swift 可以自动推断出你想使用大于号的字符串函数实现:

```
reversedNames = names.sorted(by: >)

```
####二、尾随闭包
描述：如果你需要将一个很长的闭包表达式作为最后一个参数传递给函数，可以使用尾随闭包来增强函数的可读性。尾随闭包是一个书写在函数括号之后的闭包表达式，函数支持将其作为最后一个参数调用。在使用尾随闭包时，你不用写出它的参数标签:

```
reversedNames = names.sorted() { $0 > $1 }

```
如果闭包表达式是函数或方法的唯一参数，则当你使用尾随闭包时，你甚至可以把 () 省略掉:

```
reversedNames = names.sorted{ $0 > $1 }

```
##二、懒加载
描述：懒加载(lazy load)，即延时加载。首先，懒加载将对象的创建延迟到了用到对象的时候，这样减少了内存开销；其次，懒加载将创建对象、相关属性设置内聚在一个"{}"代码块内，符合“高聚合”的思想。

补充：在swift中懒加载本质是一个闭包，执行顺序是这样的，如果这个lazy修饰的变量没值，就会执行闭包中的东西。
#####语法
######1.完整写法

```
    lazy var mainView : UITableView = { () -> UITableView in
        let temMainView = UITableView()
        return temMainView
    }()

```
######2.简化写法（如果闭包用于懒加载，那么in之前的代码都可以删除，包括in在内）

```
    lazy var mainView : UITableView = {
        let temMainView = UITableView()
        return temMainView
    }()

```

##三、通过字符串创建对象

####一、获取命名空间
场景：Swift中，类名的组成为：命名空间.类名。

```
    guard let nameSpace =  NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as? String else{
        return
    }

```
####二、创建对象

```
    guard let className = NSClassFromString(nameSpace + "." + childControllerName) else{
        return
    }
    
    guard let childViewControllerType = className as? UIViewController.Type else{
        return
    }
    let childViewController = childViewControllerType.init()

```

##三、根据json动态初始化项目

####一、获取命名空间
场景：Swift中，类名的组成为：命名空间.类名。

```
private func jsonSerialization(){
        guard let jsonPath = NSBundle.mainBundle().pathForResource("MainTabBarSettings.json", ofType: nil) else {
            return
        }
        guard let jsonData = NSData(contentsOfFile: jsonPath) else {
            return
        }
        
        guard let anyObject = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) else{
            return
        }
        guard let dictArray = anyObject as? [[String : AnyObject]] else{
            return
        }
        for dict in dictArray {
            guard let vcName = dict["vcName"] as? String else{
                continue
            }
            guard let title = dict["title"] as? String else{
                continue
            }
            guard let imageName = dict["imageName"] as? String else{
                continue
            }
            
            let selectedImageName = imageName + "_highlighted"
            
            addChildViewController(vcName, title: title, normalImageName: imageName, selectedImageName: selectedImageName)
            
        }
    }


```

##四、自定义Log

####一、自定义Log

```
func WBLog<T>(message: T, fileName: String = #file, methodName: String =  #function, lineNumber: Int = #line)
{
    #if DEBUG
        let str : String = (fileName as NSString).pathComponents.last!.stringByReplacingOccurrencesOfString("swift", withString: "")
        print("\(str)\(methodName)[\(lineNumber)]:\(message)")
    #endif
}


```
##五、异常的处理

####一、错误处理
使用采用Error协议的类型来表示错误。

```
enum PrinterError: Error {    case OutOfPaper    case NoToner    case OnFire 
}

```
使用 throw 来抛出一个错误并使用 throws 来表示一个可以抛出错误的函数。如果在函数中抛出一个错误，这个函 数会立刻返回并且调用该函数的代码会进行错误处理。

```
func send(job: Int, toPrinter printerName: String) throws -> String {    if printerName == "Never Has Toner" {        throw PrinterError.noToner    }    return "Job sent"}

```

有多种方式可以用来进行错误处理。一种方式是使用 do-catch 。在 do 代码块中，使用 try 来标记可以抛出错误的代码。在catch代码块中，除非你另外命名，否则错误会自动命名为 error 。

```
do {    let printerResponse = try send(job: 1040, toPrinter: "Bi Sheng")    print(printerResponse)} catch {    print(error)}

```

可以使用多个 catch 块来处理特定的错误。参照 switch 中的 case 风格来写 catch 。

```
do {    let printerResponse = try send(job: 1440, toPrinter: "Gutenberg")   print(printerResponse)} catch PrinterError.onFire {    print("I'll just put this over here, with the rest of the fire.")} catch let printerError as PrinterError {    print("Printer error: \(printerError).")} catch {    print(error)}
```

####二、try?、try!和try的区别？
* try?会将错误转换为可选值，当调用try?＋函数或方法语句时候，如果函数或方法抛出错误，程序不会发崩溃，而返回一个nil，如果没有抛出错误则返回可选值。
* 使用try!可以打破错误传播链条。错误抛出后传播给它的调用者，这样就形成了一个传播链条，但有的时候确实不想让错误传播下去，可以使用try!语句。如果方法出现了异常，那么程序会崩溃。
* 使用try手动捕获异常，do - try - catch方式。

##五、StoryBoard Reference

描述：iOS9之后苹果添加了一个新特性－Storyboard References。便于分离StoryBoard，使开发简化。

使用方法：通过拖动选中他们（高亮显示），然后点击 Xcode 的菜单栏，选择"Editor->Refactor to Storyboard"。

##六、便利构造函数

场景：使用convenience修饰的构造函数叫做便利构造函数，便利构造函数通常用在对系统的类进行构造函数的补充时使用

便利构造函数的特点：

*  便利构造函数通常都是写在extension里面
*  便利构造函数init前面需要加convenience
*  在便利构造函数中需要明确的调用self.init()
