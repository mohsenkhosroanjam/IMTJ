************************************************************************************
************************************************************************************
** Title:  MTJ_write.sp
** Author: Jongyeon Kim, VLSI Research Lab @ UMN
** Email:  kimx2889@umn.edu
************************************************************************************
** This run file simulates the dynamic motion of  MTJ.
** # Instruction for simulation
** 1. Set the MTJ dimensions and material parameters.
** 2. Select anisotropy(IMA/PMA) and initial state of free layer(P/AP).
** 3. Adjust bias voltage for Read/Write operation.
** ex. APtoP switching: positive voltage @ ini='1'
**     PtoAP switching: negative voltage @ ini='0'  
************************************************************************************
** # Description of parameters
** lx,ly,lz: width, length, and thickness of free layer
** tox: MgO thickness
** Ms0:saturation magnetizaion at 0K
** P0: polarization factor at 0K 
** alpha: damping factor
** temp: temperature
** MA: magnetic anisotropy (MA=0:In-plane,MA=1:Perpendicular)
**     also sets magnetization in pinned layer, MA=0:[0,1,0],MA=1:[0,0,1]
** ini: initial state of free layer (ini=0:Parallel,ini=1:Anti-parallel)
************************************************************************************

.include 'MTJ_model.inc'

*** Options ************************************************************************
.option post
.save

*** Voltage biasing to MTJ *********************************************************
.param vmtj='vin'
V1 1 0 'vmtj'
V1 1 0 pulse(0 0.7V 0ns 0.01ns 0.01ns 10ns 30ns)

XMTJ1 1 0 MTJ lx='32n' ly='96n' lz='2.44n' Ms0='1210' P0='0.69' alpha='0.0062' Tmp0='358' RA0='5' MA='0' ini='1'


*** Analysis ***********************************************************************
.param pw='170ns' 
.tran 10ns 40.2ns uic


.meas tsw0 when v(XMTJ1.XLLG.My)='0'
.meas iwr find i(XMTJ1.ve1) at 1ns
.meas thermal_stability find v(XMTJ1.XLLG.thste) at 1ns





.end
