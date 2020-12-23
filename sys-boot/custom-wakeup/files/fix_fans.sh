#!/bin/bash
cd /sys/devices/platform/nct6775.656/hwmon/hwmon*
echo 1 > pwm1_enable
echo 0 > pwm1 #rear fan doesn't turn completely off
echo 5 > pwm2_enable
echo 5 > pwm5_enable
echo 7 > pwm5_temp_sel #PECI Agent 0
echo 2 > pwm2_temp_sel #CPUTIN
echo 2 > pwm1_temp_sel
cpu_fanspeed=(165 178 191 204 255)
cpu_temp=(50000 60000 70000 75000 80000)
cpu_pwm_points=(pwm2_auto_point?_pwm)
cpu_temp_points=(pwm2_auto_point?_temp)
case_fanspeed=(0 163 198 221 255)
case_temp=(30000 53000 70000 75000 80000)
case_pwm_points=(pwm5_auto_point?_pwm)
case_temp_points=(pwm5_auto_point?_temp)
for ((item=0;item<${#cpu_fanspeed[@]};++item)); do
    echo ${case_fanspeed[item]} > ${case_pwm_points[item]}
    echo ${case_temp[item]} > ${case_temp_points[item]}
    echo ${cpu_fanspeed[item]} > ${cpu_pwm_points[item]}
    echo ${cpu_temp[item]} > ${cpu_temp_points[item]}
done

sudo hdparm -S 6 /dev/sda
sudo hdparm -S 3 /dev/sdb
sudo hdparm -S 3 /dev/sdc
sudo hdparm -S 6 /dev/sdd
