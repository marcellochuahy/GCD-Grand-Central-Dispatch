#  GCD-Grand-Central-Dispatch

```
let threadWithHighestPriority = DispatchQueue(label: "br.com.codes.applause.thread_1", qos: .userInteractive)
let thread_2                  = DispatchQueue(label: "br.com.codes.applause.thread_2", qos: .userInitiated)
let thread_3                  = DispatchQueue(label: "br.com.codes.applause.thread_3", qos: .utility)
let threadWithLowestPriority  = DispatchQueue(label: "br.com.codes.applause.thread_4", qos: .background)

threadWithLowestPriority.async  { self.printLoop(icone: "4️⃣🟢", threadName: "QoS: background",      multiplicador: 1) }
thread_3.async                  { self.printLoop(icone: "3️⃣🟡", threadName: "QoS: utility",         multiplicador: 1) }
thread_2.async                  { self.printLoop(icone: "2️⃣🟠", threadName: "QoS: userInitiated",   multiplicador: 1) }
threadWithHighestPriority.async { self.printLoop(icone: "1️⃣🔴", threadName: "QoS: userInteractive", multiplicador: 1) }





