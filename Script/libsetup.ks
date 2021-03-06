// functions that are only used on the first boot
@lazyglobal off.
//print "  Loading libsetup".

function copyParams {
    // params.ks
    //local fileList is List().
    local paraFile is "params_" +gShipType +".ks".
    //print "  "+paraFile.
    switch to 1.
    log "" to "1:/params.ks".
    DeletePath("1:/params.ks").

    switch to 0.
    CopyPath("0:params/"+paraFile, "1:/").
    switch to 1.
    MovePath("1:/"+paraFile, "1:/params.ks").
}

function doInitialSetup {
    parameter nameList.

    print "  Initial configuration".
    print "  shipType=" +gShipType.
    switch to 1.
    copyParams().
    set Core:Part:Tag to gShipType+" xx".
    log "switch to 0. run resume." to resume.ks.

    if (nameList:Length > 2) print "  WARNING: Core tag has more than 2 words!".
    if (nameList:Length > 1) {
        print "  Initial mission: "+nameList[1].
        switch to 0.
        run once libmission.
        prepareMission(nameList[1]).
    }
}
