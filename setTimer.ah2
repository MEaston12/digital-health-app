#NoTrayIcon
#SingleInstance Force
;; read config
cfgBedTime := IniRead("conf.ini", "consts", "bedTime")
cfgWarnAt := IniRead("conf.ini", "consts", "warnAt")

GetTimeToTarget(target) {
    arr := StrSplit(target, ":")
    hours := arr[1] - A_Hour
    if(hours <= 0) {
        hours += 24
    }
    mins := arr[2] - A_Min
    if(mins <= 0) {
        hours--
        mins += 60
    }

    time := DateAdd(A_Now, hours, "Hours")
    time := DateAdd(time, mins, "Minutes")
    return time
}

timeToBed := DateDiff(GetTimeToTarget(cfgBedTime), A_Now, "Seconds")
timeToWarn := DateDiff(GetTimeToTarget(cfgWarnAt), A_Now, "Seconds")

warnUser() {
    MsgBox("You have ~1 hour before your computer automatically shuts down.  Get ready for bed now.")
}

shutdownComputer() {
    Shutdown(9)
}

SetTimer(warnUser, -1000 * timeToWarn)
SetTimer(shutdownComputer, -1000 * timeToBed)