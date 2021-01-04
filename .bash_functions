
function fwho()
{
  local name=$1
  whois $name@geektools.com
}

function genpasswd () {
    local RPASSWD=$(dd if=/dev/urandom bs=$1 count=1 2> /dev/null | base64 -w0)
    if [[ $2 = "-n" ]]; then
        echo $RPASSWD | tr -c "[[:alnum:]]"
    else
        echo $RPASSWD
    fi
}

function loong {
    START=$(date +%s.%N)
    $*
    EXIT_CODE=$?
    END=$(date +%s.%N)
    DIFF=$(echo "$END - $START" | bc)
    RES=$(python -c "diff = $DIFF; min = int(diff / 60); print('%s min' % min)")
    result="$1 completed in $RES, exit code $EXIT_CODE."
    echo -e "\n⏰  $result"
    #( say -r 250 $result 2>&1 > /dev/null & )
}

function ipmi_fedora {
    IP=$1
    USER=$2
    PASS=$3

    ipmitool -I lanplus -H ${IP} -U ${USER} -P ${PASS} chassis power off; 
    ipmitool -I lanplus -H ${IP} -U ${USER} -P ${PASS} chassis bootdev bios; 
    ipmitool -I lanplus -H ${IP} -U ${USER} -P ${PASS} chassis power on; 
    ipmitool -I lanplus -H ${IP} -U ${USER} -P ${PASS} sol activate

}

