
# Mac睡眠模式详解

发表于2021 2019-12-12 |  分类于 [前端](https://www.dazhuanlan.com/frontend/)  |  没有评论

![[./_resources/Mac睡眠模式详解___大专栏.1.resources/unknown_filename.png]]

黑苹果多多少少会遇到睡眠问题，这篇问题简析了下苹果睡眠的原理和使用，这样可以更好的给自己电脑不同的睡眠参数达到应有的效果。
![%E7%9D%A1%E7%9C%A0%E6%A8%A1%E5%BC%8F.png](https://tuchuang-1258561688.cos.ap-chengdu.myqcloud.com/%E7%9D%A1%E7%9C%A0%E6%A8%A1%E5%BC%8F.png)

## <https://www.dazhuanlan.com/2019/12/12/5df16c8212f31/#Mac%E6%89%80%E6%9C%89%E7%9D%A1%E7%9C%A0%E5%8F%82%E6%95%B0>Mac所有睡眠参数

OSX 的睡眠参数，可以打`pmset -g`了解一下你的电脑处在什么睡眠模式下：
![%E7%9D%A1%E7%9C%A0%E6%A8%A1%E5%BC%8F.png](https://tuchuang-1258561688.cos.ap-chengdu.myqcloud.com/%E7%9D%A1%E7%9C%A0%E6%A8%A1%E5%BC%8F.png)

*   `standby`:功能跟autopoweroff一样，不过仅在hibernatemode为3的时候起作用，1是开启 0是关闭。不过LZ一直没搞明白autopoweroff跟standby有什么不一样，按理说应该是不一样的
*   `standbydelay`:启用standby功能的时间，单位也是秒
*   `womp`:网络远程唤醒，1是开启 0是关闭
*   `hibernatefile`:内存镜像存放的地址，这个也可以更改，不过路径必需是root下的路径
*   `halfdim`:显示器睡眠时使显示器亮度改变为当前亮度的一半，1是开启 0是关闭。如果关闭这个功能的话，显示器睡眠会直接关掉显示器。
*   `networksleep`:这个设置影响Mac在睡眠的过程中如何提供网络共享服务，LZ也不太清楚是什么，最好就不要动。
*   `disksleep`:Mac闲置多长时间后关闭硬盘。这个系统偏好里也有，只不过换了一个字眼—如果可能，使硬盘进入睡眠—勾上这个的话系统就会自动根据sleep的时间设一个合适的时间。单位是秒，这个时间不能长于sleep下设置的时间
*   `sleep`:Mac闲置多长时间后进入睡眠，这个系统偏好设置里也有，单位是分钟
*   `autopoweroffdelay`:启用autopoweroff功能的时间，也就是上面说的那个“指定的时间”，单位是秒
*   `hibernatemode`:睡眠模式- `autopoweroff`: 如果Mac处于睡眠状态经过指定的时间后，自动把内存数据写入硬盘，并切断所有部件的电源，进入休眠状态，1是开启 0是关闭。但是LZ发现就算是处于开启状态，这个功能也并没有起作用，你可以不管它，也可以关掉
*   `ttyskeepawake`:远程用户正在活动时防止Mac进入睡眠，1是开启 0是关闭
*   `displaysleep`:Mac闲置多长时间后进入显示器睡眠，2013款Air的系统偏好设置里已经没有这个选项了，Pro是有的，不过其实你可以通过pmset来修改。单位是分钟，这个时间不能长于sleep下设置的时间
*   `lidwake`: 当屏幕掀开的时候唤醒Mac，1是开启 0是关闭
*   `darkwakes`:这个就是Power Nap，你可以在系统偏好设置里选择开或关，跟在这里设置是一样的，1是开启 0是关闭
*   `lessbright`:使用电池时使显示器亮度暗一点，系统偏好设置里也有这个，1是开启 0是关闭
*   `sleepservice`:LZ还没搞清楚这个是干嘛的，请知道的锋友解释下。

## <https://www.dazhuanlan.com/2019/12/12/5df16c8212f31/#%E6%9F%A5%E7%9C%8B%E5%BD%93%E5%89%8D%E7%9D%A1%E7%9C%A0%E6%A8%A1%E5%BC%8F>查看当前睡眠模式

在终端里输入`pmset -g | grep hibernatemode`查看当前睡眠模式

![%E5%BD%93%E5%89%8D%E7%9D%A1%E7%9C%A0%E6%A8%A1%E5%BC%8F.png](https://tuchuang-1258561688.cos.ap-chengdu.myqcloud.com/%E5%BD%93%E5%89%8D%E7%9D%A1%E7%9C%A0%E6%A8%A1%E5%BC%8F.png)
关于各种睡眠模式参数：

*   **0-老式睡眠模式**
    
    > 优点：睡眠期间内存加电，禁用safe sleep（安全睡眠），超快速唤醒，无论是唤醒还是进入睡眠都是1秒内的事情；节省SSD空间和寿命，因为内存数据不写入硬盘，所以硬盘里不会有内存镜像，也不会缩短SSD寿命。
    > 缺点：耗电，因为一直在内存加载电量，随时待命阶段，但是如果在睡眠的过程中电池没电的话，Mac会丢失所有内存种的数据，数据安全性不是很高。
    
*   **1-休眠模式**
    
    > 内存中的数据将写入到磁盘上，系统在所谓的“睡眠”时将完全关闭
    > 因为需要读取先前保存在硬盘中的内存数据，所以唤醒较慢，相当于是Win10的休眠。
    > 优点：休眠时完全关闭电量供应，极度省电。
    > 缺点：休眠和唤醒时间较长。
    
*   **3-睡眠模式**（2005年秋季之后机器默认采用的）
    
    > *   睡眠过程中，内存保持通电状态，同时内存数据在进入睡眠模式之前同样要写入到硬盘
    >     万一没有外接电源并且电池也完全没电了的话，系统将自动进入休眠模式。
    > *   0和1的结合，睡眠时内存数据写入硬盘，同时保持内存供电。这个模式也叫Safe Sleep，是Mac的默认睡眠模式。
    
*   **5-和模式1一样**
    

> 但这是为了那些使用安全虚拟内存的用户 System Preferences -> Security（系统设置-安全）

## <https://www.dazhuanlan.com/2019/12/12/5df16c8212f31/#%E4%BF%AE%E6%94%B9%E5%BD%93%E5%89%8D%E5%8F%82%E6%95%B0>修改当前参数

在终端输入`sudo pmset -电源 参数 数值`

其中电源有4个参数，分别是：`c`、`b`、`u`、`a`，作用是表明这个命令修改的是哪个电源设置下的参数。

> `c`代表外接电源、`b`代表电池、`u`代表UPS、`a`代表所有电源。

参数就是具体的某一项参数，例如你想修改睡眠模式，那就是`hibernatemode`；修改睡眠闲置时间，是`sleep`。

例如你想修改**外接电源**是Mac的**显示器睡眠闲置时间**为10分钟，那就输入：

`sudo pmset -c displaysleep 10`

想修更改**所有电源**下的**硬盘睡眠闲置时间**为15分钟，那就是：

`sudo pmset -a disksleep 15`

> 时间设置上，应该是sleep>=disksleep>=displaysleep，例如分别设置为15 15 10，否则就可能出问题

[小红帽第5集](https://www.dazhuanlan.com/2019/12/12/5df16c860a477/)
[IntelliJ IDEA常用设置 · chanchifeng](https://www.dazhuanlan.com/2019/12/12/5df16c7e188e5/)

    Created at: 2020-12-28T09:33:06+08:00
    Updated at: 2020-12-28T09:33:06+08:00

