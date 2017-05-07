@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xsim alu_cascade_sim_behav -key {Behavioral:sim_1:Functional:alu_cascade_sim} -tclbatch alu_cascade_sim.tcl -view D:/Craft/Vivado/alu/alu_sim_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
