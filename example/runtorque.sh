#!/bin/sh -x
#
#  Startup script.  This is used on linux only.  Its primary purpose is to 
#  set the LD_LIBRARY_PATH environment variable so that ogg/vorbis/openal
#  can be found.
#
#  You can supply "debug" as the first argument to make this script run
#  the debug executable.  Otherwise it defaults to the release executable.
#
#  The script can be run in two ways:
#  chmod +x runscript.sh
#  ./runscript.sh
# 
#  or
#
#  sh runscript.sh
#

# Function to find the real directory a program resides in.
# Feb. 17, 2000 - Sam Lantinga, Loki Entertainment Software
FindPath()
{
    fullpath="`echo $1 | grep /`"
    if [ "$fullpath" = "" ]; then
        oIFS="$IFS"
        IFS=:
        for path in $PATH
        do if [ -x "$path/$1" ]; then
               if [ "$path" = "" ]; then
                   path="."
               fi
               fullpath="$path/$1"
               break
           fi
        done
        IFS="$oIFS"
    fi
    if [ "$fullpath" = "" ]; then
        fullpath="$1"
    fi

    # Is the sed/ls magic portable?
    if [ -L "$fullpath" ]; then
        #fullpath="`ls -l "$fullpath" | awk '{print $11}'`"
        fullpath=`ls -l "$fullpath" |sed -e 's/.* -> //' |sed -e 's/\*//'`
    fi
    dirname $fullpath
}

# Function to suspend the arts daemon.  return 1 if the daemon is/was suspended,
# 0 otherwise
suspendArts()
{
    local sleeptime=1   # seconds to sleep between retries
    local num_retries=3 # max number of retries

    local retry_count=0 # counter
    local status=""     # output of artsshell command

    # do a basic test to see if the necessary programs are available
    status=`artsshell status 2>/dev/null`
    if [ ! $? -eq 0 ]; then
        # oh well
        return 0
    fi

    status=`artsshell status | grep "server status" | awk '{ print $3}'`
    while [ "$status" != "suspended" ] && [ $retry_count -lt $num_retries ]; do
        # sleep if this isn't the first try
        if [ $retry_count -gt 0 ]; then
            sleep $sleeptime
        fi

        # try a suspend
        artsshell suspend 2>/dev/null

        # increment count
        let "retry_count += 1"

        # get status again
        status=`artsshell status | grep "server status" | awk '{ print $3}'`
    done

    # is it suspended now?
    if [ $status = "suspended" ]; then
        return 1
    else
        return 0
    fi
}

# Set the home path if not already set.
if [ "${GAME_HOME_PATH}" = "" ]; then
    GAME_HOME_PATH="`FindPath $0`"
fi

LD_LIBRARY_PATH=.:${GAME_HOME_PATH}/lib:../lib/openal/LINUX:../lib/xiph/linux:${LD_LIBRARY_PATH}

export LD_LIBRARY_PATH

EXENAME=torqueDemo.bin
# if "debug" is the first argument, run the debug exe
if [ "$1" == "debug" ]; then
    EXENAME=torqueDemo_DEBUG.bin
    # get rid of first argument so that it isn't passed to torque
    shift 1
fi

# make sure executable exists
if [ ! -x $EXENAME ]; then
    echo "Executable $EXENAME does not exist."
    exit 1
fi

# try to suspend arts
suspendArts

cd $GAME_HOME_PATH
exec "./$EXENAME" $*

echo "Couldn't run $EXENAME. Is GAME_HOME_PATH correct?"
echo "GAME_HOME_PATH: " $GAME_HOME_PATH
exit 1
