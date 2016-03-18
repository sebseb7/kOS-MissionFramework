@lazyglobal off.
//print "  Loading libbasic".
run once liborbit.

function warpRails {
    parameter t. 
    print "  warpRails: dt=" +Round(t- Time:Seconds, 1).
    
    local lock countDown to t - Time:Seconds.
//     local ec is Ship:ElectricCharge.
//     if (countDown > 2*ec) {
//         print "  WARNING: low EC".
//         print "    countdown=" +Round(countdown,2).
//         print "    ec=" +Round(ec,2).
//     }
    
    deb("b1").
    set Warp to 0.
    wait 0.01.
    set WarpMode to "RAILS".
    if (countdown >  5) {set Warp to 1. wait 0.1.}
    if (countdown > 25) {set Warp to 2. wait 0.1.}
    if (countdown > 50) {set Warp to 3. wait 0.1.}
    deb("b11").
    
    if (countdown > 5000) {
         set Warp to 6.          // 10k?
         wait until countdown < 5000.
    }
    if (countdown > 500) {
        set Warp to 5.          // 1000x
        until Warp=5 or countdown < 500 {
            wait 0.01.
            set Warp to 5.
        }
        wait until countdown < 500.
    }
    if (countdown > 50) {
        set Warp to 4.          // 100x
        deb("b2").
        until Warp=4 or countdown < 50 {
            wait 0.01.
            set Warp to 4.
        }
        wait until countdown < 50.
    }
    if (countdown > 25) {
        set Warp to 3.          // 50x
        until Warp=3 or countdown < 25 {
            wait 0.01.
            set Warp to 3.
        }
        wait until countdown < 25.
    }
    if (countdown > 5) {
        set Warp to 2.          // 10x
        until Warp=2 or countdown < 5 {
            wait 0.01.
            set Warp to 2.
        }
        wait until countdown < 5.
    }
    if (countdown > 0.5) {
        set Warp to 1.          //  5x
        wait until countdown < 0.5.
    }
    
    set Warp to 0.
    if (countDown < 0)  
      print "  WARNING: warpRails: countdown="+countdown. 
}

function normalizeAngle {
    parameter angle.
    
    until angle > 0 { set angle to angle+360. }
    return Mod( angle+180 , 360) -180.
}

function targetBaseName {
    local tmp is Target:Name:Split(" ").
    return tmp[0].
}

function killRot {
    set WarpMode to "RAILS".
    set Warp to 1.
    wait 0.3.
    set Warp to 0.
}

function vecToString {
    parameter v.
    return "("+Round(V:X, 3) +", " +Round(V:Y, 3) +", "+Round(V:Z, 3) +") m="+Round(v:Mag,2).
}

function getDeltaV {
    // assumptions: only one ISP present
    list engines in tmp.
    local isp is tmp[0]:VacuumIsp.
    local fuel is (Ship:LiquidFuel + Ship:Oxidizer)*0.005.
//     print " getDeltaV".
//     print "  isp="+Round(isp,1).
//     print "  fuel="+Round(fuel,2).
//     print "  lf="+Round(Ship:LiquidFuel).
//     print "  ox="+Round(Ship:Oxidizer).
    return isp * ln(Ship:Mass / (Ship:Mass-fuel))*9.81.
}

global xAxis is VecDrawArgs( V(0,0,0), V(1,0,0), RGB(1.0,0.5,0.5), "X axis", 5, false ).
global yAxis is VecDrawArgs( V(0,0,0), V(0,1,0), RGB(0.5,1.0,0.5), "Y axis", 5, false ).
global zAxis is VecDrawArgs( V(0,0,0), V(0,0,1), RGB(0.5,0.5,1.0), "Z axis", 5, false ).
function debugDirection {
    parameter dir.
    
    set xAxis to VecDrawArgs( V(0,0,0), 2*dir:ForeVector, RGB(1.0,0.5,0.5), "Fore", 5, TRUE ).
    set yAxis to VecDrawArgs( V(0,0,0), 2*dir:TopVector,  RGB(0.5,1.0,0.5), "Top",  5, TRUE ).
    set zAxis to VecDrawArgs( V(0,0,0), 2*dir:StarVector, RGB(0.5,0.5,1.0), "Star", 5, TRUE ).
}
function debugDirectionOff {
    set xAxis to VecDrawArgs( V(0,0,0), V(1,0,0), RGB(1.0,0.5,0.5), "X axis", 5, false ).
    set yAxis to VecDrawArgs( V(0,0,0), V(0,1,0), RGB(0.5,1.0,0.5), "Y axis", 5, false ).
    set zAxis to VecDrawArgs( V(0,0,0), V(0,0,1), RGB(0.5,0.5,1.0), "Z axis", 5, false ).
}

